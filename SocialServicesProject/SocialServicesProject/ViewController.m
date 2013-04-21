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

        [account performVKMethod:kVKAudioGetUploadServer
                         options:@{}
                         success:^(NSDictionary *dictionary)
                         {
                             NSString *audioPath = [[NSBundle mainBundle]
                                                              pathForResource:@"sample"
                                                                       ofType:@"mp3"];

                             [account uploadAudio:audioPath
                                            toURL:[NSURL URLWithString:dictionary[@"response"][@"upload_url"]]
                                      withOptions:@{}
                                          success:^(NSDictionary *dictionary)
                                          {
                                              NSString *server = dictionary[@"server"];
                                              NSString *audio = dictionary[@"audio"];
                                              NSString *hash = dictionary[@"hash"];

                                              [account performVKMethod:kVKAudioSave
                                                               options:@{@"server" : server,
                                                                         @"audio"  : audio,
                                                                         @"hash"   : hash}
                                                               success:^(
                                                                       NSDictionary *dictionary)
                                                               {
                                                                   NSLog(@"OK!");
                                                                   NSLog(@"response: %@", dictionary);
                                                               }
                                                               failure:nil];
                                          }
                                          failure:nil];
                         }
                         failure:nil];
    }];
}

@end