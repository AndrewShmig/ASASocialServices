//
//  DPFacebookUserAccount.m
//
//  Created by AndrewShmig on 14.12.12.
//  Copyright (c) 2012 digipeople. All rights reserved.
//

#import "DPFacebookUserAccount.h"
#import "NSString+encodeURL.h"

#define LOG_ON 1

#if LOG_ON == 1
# define DEBUG_CURRENT_METHOD() NSLog(@"%s", __FUNCTION__)
#endif

@implementation DPFacebookUserAccount
{
    NSString *_accessToken;
    NSUInteger _expirationTime;
}

#pragma mark - Init methods

- (id)initWithAccessToken:(NSString *)accessToken
           expirationTime:(NSUInteger)expirationTime
{
    DEBUG_CURRENT_METHOD();

    self = [super init];

    if (self) {

        if(accessToken == nil)
            @throw [NSException exceptionWithName:@"Access token can not be nil."
                                           reason:@"accessToken is nil."
                                         userInfo:@{}];

        _accessToken = [accessToken copy];
        _expirationTime = expirationTime;
    }

    return self;
}

#pragma mark - Public methods

- (NSString *)description
{
    return [NSString stringWithFormat:@"Access token: %@, expires in: %llu",
                                      _accessToken,
                                      _expirationTime];
}

@end
