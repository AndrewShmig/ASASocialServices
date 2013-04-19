//
//  DPTwitterCommunicator.h
//
//  Created by AndrewShmig on 06.12.12.
//  Copyright (c) 2012 AndrewShmig. All rights reserved.
//
//
//  Класс используется для прохождения OAuth авторизации пользователя Твиттера
//  Используется в связке с встроенным элементом UIWebView
//

#import <Foundation/Foundation.h>
#import "NSData+toBase64.h"
#import "NSString+encodeURL.h"
#import "NSString+toBase64.h"
#import "NSString+HMACSHA1.h"

static const NSString *kTWITTER_CONSUMER_KEY = @"naInQxkf8rXsGkECwWIp4w";
static const NSString *kTWITTER_CONSUMER_SECRET = @"YglhrCWxUg9TLBwZaDUBI4LiU2YyBbsBgIIn8FDSI";

static const NSString *kTWITTER_REQUEST_TOKEN_URL = @"https://api.twitter.com/oauth/request_token";
static const NSString *kTWITTER_AUTHENTICATE_URL = @"https://api.twitter.com/oauth/authenticate";
static const NSString *kTWITTER_AUTHORIZE_URL = @"https://api.twitter.com/oauth/authorize";
static const NSString *kTWITTER_ACCESS_TOKEN_URL = @"https://api.twitter.com/oauth/access_token";
static const NSString *kTWITTER_LOGOUT_URL = @"https://api.twitter.com/intent/session";

@class DPTwitterUserAccount;

@interface DPTwitterCommunicator : NSObject <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webView;

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(DPTwitterUserAccount *))acceptedBlock;

+ (NSString *)generateNonceToken:(NSInteger)length;

+ (NSString *)generateSignatureBaseString:(NSDictionary *)keyValuePairs
                    withHTTPRequestMethod:(NSString *)requestMethod
                            andRequestURL:(NSString *)requestURL;

@end
