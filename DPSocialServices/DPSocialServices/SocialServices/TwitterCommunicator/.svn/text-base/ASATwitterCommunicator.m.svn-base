//
//  DPTwitterCommunicator.m
//
//  Created by AndrewShmig on 06.12.12.
//  Copyright (c) 2012 AndrewShmig. All rights reserved.
//

#import "DPTwitterCommunicator.h"
#import "DPTwitterUserAccount.h"

static const NSString *kTwitterCommunicatorErrorDomain = @"kTwitterCommunicatorErrorDomain";

enum
{
    TwitterCommunicatorRequestError = -1
};

@implementation DPTwitterCommunicator
{
    DPTwitterUserAccount *_twitterUserAccount;

    // --------- API links
    NSString *_request_token_URL;
    NSString *_authorize_URL;
    NSString *_access_token_URL;

    // --------- App keys & secrets
    NSString *_consumer_key;
    NSString *_consumer_secret;

    // --------- callback url
    NSString *_callback_URL;

    // --------- token - first stage
    NSString *_oauth_token;

    // --------- tokens - second stage
    NSString *_second_oauth_token;
    NSString *_oauth_verifier;
    NSString *_oauth_token_secret;

    // --------- tokens - last stage
    NSString *_final_oauth_token;
    NSString *_final_oauth_token_secret;

    // ---------
    __weak UIWebView *_inner_web_view;
    UIActivityIndicatorView *_activity_indicator;

    // ---------
    void (^_cancel_block) (void);

    void (^_error_block) (NSError *);

    void (^_accepted_block) (DPTwitterUserAccount *);
}

#pragma mark - Initialization

- (id)initWithWebView:(UIWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);

    self = [super init];

    if (self) {
        _consumer_key = [kTWITTER_CONSUMER_KEY copy];
        _consumer_secret = [kTWITTER_CONSUMER_SECRET copy];

        _callback_URL = @"";
        _oauth_token = @"";
        _final_oauth_token_secret = @"";
        _oauth_token_secret = @""; // temporary - 1-2 stage
        _oauth_verifier = @"";
        _second_oauth_token = @"";
        _twitterUserAccount = nil;

        _request_token_URL = kTWITTER_REQUEST_TOKEN_URL;
        _authorize_URL = kTWITTER_AUTHENTICATE_URL;
        _access_token_URL = kTWITTER_ACCESS_TOKEN_URL;

        [self setupWebView:webView];
    }

    return self;
}

- (void)setWebView:(UIWebView *)webView
{

    [_activity_indicator removeFromSuperview];

    [self setupWebView:webView];
}

#pragma mark - Basic steps to obtain access to users' account

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(DPTwitterUserAccount *))acceptedBlock
{
    NSLog(@"%s", __FUNCTION__);

    [_activity_indicator startAnimating];

    _cancel_block = [cancelBlock copy];
    _accepted_block = [acceptedBlock copy];
    _error_block = [errorBlock copy];

    if ([self obtainRequestToken])
        [self obtainVerifierToken];
}

