//
// Created by AndrewShmig on 5/7/13.
//
// Copyright (c) AndrewShmig. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ASATwitterCommunicator.h"

@interface ASATwitterCommunicator (Utilities)

+ (NSString *)generateNonceToken:(NSInteger)length;

+ (NSString *)generateSignatureBaseString:(NSDictionary *)keyValuePairs
                    withHTTPRequestMethod:(NSString *)requestMethod
                            andRequestURL:(NSString *)requestURL;

@end