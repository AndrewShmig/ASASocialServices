//
//  ViewController.m
//  DPSocialServices
//
//  Created by AndrewShmig on 04/09/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize webView = _webView;
@synthesize vk = _vk;

- (void)viewDidLoad {
    [super viewDidLoad];

    CGRect frame = [[UIScreen mainScreen] bounds];
    _webView = [[UIWebView alloc] initWithFrame:frame];
    [_webView setHidden:NO];
    [self.view addSubview:_webView];

    _fb = [[DPVkontakteCommunicator alloc] initWithWebView:_webView];

    [_fb startOnCancelBlock:^{
        NSLog(@"Cancel");
    } onErrorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    } onSuccessBlock:^(DPVkontakteUserAccount *account) {
        NSLog(@"account:%@", account);

        [account setSuccessBlock:^(NSDictionary *dictionary)
        {
            NSLog(@"%@", dictionary);
        }];


    }];
}

@end
