//
//  ViewController.m
//  SocialServicesProject
//
//  Created by AndrewShmig on 04/20/13.
//  Copyright (c) 2013 AndrewShmig. All rights reserved.
//

#import "ViewController.h"
#import "DDLog.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    CGRect frame = [[UIScreen mainScreen] bounds];
    _webView = [[UIWebView alloc] initWithFrame:frame];
    [self.view addSubview:_webView];

    _tw = [[ASATwitterCommunicator alloc]
            initWithWebView:_webView];

    [_tw startOnCancelBlock:^
    {
        NSLog(@"cancel");
    }          onErrorBlock:^(NSError *error)
    {
        NSLog(@"error: %@", error);
    }        onSuccessBlock:^(ASATwitterUserAccount *account)
    {
        NSLog(@"account: %@", account);
    }];
}

@end