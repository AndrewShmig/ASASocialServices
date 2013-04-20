//
//  ViewController.m
//  SocialServicesProject
//
//  Created by AndrewShmig on 04/20/13.
//  Copyright (c) 2013 AndrewShmig. All rights reserved.
//

#import "ViewController.h"
#import "DDLog.h"
#import "ASAVkontakteMethods.h"
#import "ASAVkontakteUserAccount.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation ViewController

@synthesize webView = _webView;
@synthesize vk = _vk;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    CGRect frame = [[UIScreen mainScreen] bounds];
    _webView = [[UIWebView alloc] initWithFrame:frame];
    [self.view addSubview:_webView];

    _vk = [[ASAVkontakteCommunicator alloc]
            initWithWebView:_webView];

    [_vk startOnCancelBlock:^{
        DDLogVerbose(@"Cancel");
    } onSuccessBlock:^(ASAVkontakteUserAccount *account){
        DDLogVerbose(@"%@", account);
    }];
}

@end