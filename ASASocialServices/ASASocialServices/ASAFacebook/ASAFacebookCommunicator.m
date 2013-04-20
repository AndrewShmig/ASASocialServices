//
//  ASAFacebookCommunicator.m
//
//  Created by AndrewShmig on 14.12.12.
//

#import "ASAFacebookCommunicator.h"
#import "ASAFacebookUserAccount.h"
#import "NSString+encodeURL.h"

#define LOG_ON 1

#if LOG_ON == 1
# define DEBUG_CURRENT_METHOD() NSLog(@"%s", __FUNCTION__)
#endif

@implementation ASAFacebookCommunicator
{
    const NSString *_app_id;
    const NSString *_app_secret;

    NSString *_redirect_url;
    NSString *_state;
    NSString *_code;
    NSString *_access_token;
    NSUInteger _expires_in;

    UIWebView *_inner_web_view;
    UIActivityIndicatorView *_activity_indicator;

    void (^_cancel_block) (void);
    void (^_error_block) (NSError *);
    void (^_accepted_block) (ASAFacebookUserAccount *);
}

#pragma mark - Init methods

- (id)initWithWebView:(UIWebView *)webView
{
    DEBUG_CURRENT_METHOD();

    self = [super init];

    if (self) {
        _app_id = kFACEBOOK_APP_ID;
        _app_secret = kFACEBOOK_APP_SECRET;

        // в качестве возвратного адреса можно взять любую строку
        _redirect_url = [@"http://m.digipeople.ru/" encodeURL];
        _state = [self generateState];
        _code = @"";
        _access_token = @"";
        _expires_in = 0;

        _inner_web_view = webView;
        [_inner_web_view setDelegate:self];

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

    return self;
}

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(ASAFacebookUserAccount *))acceptedBlock
{
    DEBUG_CURRENT_METHOD();

    _error_block = [errorBlock copy];
    _cancel_block = [cancelBlock copy];
    _accepted_block = [acceptedBlock copy];

    // showing login dialog
    [self redirectToLoginDialog];
}

#pragma mark - WebView Delegate Methods

- (BOOL)           webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
            navigationType:(UIWebViewNavigationType)navigationType
{
    DEBUG_CURRENT_METHOD();

    NSLog(@"URL: %@", [request URL]);

    NSURL *requestURL = [request URL];
    NSString *url = [NSString stringWithFormat:@"%@", requestURL];
    NSString *currentURLQuery = [requestURL query];

    if ([url hasPrefix:_redirect_url] ||
            [currentURLQuery hasPrefix:@"code"]) {

        NSArray *queryParams = [currentURLQuery componentsSeparatedByString:@"&"];
        NSMutableDictionary *queryKeyedParams = [NSMutableDictionary dictionary];

        [queryParams enumerateObjectsUsingBlock:^(id obj,
                                                  NSUInteger idx,
                                                  BOOL *stop)
        {
            NSString *key = [obj componentsSeparatedByString:@"="][0];
            NSString *value = [obj componentsSeparatedByString:@"="][1];

            [queryKeyedParams setObject:value
                                 forKey:key];
        }];

        if([queryKeyedParams objectForKey:@"code"] != nil) { // Accepted app

            _code = queryKeyedParams[@"code"];

            [self exchangeCodeForAccessToken];
        } else { // Declined app
            _cancel_block();
        }

        return NO;
    }

    if([[url encodeURL] hasPrefix:_redirect_url])
        return NO;

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    DEBUG_CURRENT_METHOD();

    [_activity_indicator setHidden:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    DEBUG_CURRENT_METHOD();

    [_activity_indicator setHidden:NO];
}

#pragma mark - private methods

- (void)exchangeCodeForAccessToken
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *tokenURLAsString = [NSMutableString string];
    [tokenURLAsString appendString:@"https://graph.facebook.com/oauth/access_token?"];
    [tokenURLAsString appendFormat:@"client_id=%@&", kFACEBOOK_APP_ID];
    [tokenURLAsString appendFormat:@"redirect_uri=%@&", _redirect_url];
    [tokenURLAsString appendFormat:@"client_secret=%@&", kFACEBOOK_APP_SECRET];
    [tokenURLAsString appendFormat:@"code=%@", _code];

    NSLog(@"URL: %@", tokenURLAsString);

    NSURL *url = [NSURL URLWithString:tokenURLAsString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];

    if(error != nil) {
        _error_block(error);
        return;
    }

    if([(NSHTTPURLResponse *)response statusCode] != 200) {
        error = [NSError errorWithDomain:@"DPFacebookCommunicatorErrorDomain"
                                    code:-1
                                userInfo:@{NSLocalizedDescriptionKey : @"Error while exchanging code for access token.",
                                           @"response"               : [NSString stringWithCString:[responseData bytes]
                                                                                          encoding:NSUTF8StringEncoding]}];

        _error_block(error);
        return;
    }

    NSString *responseBody = [NSString stringWithCString:[responseData bytes]
                                                encoding:NSUTF8StringEncoding];

    NSLog(@"Response body: %@", responseBody);

    NSArray *parts = [responseBody componentsSeparatedByString:@"&"];
    _access_token = [parts[0] componentsSeparatedByString:@"="][1];
    _expires_in = (NSUInteger)[[parts[1] componentsSeparatedByString:@"="][1] integerValue];

    ASAFacebookUserAccount *facebookUserAccount;
    facebookUserAccount = [[ASAFacebookUserAccount alloc]
            initWithAccessToken:_access_token
                 expirationTime:_expires_in];

    _accepted_block(facebookUserAccount);
}

- (NSString *)generateState
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *all_chars = @"QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890";

    srand(time(NULL));
    for (int i = 0; i < 32; i++) {
        NSUInteger index = (NSUInteger)(rand() % ([all_chars length] - 1));
        [result appendString:[NSString stringWithFormat:@"%c",
                                                        [all_chars characterAtIndex:index]]];
    }

    return result;
}

- (void)redirectToLoginDialog
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlToRedirectTo = [NSMutableString string];
    [urlToRedirectTo appendString:@"https://www.facebook.com/dialog/oauth?"];
    [urlToRedirectTo appendString:[NSString stringWithFormat:@"client_id=%@&redirect_uri=%@&state=%@&scope=%@",
                                                             kFACEBOOK_APP_ID,
                                                             _redirect_url,
                                                             _state,
                                                             kFACEBOOK_PERMISSIONS]];

    NSLog(@"URL: %@", urlToRedirectTo);

    NSURL *url = [NSURL URLWithString:urlToRedirectTo];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [_inner_web_view loadRequest:request];
}

@end
