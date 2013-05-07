//
//  ASATwitterCommunicator.m
//
//  Created by AndrewShmig on 06.12.12.
//  Copyright (c) 2012 AndrewShmig. All rights reserved.
//

#import "ASATwitterCommunicator.h"
#import "ASATwitterUserAccount.h"
#import "ASATwitterMethods.h"
#import "NSData+toBase64.h"
#import "NSString+HMACSHA1.h"
#import "NSString+encodeURL.h"
#import "ASATwitterCommunicator+Utilities.h"


@implementation ASATwitterCommunicator
{
    ASATwitterUserAccount *_twitterUserAccount;

    // --------- API links
    NSString *_requestTokenURL;
    NSString *_authorizeURL;
    NSString *_accessTokenURL;

    // --------- App keys & secrets
    NSString *_consumerKey;
    NSString *_consumerSecret;

    // --------- callback url
    NSString *_callbackURL;

    // --------- token - first stage
    NSString *_oauthToken;

    // --------- tokens - second stage
    NSString *_secondOauthToken;
    NSString *_oauthVerifier;
    NSString *_oauthTokenSecret;

    // --------- tokens - last stage
    NSString *_finalOauthToken;
    NSString *_finalOauthTokenSecret;

    // ---------
    __weak UIWebView *_innerWebView;
    UIActivityIndicatorView *_activityIndicator;

    // ---------
    void (^_cancelBlock) (void);
    void (^_errorBlock) (NSError *);
    void (^_acceptedBlock) (ASATwitterUserAccount *);
}

#pragma mark - Initialization

- (id)initWithWebView:(UIWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);

    self = [super init];

    if (self) {
        _consumerKey = kTWITTER_CONSUMER_KEY;
        _consumerSecret = kTWITTER_CONSUMER_SECRET;

        _callbackURL = @"";
        _oauthToken = @"";
        _finalOauthTokenSecret = @"";
        _oauthTokenSecret = @""; // temporary - 1-2 stage
        _oauthVerifier = @"";
        _secondOauthToken = @"";
        _twitterUserAccount = nil;

        _requestTokenURL = kTWITTER_OAUTH_REQUEST_TOKEN_URL;
        _authorizeURL = kTWITTER_OAUTH_AUTHENTICATE_URL;
        _accessTokenURL = kTWITTER_OAUTH_ACCESS_TOKEN_URL;

        [self setupWebView:webView];
    }

    return self;
}

#pragma mark - Basic steps to obtain access to users' account

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(ASATwitterUserAccount *))acceptedBlock
{
    NSLog(@"%s", __FUNCTION__);

    [_activityIndicator startAnimating];

    _cancelBlock = cancelBlock;
    _acceptedBlock = acceptedBlock;
    _errorBlock = errorBlock;

    if ([self obtainRequestToken])
        [self obtainVerifierToken];
}

- (BOOL)obtainRequestToken
{
    NSLog(@"%s", __FUNCTION__);

    // generating request body
    NSString *oauth_nonce = [ASATwitterCommunicator generateNonceToken:32];
    NSString *oauth_callback = _callbackURL;

    NSUInteger since1970 = (NSUInteger) [[NSDate date] timeIntervalSince1970];
    NSNumber *timestamp = [NSNumber numberWithUnsignedInteger:since1970];
    NSString *oauth_timestamp = [NSString stringWithFormat:@"%@", timestamp];

    NSString *oauth_consumer_key = _consumerKey;
    NSString *oauth_consumer_secret = _consumerSecret;
    NSString *oauth_signature_method = @"HMAC-SHA1";
    NSString *oauth_version = @"1.0";

    // calculating signature
    NSDictionary *dic = @{
            @"oauth_callback"         : oauth_callback,
            @"oauth_consumer_key"     : oauth_consumer_key,
            @"oauth_nonce"            : oauth_nonce,
            @"oauth_signature_method" : oauth_signature_method,
            @"oauth_timestamp"        : oauth_timestamp,
            @"oauth_version"          : oauth_version
    };

    NSString *signature_base_string = [ASATwitterCommunicator
            generateSignatureBaseString:dic
                  withHTTPRequestMethod:@"POST"
                          andRequestURL:_requestTokenURL];

    NSString *signing_key = [NSString stringWithFormat:@"%@&", oauth_consumer_secret];
    NSString *oauth_signature = [[signature_base_string HMACSHA1:signing_key] toBase64];
    NSString *authorization_header = [NSString stringWithFormat:@"OAuth oauth_consumer_key=\"%@\", oauth_nonce=\"%@\", oauth_signature=\"%@\", oauth_signature_method=\"%@\", oauth_timestamp=\"%@\", oauth_version=\"%@\", oauth_callback=\"%@\"",
                                                                oauth_consumer_key,
                                                                oauth_nonce,
                                                                [oauth_signature encodeURL],
                                                                oauth_signature_method,
                                                                oauth_timestamp,
                                                                oauth_version,
                                                                [oauth_callback encodeURL]];

    NSURL *url = [[NSURL alloc] initWithString:_requestTokenURL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                                         initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:authorization_header forHTTPHeaderField:@"Authorization"];

    NSString *body = [self sendRequest:request];

    // processing Twitter's response
    if (body == nil)
        return NO;

    NSArray *response_parts = [body componentsSeparatedByString:@"&"];
    _oauthToken = [[[response_parts objectAtIndex:0]
                                     componentsSeparatedByString:@"="]
                                     objectAtIndex:1];
    _oauthTokenSecret = [[[response_parts objectAtIndex:1]
                                            componentsSeparatedByString:@"="]
                                            objectAtIndex:1];

    return YES;
}

