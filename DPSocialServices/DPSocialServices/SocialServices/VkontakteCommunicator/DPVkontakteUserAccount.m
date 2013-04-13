//
//  DPVkontakteUserAccount.m
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>
#import "DPVkontakteUserAccount.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation DPVkontakteUserAccount

@synthesize accessToken = _accessToken;
@synthesize userId = _userId;
@synthesize expirationTime = _expirationTime;
@synthesize errorBlock = _errorBlock;
@synthesize successBlock = _successBlock;

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                      expirationTime:(NSInteger)expirationTime
                              userId:(NSInteger)userId
{
    DDLogInfo(@"%s", __FUNCTION__);
    DDLogVerbose(@"Access token: %@", accessToken);
    DDLogVerbose(@"Expiration time: %i", expirationTime);
    DDLogVerbose(@"User id: %i", userId);

    self = [super init];

    if (self) {
        // init
        _accessToken = [accessToken copy];
        _userId = userId;
        _expirationTime = expirationTime;


        _errorBlock = [^(NSError *error)
        { // default error block
        } copy];

        _successBlock = [^(NSDictionary *dictionary)
        { // default success block
        } copy];
    }

    return self;
}

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSUInteger)userId
{
    DDLogInfo(@"%s", __FUNCTION__);

    return [self initUserAccountWithAccessToken:accessToken
                                 expirationTime:0
                                         userId:userId];
}

- (id)init
{
    DDLogInfo(@"%s", __FUNCTION__);

    @throw [NSException exceptionWithName:@"Invalid init method used."
                                   reason:@"Invalid init method used."
                                 userInfo:nil];
}

@end