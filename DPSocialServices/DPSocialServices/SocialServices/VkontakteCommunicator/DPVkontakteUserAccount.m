//
//  DPVkontakteUserAccount.m
//
//  Created by Andrew Shmig on 18.12.12.
//

#import "DPVkontakteUserAccount.h"
#import "AFNetworking.h"
#import "NSString+encodeURL.h"

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
        _accessToken = [accessToken copy];
        _userId = userId;
        _expirationTime = expirationTime;

        _errorBlock = nil;
        _successBlock = nil;
    }

    return self;
}

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSInteger)userId
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

// -----------------------------------------------------------------------------
// Description
// -----------------------------------------------------------------------------
- (NSString *)description
{
    return [NSString stringWithFormat:@"\nAccess token: %@\nUser id:%d\n",
                                      _accessToken,
                                      _userId];
}

// -----------------------------------------------------------------------------
// Message forwarding
// -----------------------------------------------------------------------------
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    NSString *methodName = NSStringFromSelector([anInvocation selector]);
    void *buffer;

    [anInvocation getArgument:&buffer
                      atIndex:2];

    NSDictionary *options = (__bridge NSDictionary *)buffer;
    NSArray *parts = [self parseMethodName:methodName];
    NSString *vkURLMethodSignature = [NSString stringWithFormat:@"%@%@.%@",
                                                                kVKONTAKTE_API_URL,
                                                                parts[0],
                                                                parts[1]];
    // appending params to URL
    NSMutableString *fullRequestURL = [vkURLMethodSignature mutableCopy];

    [fullRequestURL appendString:@"?"];

    [options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        [fullRequestURL appendFormat:@"%@=%@&", key, [obj encodeURL]];
    }];

    [fullRequestURL appendFormat:@"access_token=%@", _accessToken];

    // performing HTTP GET request to vkURLMethodSignature URL
    NSURL *url = [NSURL URLWithString:fullRequestURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation;
    operation = [AFJSONRequestOperation
            JSONRequestOperationWithRequest:urlRequest
                                    success:^(NSURLRequest *request,
                                              NSHTTPURLResponse *response,
                                              id JSON)
                                    {
                                        _successBlock(JSON);
                                    }
                                    failure:^(NSURLRequest *request,
                                              NSHTTPURLResponse *response,
                                              NSError *error,
                                              id JSON)
                                    {
                                        _errorBlock(error);
                                    }];

    [operation start];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [NSMethodSignature signatureWithObjCTypes:[@"v@:@" UTF8String]];
}

// -----------------------------------------------------------------------------
// Parsing method signatures
// -----------------------------------------------------------------------------
- (NSArray *)parseMethodName:(NSString *)methodName
{
    NSRange range;
    NSString *suffix = @"WithCustomOptions:";

    range = [methodName rangeOfString:suffix];
    methodName = [methodName substringToIndex:range.location];

    NSCharacterSet *characterSet = [NSCharacterSet uppercaseLetterCharacterSet];
    range = [methodName rangeOfCharacterFromSet:characterSet];

    NSString *mainVKObject = [methodName substringToIndex:range.location];
    NSString *methodOfMainVKObject = [NSString stringWithFormat:@"%@%@",
                                                                [[methodName substringWithRange:NSMakeRange(range.location, 1)]
                                                                             lowercaseString],
                                                                [methodName substringFromIndex:range.location + 1]];

    return @[mainVKObject, methodOfMainVKObject];
}

@end

@implementation DPVkontakteUserAccount(Upload)

- (void)uploadDocument:(NSString *)documentPath
                 toURL:(NSURL *)url
           withOptions:(NSDictionary *)options
{
    NSAssert(NO, @"Implement uploadDocument:toURL:withOptions: method.");
}

- (void)uploadPhoto:(NSString *)photoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
{
    NSAssert(NO, @"Implement uploadPhoto:toURL:withOptions: method.");
}

- (void)uploadAudio:(NSString *)audioPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
{
    NSAssert(NO, @"Implement uploadAudio:toURL:withOptions: method.");
}

- (void)uploadVideo:(NSString *)videoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
{
    NSAssert(NO, @"Implement uploadVideo:toURL:withOptions: method.");
}

@end