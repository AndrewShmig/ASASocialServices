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

    _vk = [[DPVkontakteCommunicator alloc] initWithWebView:_webView];

    [_vk startOnCancelBlock:^{
        NSLog(@"Cancel");
    } onErrorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    } onSuccessBlock:^(DPVkontakteUserAccount *account) {
        NSLog(@"account:%@", account);

        [account setSuccessBlock:^(NSDictionary *dictionary)
        {
            NSLog(@"response: %@", dictionary);
        }];

//        NSString *photoPath = [[NSBundle mainBundle]
//                                         pathForResource:@"1 (1)" ofType:@"jpg"];

//        [account sendPrivateMessage:@"DPSocialServices in progress"
//                              photo:photoPath
//                           toUserId:@"85885949"];

        [account sendPrivateMessage:@"Why me?"
                 toUserId:@"58487857"];
//        [account uploadPhoto:photoPath];
    }];
}

@end