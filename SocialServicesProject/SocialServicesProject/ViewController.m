//
//  ViewController.m
//  SocialServicesProject
//
//  Created by AndrewShmig on 04/20/13.
//  Copyright (c) 2013 AndrewShmig. All rights reserved.
//

#import "ViewController.h"
#import "ASATwitterMethods.h"


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

    [_tw startOnCancelBlock:nil
               onErrorBlock:nil
             onSuccessBlock:^(ASATwitterUserAccount *account)
             {
                 NSLog(@"account: %@", account);

                 [account performTwitterMethod:kTWITTER_GEO_ID_PLACE_ID_URL
                                    HTTPMethod:@"GET"
                                       options:@{@":place_id": @"1"}//df51dec6f4ee2b2c
                                       success:^(id response)
                                       {
                                           NSLog(@"response: %@", response);
                                       }
                                       failure:^(NSError *error){
                                           NSLog(@"error: %@", error);
                                       }];
             }];
}

@end