- (BOOL)obtainRequestToken
{
    NSLog(@"%s", __FUNCTION__);

    // generating request body
    NSString *oauth_nonce = [DPTwitterCommunicator generateNonceToken:32];
    NSString *oauth_callback = _callback_URL;

    NSNumber *timestamp = [NSNumber numberWithInt:[[NSDate date]
                                                           timeIntervalSince1970]];
    NSString *oauth_timestamp = [NSString stringWithFormat:@"%@", timestamp];

    NSString *oauth_consumer_key = _consumer_key;
    NSString *oauth_consumer_secret = _consumer_secret;
    NSString *oauth_signature_method = @"HMAC-SHA1";
    NSString *oauth_version = @"1.0";

    // calculating signature
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:oauth_callback forKey:@"oauth_callback"];
    [dic setObject:oauth_consumer_key forKey:@"oauth_consumer_key"];
    [dic setObject:oauth_nonce forKey:@"oauth_nonce"];
    [dic setObject:oauth_signature_method forKey:@"oauth_signature_method"];
    [dic setObject:oauth_timestamp forKey:@"oauth_timestamp"];
    [dic setObject:oauth_version forKey:@"oauth_version"];

    NSString *signature_base_string = [DPTwitterCommunicator
            generateSignatureBaseString:dic
                  withHTTPRequestMethod:@"POST"
                          andRequestURL:_request_token_URL];

    NSString *signing_key = [NSString stringWithFormat:@"%@&",
                                                       oauth_consumer_secret];
    NSString *oauth_signature = [[signature_base_string HMACSHA1:signing_key]
                                                        toBase64];

    NSString *authorization_header = [NSString stringWithFormat:@"OAuth oauth_consumer_key=\"%@\", oauth_nonce=\"%@\", oauth_signature=\"%@\", oauth_signature_method=\"%@\", oauth_timestamp=\"%@\", oauth_version=\"%@\", oauth_callback=\"%@\"",
                                                                oauth_consumer_key,
                                                                oauth_nonce,
                                                                [oauth_signature encodeURL],
                                                                oauth_signature_method,
                                                                oauth_timestamp,
                                                                oauth_version,
                                                                [oauth_callback encodeURL]];

    NSURL *url = [[NSURL alloc] initWithString:_request_token_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                                         initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:authorization_header forHTTPHeaderField:@"Authorization"];

    NSString *body = [self sendRequest:request];

    // processing Twitter's response
    if (body == nil)
        return NO;

    NSArray *response_parts = [body componentsSeparatedByString:@"&"];
    _oauth_token = [[[response_parts objectAtIndex:0]
                                     componentsSeparatedByString:@"="]
                                     objectAtIndex:1];
    _oauth_token_secret = [[[response_parts objectAtIndex:1]
                                            componentsSeparatedByString:@"="]
                                            objectAtIndex:1];

#ifdef DEBUG
    NSLog(@"--------Getting request token-----------------");
    NSLog(@"_oauth_token = %@", _oauth_token);
    NSLog(@"_oauth_token_secret = %@", _oauth_token_secret);
#endif

    return YES;
}

- (void)obtainVerifierToken
{
    NSLog(@"%s", __FUNCTION__);

    NSURL *url = [[NSURL alloc]
                         initWithString:[NSString stringWithFormat:@"%@?oauth_token=%@",
                                                                   _authorize_URL,
                                                                   _oauth_token]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                                         initWithURL:url];
    [request setHTTPMethod:@"GET"];

    [_inner_web_view loadRequest:request];
}

- (void)obtainAccessToken
{
    NSLog(@"%s", __FUNCTION__);

    // generating request body
    NSString *oauth_nonce = [DPTwitterCommunicator generateNonceToken:32];
    NSString *oauth_callback = _callback_URL;

    NSNumber *timestamp = [NSNumber numberWithInt:[[NSDate date]
                                                           timeIntervalSince1970]];
    NSString *oauth_timestamp = [NSString stringWithFormat:@"%@", timestamp];

    NSString *oauth_consumer_key = _consumer_key;
    NSString *oauth_consumer_secret = _consumer_secret;
    NSString *oauth_signature_method = @"HMAC-SHA1";
    NSString *oauth_version = @"1.0";
    NSString *oauth_token = _second_oauth_token;

    // calculating signature
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:oauth_callback forKey:@"oauth_callback"];
    [dic setObject:oauth_consumer_key forKey:@"oauth_consumer_key"];
    [dic setObject:oauth_nonce forKey:@"oauth_nonce"];
    [dic setObject:oauth_signature_method forKey:@"oauth_signature_method"];
    [dic setObject:oauth_timestamp forKey:@"oauth_timestamp"];
    [dic setObject:oauth_version forKey:@"oauth_version"];
    [dic setObject:oauth_token forKey:@"oauth_token"];

    NSString *signature_base_string = [DPTwitterCommunicator generateSignatureBaseString:dic
                                                                   withHTTPRequestMethod:@"POST"
                                                                           andRequestURL:_access_token_URL];

    NSString *signing_key = [NSString stringWithFormat:@"%@&%@",
                                                       oauth_consumer_secret,
                                                       _oauth_token_secret];
    NSString *oauth_signature = [[signature_base_string HMACSHA1:signing_key]
                                                        toBase64];

    NSString *authorization_header = [NSString stringWithFormat:@"OAuth oauth_consumer_key=\"%@\", oauth_nonce=\"%@\", oauth_signature=\"%@\", oauth_signature_method=\"%@\", oauth_timestamp=\"%@\", oauth_version=\"%@\", oauth_callback=\"%@\", oauth_token=\"%@\"",
                                                                oauth_consumer_key,
                                                                oauth_nonce,
                                                                [oauth_signature encodeURL],
                                                                oauth_signature_method,
                                                                oauth_timestamp,
                                                                oauth_version,
                                                                [oauth_callback encodeURL],
                                                                oauth_token];

    NSURL *url = [[NSURL alloc]
                         initWithString:[NSString stringWithFormat:@"%@?oauth_verifier=%@",
                                                                   _access_token_URL,
                                                                   _oauth_verifier]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                                         initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:authorization_header forHTTPHeaderField:@"Authorization"];

    NSString *body = [self sendRequest:request];

    // processing response
    if (body == nil) return;

    // parsing server response
    NSArray *parts = [body componentsSeparatedByString:@"&"];
    _final_oauth_token = [[[parts objectAtIndex:0]
                                  componentsSeparatedByString:@"="]
                                  objectAtIndex:1];
    _final_oauth_token_secret = [[[parts objectAtIndex:1]
                                         componentsSeparatedByString:@"="]
                                         objectAtIndex:1];
    NSString *_user_id = [[[parts objectAtIndex:2]
                                  componentsSeparatedByString:@"="]
                                  objectAtIndex:1];
    NSString *_user_screen_name = [[[parts objectAtIndex:3]
                                           componentsSeparatedByString:@"="]
                                           objectAtIndex:1];

