//
//  DPFacebookCommunicator.m
//
//  Created by AndrewShmig on 14.12.12.
//  Copyright (c) 2012 digipeople. All rights reserved.
//

#import "DPFacebookCommunicator.h"
#import "DPFacebookUserAccount.h"

#define LOG_ON 1

#if LOG_ON == 1
# define DEBUG_CURRENT_METHOD() NSLog(@"%s", __FUNCTION__)
# define DEBUG_INFO(x) NSLog(@"%@", x)
#endif

@implementation DPFacebookCommunicator {
    const NSString *_app_id;
    const NSString *_app_secret;

    NSString *_redirect_url;

    UIWebView *_inner_web_view;
    UIActivityIndicatorView *_activity_indicator;

    void (^_cancel_block) (void);
    void (^_error_block) (NSError *);
    void (^_accepted_block) (DPFacebookUserAccount *);
}

#pragma mark - Init methods

- (id)initWithWebView:(UIWebView *)webView
{
    DEBUG_CURRENT_METHOD();

    self = [super init];

    if (self) {
        _app_id = kFACEBOOK_APP_ID;
        _app_secret = kFACEBOOK_APP_SECRET;

        // в качестве возвратного адерса можно взять любую строку
        _redirect_url = @"redirecturl";

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

- (void)startOnCancelBlock:(void (^)())cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(DPFacebookUserAccount *))acceptedBlock
{
    DEBUG_CURRENT_METHOD();


}

#pragma mark - WebView Delegate Methods

- (BOOL)           webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
            navigationType:(UIWebViewNavigationType)navigationType
{
    DEBUG_CURRENT_METHOD();



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

@end
