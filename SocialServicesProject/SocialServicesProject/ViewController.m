//
//  ViewController.m
//  SocialServicesProject
//
//  Created by AndrewShmig on 04/20/13.
//  Copyright (c) 2013 AndrewShmig. All rights reserved.
//

#import "ViewController.h"


NSString *const kTWITTER_CONSUMER_KEY = @"v8146mdwpo05uEroMnhozg";
NSString *const kTWITTER_CONSUMER_SECRET = @"5AFkvjCKxqGBRId2fpSQFLClJLKtGcPGS1DzK7o";


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // устанавливает WebView в нужной позиции и с нужными размерами
    CGRect frame = [[UIScreen mainScreen] bounds];
    _webView = [[UIWebView alloc] initWithFrame:frame];
    [self.view addSubview:_webView];

    // создаем TwitterCommunicator для получения токенов
    _tw = [[ASATwitterCommunicator alloc]
            initWithWebView:_webView];

    // инициируем запрос по получению доступа к пользовательскому аккаунту
    [_tw startOnCancelBlock:^{
        NSLog(@"User canceled app authorization...");
    } onErrorBlock:^(NSError *error) {
        NSLog(@"error during app authorization...%@", error);
    } onSuccessBlock:^(ASATwitterUserAccount *account) {

        [account performTwitterMethod:kTWITTER_USERS_SHOW_URL
                           HTTPMethod:@"GET"
                              options:@{@"screen_name": @"AndrewShmig"}
                              success:^(id response) {
                                  NSLog(@"response: %@", response);
                              } failure:^(NSError *error) {
                                  NSLog(@"error: %@", error);
                              }];
        
    }];
}

@end