#ifdef DEBUG
    NSLog(@"-----------Getting access token----------------");
    NSLog(@"_final_oauth_token = %@", _final_oauth_token);
    NSLog(@"_final_oauth_token_secret = %@", _final_oauth_token_secret);
#endif

    _twitterUserAccount = [[DPTwitterUserAccount alloc]
                                                 initWithToken:_final_oauth_token
                                                   tokenSecret:_final_oauth_token_secret
                                                 twitterUserID:_user_id
                                                userScreenName:_user_screen_name];

    _accepted_block(_twitterUserAccount);
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
                errorWithDomain:kTwitterCommunicatorErrorDomain
                           code:TwitterCommunicatorRequestError
                       userInfo:@{NSLocalizedDescriptionKey : response_body}];

        _error_block(error);
        return nil;
    }

    return response_body;
}

- (BOOL)           webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
            navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%s", __FUNCTION__);

#ifdef DEBUG
    NSLog(@"Current request URL: %@", [request URL]);
#endif

    NSString *url = [NSString stringWithFormat:@"%@", [request URL]];

    NSString *query;
    NSArray *components = [url componentsSeparatedByString:@"?"];

    if ([components count] > 1)
        query = [url componentsSeparatedByString:@"?"][1];

    // allowing this redirects without processing them
    if ([url hasPrefix:kTWITTER_AUTHENTICATE_URL] ||
            [url hasPrefix:kTWITTER_REQUEST_TOKEN_URL] ||
            [url hasPrefix:kTWITTER_AUTHORIZE_URL] ||
            [url hasPrefix:kTWITTER_LOGOUT_URL])
    {
        return YES;
    }

    // user denied access to his/her Twitter account
    if ([query hasPrefix:@"denied"]) {
        _cancel_block();
        return NO;
    }

    NSArray *queryParams = [url componentsSeparatedByString:@"&"];
    _second_oauth_token = [queryParams[0] componentsSeparatedByString:@"="][1];
    _oauth_verifier = [queryParams[1] componentsSeparatedByString:@"="][1];

#ifdef DEBUG
    NSLog(@"-------Getting oauth token and oauth verifier ---------");
    NSLog(@"_second_oauth_token = %@", _second_oauth_token);
    NSLog(@"_oauth_verifier = %@", _oauth_verifier);
#endif

    // Getting access_token
    [self obtainAccessToken];

    return NO; // never executes
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_activity_indicator stopAnimating];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s", __FUNCTION__);

    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_activity_indicator startAnimating];
}

#pragma mark - Helpers

