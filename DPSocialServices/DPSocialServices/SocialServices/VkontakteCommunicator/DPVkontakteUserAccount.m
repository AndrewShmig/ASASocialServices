//
//  DPVkontakteUserAccount.m
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>
#import "DPVkontakteUserAccount.h"
#import "DDLog.h"

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

// -----------------------------------------------------------------------------
// Message forwarding
// -----------------------------------------------------------------------------
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    DDLogInfo(@"%s", __FUNCTION__);

    NSString *methodName = NSStringFromSelector([anInvocation selector]);
    DDLogVerbose(@"Invoked method name: %@", methodName);
    
    NSDictionary *options;
    [anInvocation getArgument:&options
                      atIndex:2];
    DDLogVerbose(@"options: %@", options);

    NSArray *parts = [self parseMethodName:methodName];
    DDLogVerbose(@"parts: %@", parts);

    NSString *vkURLMethodSignature = [NSString stringWithFormat:@"%@%@.%@",
                                                                kVKONTAKTE_API_URL,
                                                                parts[0],
                                                                parts[1]];
    DDLogVerbose(@"vkURLMethodSignature: %@", vkURLMethodSignature);

    // TODO: perform HTTP request here to vkURLMethodSignature URL passing options as URL params
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    DDLogInfo(@"%s", __FUNCTION__);

    return [NSMethodSignature signatureWithObjCTypes:[@"v@:@" UTF8String]];
}

// -----------------------------------------------------------------------------
// Parsing method signatures
// -----------------------------------------------------------------------------
- (NSArray *)parseMethodName:(NSString *)methodName
{
    DDLogInfo(@"%s", __FUNCTION__);

    NSRange range;
    NSString *suffix = @"WithCustomOptions:";

    range = [methodName rangeOfString:suffix];
    methodName = [methodName substringToIndex:range.location];
    DDLogVerbose(@"methodName after removing suffix: %@", methodName);

    NSCharacterSet *characterSet = [NSCharacterSet uppercaseLetterCharacterSet];
    range = [methodName rangeOfCharacterFromSet:characterSet];

    NSString *mainVKObject = [methodName substringToIndex:range.location];
    NSString *methodOfMainVKObject = [NSString stringWithFormat:@"%@%@",
                                                                [[methodName substringWithRange:NSMakeRange(range.location, 1)]
                                                                             lowercaseString],
                                                                [methodName substringFromIndex:range.location + 1]];

    DDLogVerbose(@"mainVKObject: %@", mainVKObject);
    DDLogVerbose(@"methodOfMainVKObject: %@", methodOfMainVKObject);

    return @[mainVKObject, methodOfMainVKObject];
}

@end