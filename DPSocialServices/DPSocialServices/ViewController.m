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

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = [[UIScreen mainScreen] bounds];
    _webView = [[UIWebView alloc] initWithFrame:frame];
    [_webView setHidden:NO];
    [self.view addSubview:_webView];

    _vk = [[DPVkontakteCommunicator alloc] initWithWebView:_webView];

    DPVkontakteUserAccount *user;
    NSString *accessToken = [[NSUserDefaults standardUserDefaults]
                                             objectForKey:@"accessToken"];
    NSInteger userId = [[[NSUserDefaults standardUserDefaults]
                                         objectForKey:@"userId"] integerValue];
    user = [[DPVkontakteUserAccount alloc]
                                    initUserAccountWithAccessToken:accessToken
                                                            userId:userId];

    NSLog(@"%@", user);

    [user setSuccessBlock:^(NSDictionary *dictionary)
    {
        NSLog(@"%@", dictionary);
    }];

    NSDictionary *options = @{@"uid":@"1"};
//    [user usersGetWithCustomOptions:@{@"uid":@"1"}]; // Zombie
    [user usersGetWithCustomOptions:options]; // Not zombie

//    __block NSDictionary *options = @{};
//
//    [_vk startOnCancelBlock:^{
//        NSLog(@"Cancel");
//    } onErrorBlock:^(NSError *error) {
//        NSLog(@"Error: %@", error);
//    } onSuccessBlock:^(DPVkontakteUserAccount *account) {
//        NSLog(@"account:%@", account);
//
//        [account setSuccessBlock:^(NSDictionary *dictionary)
//        {
//            NSLog(@"%@", dictionary);
//        }];
//
//        [account docsGetUploadServerWithCustomOptions:options];
//    }];
}

@end