- (void)obtainVerifierToken
{
    NSLog(@"%s", __FUNCTION__);

    NSString *urlAsString = [NSString stringWithFormat:@"%@?oauth_token=%@",
                                                                   _authorizeURL,
                                                                   _oauthToken];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];

    [_innerWebView loadRequest:request];
}

- (void)obtainAccessToken
{
    NSLog(@"%s", __FUNCTION__);

    // generating request body
    NSString *oauth_nonce = [ASATwitterCommunicator generateNonceToken:32];
    NSString *oauth_callback = _callbackURL;

    NSUInteger since1970 = (NSUInteger) [[NSDate date] timeIntervalSince1970];
    NSNumber *timestamp = [NSNumber numberWithUnsignedInteger:since1970];
    NSString *oauth_timestamp = [NSString stringWithFormat:@"%@", timestamp];

    NSString *oauth_consumer_key = _consumerKey;
    NSString *oauth_consumer_secret = _consumerSecret;
    NSString *oauth_signature_method = @"HMAC-SHA1";
    NSString *oauth_version = @"1.0";
    NSString *oauth_token = _secondOauthToken;

    // calculating signature
    NSDictionary *dic = @{
            @"oauth_callback"         : oauth_callback,
            @"oauth_consumer_key"     : oauth_consumer_key,
            @"oauth_nonce"            : oauth_nonce,
            @"oauth_signature_method" : oauth_signature_method,
            @"oauth_timestamp"        : oauth_timestamp,
            @"oauth_version"          : oauth_version,
            @"oauth_token"            : oauth_token
    };

    NSString *signature_base_string = [ASATwitterCommunicator
            generateSignatureBaseString:dic
                  withHTTPRequestMethod:@"POST"
                          andRequestURL:_accessTokenURL];

    NSString *signing_key = [NSString stringWithFormat:@"%@&%@", oauth_consumer_secret, _oauthTokenSecret];
    NSString *oauth_signature = [[signature_base_string HMACSHA1:signing_key] toBase64];
    NSString *authorization_header = [NSString stringWithFormat:@"OAuth oauth_consumer_key=\"%@\", oauth_nonce=\"%@\", oauth_signature=\"%@\", oauth_signature_method=\"%@\", oauth_timestamp=\"%@\", oauth_version=\"%@\", oauth_callback=\"%@\", oauth_token=\"%@\"",
                                                                oauth_consumer_key,
                                                                oauth_nonce,
                                                                [oauth_signature encodeURL],
                                                                oauth_signature_method,
                                                                oauth_timestamp,
                                                                oauth_version,
                                                                [oauth_callback encodeURL],
                                                                oauth_token];

    NSString *urlAsString = [NSString stringWithFormat:@"%@?oauth_verifier=%@",
                                                                   _accessTokenURL,
                                                                   _oauthVerifier];
    NSURL *url = [[NSURL alloc] initWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setHTTPMethod:@"POST"];
    [request addValue:authorization_header forHTTPHeaderField:@"Authorization"];

    NSString *body = [self sendRequest:request];

    // processing response
    if (body == nil)
        return;

    // parsing server response
    NSArray *parts = [body componentsSeparatedByString:@"&"];
    _finalOauthToken = [[[parts objectAtIndex:0]
                                  componentsSeparatedByString:@"="]
                                  objectAtIndex:1];
    _finalOauthTokenSecret = [[[parts objectAtIndex:1]
                                         componentsSeparatedByString:@"="]
                                         objectAtIndex:1];
    NSString *_user_id = [[[parts objectAtIndex:2]
                                  componentsSeparatedByString:@"="]
                                  objectAtIndex:1];
    NSString *_user_screen_name = [[[parts objectAtIndex:3]
                                           componentsSeparatedByString:@"="]
                                           objectAtIndex:1];

    _twitterUserAccount = [[ASATwitterUserAccount alloc]
                                                 initWithToken:_finalOauthToken
                                                   tokenSecret:_finalOauthTokenSecret
                                                 twitterUserID:_user_id
                                                userScreenName:_user_screen_name];

    _acceptedBlock(_twitterUserAccount);
}

