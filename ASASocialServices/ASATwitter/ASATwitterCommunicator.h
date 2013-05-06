//
//  ASATwitterCommunicator.h
//
//  Created by AndrewShmig on 06.12.12.
//  Copyright (c) 2012 AndrewShmig. All rights reserved.
//
//

#import <Foundation/Foundation.h>

/*
* Consumer key, consumer secret
* */
static NSString *const kTWITTER_CONSUMER_KEY = @"naInQxkf8rXsGkECwWIp4w";
static NSString *const kTWITTER_CONSUMER_SECRET = @"YglhrCWxUg9TLBwZaDUBI4LiU2YyBbsBgIIn8FDSI";


@class ASATwitterUserAccount;

@interface ASATwitterCommunicator : NSObject <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webView;

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(ASATwitterUserAccount *))acceptedBlock;

+ (NSString *)generateNonceToken:(NSInteger)length;

+ (NSString *)generateSignatureBaseString:(NSDictionary *)keyValuePairs
                    withHTTPRequestMethod:(NSString *)requestMethod
                            andRequestURL:(NSString *)requestURL;

@end
