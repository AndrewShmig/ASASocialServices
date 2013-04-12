//
//  DPVkontakteUserAccount.m
//
//  Created by Andrew Shmig on 18.12.12.
//

#import "DPVkontakteUserAccount.h"

#define LOG_ON 1

#if LOG_ON == 1
# define DEBUG_CURRENT_METHOD() NSLog(@"%s", __FUNCTION__)
#endif

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
    self = [super init];

    if (self) {
        // init
        _accessToken = accessToken;
        _userId = userId;
        _expirationTime = expirationTime;


        _errorBlock = [^(NSError *error)
        { // default error block
            DEBUG_INFO(@"[DPVkontakteUserAccount] errorBlock is empty.");
        } copy];

        _successBlock = [^(NSDictionary *dictionary)
        { // default success block
            DEBUG_INFO(@"[DPVkontakteUserAccount] successBlock is empty.");
        } copy];
    }

    return self;
}

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSUInteger)userId
{
    return [self initUserAccountWithAccessToken:accessToken
                                 expirationTime:0
                                         userId:userId];
}

- (id)init
{
    @throw [NSException exceptionWithName:@"Invalid init method used."
                                   reason:@"Invalid init method used."
                                 userInfo:nil];
}

@end