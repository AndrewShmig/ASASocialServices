//
//  NSString+HMACSHA1.m
//  TwitterCommunicator2
//
//  Created by digipeople on 06.12.12.
//  Copyright (c) 2012 digipeople. All rights reserved.
//

#import "NSString+HMACSHA1.h"
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (HMACSHA1)

-(NSData *)HMACSHA1:(NSString *)key
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [self cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    return HMAC;
}

@end
