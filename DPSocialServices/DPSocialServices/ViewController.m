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

    DPVkontakteUserAccount *user;
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]
                    objectForKey:@"accessToken"];
    user = [[DPVkontakteUserAccount alloc]
            initUserAccountWithAccessToken:accessToken
                                    userId:@"58487857"];

    [user setSuccessBlock:^(NSDictionary *dictionary)
    {
        NSLog(@"====>%@<====", dictionary);
    }];

    [user friendsGetOnlineWithCustomOptions:@{@"uid" : @"58487857"}];

//    _vk = [[DPVkontakteCommunicator alloc] initWithWebView:_webView];
//
//    [_vk startOnCancelBlock:^{
//        NSLog(@"Cancel");
//    } onErrorBlock:^(NSError *error) {
//        NSLog(@"Error: %@", error);
//    } onSuccessBlock:^(DPVkontakteUserAccount *account) {
//        NSLog(@"account:%@", account);
//
//        [[NSUserDefaults standardUserDefaults]
//                setObject:[account accessToken] forKey:@"accessToken"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//
//        [account setSuccessBlock:^(NSDictionary *dictionary)
//        {
//            NSLog(@"====> %@ <=====", dictionary);
//        }];
//
//        [account friendsGetWithCustomOptions:@{@"uid" : @"1"}];
//    }];
}

@end
