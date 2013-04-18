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

    [_vk startOnCancelBlock:^{
        NSLog(@"Cancel");
    } onErrorBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    } onSuccessBlock:^(DPVkontakteUserAccount *account) {
        NSLog(@"account:%@", account);

        [account setSuccessBlock:^(NSDictionary *dictionary)
        {
            NSLog(@"===>%@", dictionary);
        }];

        [account photosGetProfileUploadServerWithCustomOptions:@{}];
//
//        NSString *uploadServer = @"http://cs425319.vk.com/upload.php?_query=eyJhY3QiOiJvd25lcl9waG90byIsInNhdmUiOjEsImFwaV93cmFwIjp7InNlcnZlciI6OTk5LCJwaG90byI6IntyZXN1bHR9IiwibWlkIjo1ODQ4Nzg1NywiaGFzaCI6Ijc0NDhmOTNmNDA1ZGZkNWM0NDRmNWQ0YWFiYjg0OTQyIiwibWVzc2FnZV9jb2RlIjoyLCJwcm9maWxlX2FpZCI6LTZ9LCJvaWQiOjU4NDg3ODU3LCJtaWQiOjU4NDg3ODU3LCJzZXJ2ZXIiOjQyNTMxOSwiX29yaWdpbiI6Imh0dHBzOlwvXC9hcGkudmsuY29tIiwiX3NpZyI6IjBjMGFhZjUxYjNlYzY3MGZmZGQ5NDZhMDA5ZjhhZDMyIn0";
//        NSString *photoPath = [[NSBundle mainBundle]
//                                         pathForResource:@"image" ofType:@"jpg"];
//
//        [account uploadPhoto:photoPath
//                       toURL:[NSURL URLWithString:uploadServer]
//                 withOptions:@{}];
    }];
}

@end