- (void)setupWebView:(UIWebView *)webView
{

    NSLog(@"%s", __FUNCTION__);

    _inner_web_view = webView;
    [_inner_web_view setDelegate:self];

    [self setupActivityIndicator];
}

- (void)setupActivityIndicator
{

    NSLog(@"%s", __FUNCTION__);

    CGPoint centerPoint = [_inner_web_view center];
    CGRect frame = CGRectMake(centerPoint.x - 20, centerPoint.y - 50, 30, 30);
    _activity_indicator = [[UIActivityIndicatorView alloc]
                                                    initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [_activity_indicator setColor:[UIColor darkGrayColor]];
    [_activity_indicator setFrame:frame];
    [_activity_indicator setHidesWhenStopped:YES];
    [_activity_indicator setHidden:NO];

    [_inner_web_view addSubview:_activity_indicator];
}

+ (NSString *)generateNonceToken:(NSInteger)length
{
    NSLog(@"%s", __FUNCTION__);

    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *all_chars = @"QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890";

    srand(time(NULL));
    for (int i = 0; i < length; i++) {
        int index = rand() % ([all_chars length] - 1);
        [result appendString:[NSString stringWithFormat:@"%c",
                                                        [all_chars characterAtIndex:index]]];
    }

    return result;
}

/*
 Creating the signature base string
 
 The three values collected so far must be joined to make a single string, from which the signature will be generated. This is called the signature base string by the OAuth specification.
 
 To encode the HTTP method, base URL, and parameter string into a single string:
 
 * Convert the HTTP Method to uppercase and set the output string equal to this value.
 * Append the '&' character to the output string.
 * Percent encode the URL and append it to the output string.
 * Append the '&' character to the output string.
 * Percent encode the parameter string and append it to the output string.
 */

+ (NSString *)generateSignatureBaseString:(NSDictionary *)keyValuePairs
                    withHTTPRequestMethod:(NSString *)requestMethod
                            andRequestURL:(NSString *)requestURL
{
    NSLog(@"%s", __FUNCTION__);

    requestMethod = [requestMethod uppercaseString];

    // percent encoding each key-value
    NSMutableDictionary *new_dictionary = [[NSMutableDictionary alloc] init];
    [keyValuePairs enumerateKeysAndObjectsUsingBlock:^(id key,
                                                       id obj,
                                                       BOOL *stop)
    {
        NSString *new_key = [key encodeURL];
        NSString *new_value = [obj encodeURL];

        [new_dictionary setObject:new_value forKey:new_key];
    }];

    // sorting values
    NSMutableArray *sorted_array = [[NSMutableArray alloc] init];
    [new_dictionary enumerateKeysAndObjectsUsingBlock:^(id key,
                                                        id obj,
                                                        BOOL *stop)
    {
        [sorted_array addObject:key];
    }];

    sorted_array = [NSMutableArray arrayWithArray:[sorted_array sortedArrayUsingComparator:^NSComparisonResult (
            id obj1,
            id obj2)
    {
        NSString *str1 = (NSString *) obj1;
        NSString *str2 = (NSString *) obj2;

        return [str1 compare:str2];
    }]];

    // concatenating key-values
    NSMutableString *parameter_string = [[NSMutableString alloc] init];
    [sorted_array enumerateObjectsUsingBlock:^(id obj,
                                               NSUInteger idx,
                                               BOOL *stop)
    {
        [parameter_string appendString:[NSString stringWithFormat:@"%@=%@&",
                                                                  obj,
                                                                  [new_dictionary objectForKey:obj]]];
    }];

    // removing last char
    NSRange range;
    range.location = [parameter_string length] - 1;
    range.length = 1;
    [parameter_string deleteCharactersInRange:range];
    parameter_string = [NSMutableString stringWithString:[parameter_string encodeURL]];

    // generating signature base string
    NSMutableString *signature_base_string = [[NSMutableString alloc] init];
    [signature_base_string appendString:requestMethod];
    [signature_base_string appendString:@"&"];
    [signature_base_string appendString:[requestURL encodeURL]];
    [signature_base_string appendString:@"&"];
    [signature_base_string appendString:parameter_string];

    return signature_base_string;
}

@end