#pragma mark - Processing requests to Twitter

- (NSString *)sendRequest:(NSMutableURLRequest *)request
{
    NSLog(@"%s", __FUNCTION__);

    NSURLResponse *response = nil;
    NSError *error = nil;

    [request addValue:@"application/x-www-form-urlencoded"
   forHTTPHeaderField:@"Content-Type"];

    NSData *response_data = [NSURLConnection sendSynchronousRequest:request
                                                  returningResponse:&response
                                                              error:&error];

    NSString *response_body = [[NSString alloc] initWithData:response_data
                                                    encoding:NSUTF8StringEncoding];

    NSHTTPURLResponse *full_response = (NSHTTPURLResponse *) response;

    if ([full_response statusCode] != 200) {
        error = [NSError
                errorWithDomain:@"ASATwitterCommunicatorErrorDomain"
                           code:-1
                       userInfo:@{NSLocalizedDescriptionKey : response_body}];

        _errorBlock(error);
        return nil;
    }

    return response_body;
}

- (BOOL)           webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
            navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%s", __FUNCTION__);

    NSString *url = [NSString stringWithFormat:@"%@", [request URL]];

    NSString *query;
    NSArray *components = [url componentsSeparatedByString:@"?"];

    if ([components count] > 1)
        query = [url componentsSeparatedByString:@"?"][1];

    // allowing this redirects without processing them
    if ([url hasPrefix:kTWITTER_OAUTH_AUTHENTICATE_URL] ||
            [url hasPrefix:kTWITTER_OAUTH_REQUEST_TOKEN_URL] ||
            [url hasPrefix:kTWITTER_OAUTH_AUTHORIZE_URL])
    {
        return YES;
    }

    // user denied access to his/her Twitter account
    if ([query hasPrefix:@"denied"]) {
        _cancelBlock();
        return NO;
    }

    NSArray *queryParams = [url componentsSeparatedByString:@"&"];
    _secondOauthToken = [queryParams[0] componentsSeparatedByString:@"="][1];
    _oauthVerifier = [queryParams[1] componentsSeparatedByString:@"="][1];

    // Getting access_token
    [self obtainAccessToken];

    return NO; // never executes
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_activityIndicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_activityIndicator startAnimating];
}

#pragma mark - Helpers

- (void)setupWebView:(UIWebView *)webView
{

    NSLog(@"%s", __FUNCTION__);

    _innerWebView = webView;
    [_innerWebView setDelegate:self];

    [self setupActivityIndicator];
}

- (void)setupActivityIndicator
{

    NSLog(@"%s", __FUNCTION__);

    CGPoint centerPoint = [_innerWebView center];
    CGRect frame = CGRectMake(centerPoint.x - 20, centerPoint.y - 50, 30, 30);
    _activityIndicator = [[UIActivityIndicatorView alloc]
                                                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_activityIndicator setColor:[UIColor darkGrayColor]];
    [_activityIndicator setFrame:frame];
    [_activityIndicator setHidesWhenStopped:YES];
    [_activityIndicator setHidden:NO];

    [_innerWebView addSubview:_activityIndicator];
}

@end
