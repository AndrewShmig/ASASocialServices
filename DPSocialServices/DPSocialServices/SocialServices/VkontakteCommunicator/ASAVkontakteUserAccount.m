//
//  ASAVkontakteUserAccount.m
//
//  Created by Andrew Shmig on 18.12.12.
//

#import "ASAVkontakteUserAccount.h"
#import "AFNetworking.h"
#import "NSString+encodeURL.h"

#import "DDLog.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation ASAVkontakteUserAccount

@synthesize accessToken = _accessToken;
@synthesize userId = _userId;
@synthesize expirationTime = _expirationTime;

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                      expirationTime:(NSInteger)expirationTime
                              userId:(NSInteger)userId
{
    DDLogVerbose(@"%s", __FUNCTION__);

    self = [super init];

    if (self) {
        // init
        _accessToken = [accessToken copy];
        _userId = userId;
        _expirationTime = expirationTime;
    }

    return self;
}

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSInteger)userId
{
    DDLogVerbose(@"%s", __FUNCTION__);

    return [self initUserAccountWithAccessToken:accessToken
                                 expirationTime:0
                                         userId:userId];
}

- (id)init
{
    DDLogVerbose(@"%s", __FUNCTION__);

    @throw [NSException exceptionWithName:@"Invalid init method used."
                                   reason:@"Invalid init method used."
                                 userInfo:nil];
}

// -----------------------------------------------------------------------------
// Description
// -----------------------------------------------------------------------------
- (NSString *)description
{
    DDLogVerbose(@"%s", __FUNCTION__);

    return [NSString stringWithFormat:@"\nAccess token: %@\nUser id:%d\n",
                                      _accessToken,
                                      _userId];
}

// -----------------------------------------------------------------------------
// Message forwarding
// -----------------------------------------------------------------------------
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    DDLogVerbose(@"%s", __FUNCTION__);

    NSString *methodName = NSStringFromSelector([anInvocation selector]);
    void *buffer;
    void *bufferSuccess;
    void *bufferFailure;

    [anInvocation getArgument:&buffer
                      atIndex:2];
    [anInvocation getArgument:&bufferSuccess
                      atIndex:3];
    [anInvocation getArgument:&bufferFailure
                      atIndex:4];

    NSDictionary *options = (__bridge NSDictionary *)buffer;
    ASAVkontakteSuccessBlock success = (__bridge ASAVkontakteSuccessBlock)bufferSuccess;
    ASAVkontakteFailureBlock failure = (__bridge ASAVkontakteFailureBlock)bufferFailure;

    NSArray *parts = [self parseMethodName:methodName];
    NSString *vkURLMethodSignature = [NSString stringWithFormat:@"%@%@.%@",
                                                                kVKONTAKTE_API_URL,
                                                                parts[0],
                                                                parts[1]];
    DDLogVerbose(@"options: %@", options);
    DDLogVerbose(@"vkURLMethodSignature: %@", vkURLMethodSignature);

    // appending params to URL
    NSMutableString *fullRequestURL = [vkURLMethodSignature mutableCopy];

    [fullRequestURL appendString:@"?"];

    [options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        [fullRequestURL appendFormat:@"%@=%@&", key, [obj encodeURL]];
    }];

    [fullRequestURL appendFormat:@"access_token=%@", _accessToken];

    DDLogVerbose(@"fullRequestURL: %@", fullRequestURL);

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
                                        success(JSON);
                                    }
                                    failure:^(NSURLRequest *request,
                                              NSHTTPURLResponse *response,
                                              NSError *error,
                                              id JSON)
                                    {
                                        DDLogError(@"Response status code: %d", [response statusCode]);
                                        DDLogError(@"Error: %@", error);
                                        DDLogError(@"JSON: %@", JSON);

                                        failure(error);
                                    }];

    [operation start];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    DDLogVerbose(@"%s", __FUNCTION__);
    DDLogVerbose(@"aSelector: %@", NSStringFromSelector(aSelector));

    return [NSMethodSignature signatureWithObjCTypes:[@"v@:@@@" UTF8String]];
}

// -----------------------------------------------------------------------------
// Parsing method signatures
// -----------------------------------------------------------------------------
- (NSArray *)parseMethodName:(NSString *)methodName
{
    DDLogVerbose(@"%s", __FUNCTION__);

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

    DDLogVerbose(@"mainVKObject: %@", mainVKObject);
    DDLogVerbose(@"methodOfMainVKObject: %@", methodOfMainVKObject);

    return @[mainVKObject, methodOfMainVKObject];
}

@end

// -----------------------------------------------------------------------------
// Uploding files to VK servers
// -----------------------------------------------------------------------------
@implementation ASAVkontakteUserAccount (Upload)

- (void)uploadDocument:(NSString *)documentPath
                 toURL:(NSURL *)url
           withOptions:(NSDictionary *)options
               success:(ASAVkontakteSuccessBlock)success
               failure:(ASAVkontakteFailureBlock)failure
{
    DDLogVerbose(@"%s", __FUNCTION__);

    [self uploadFile:documentPath
        fileMIMEType:@"multipart/form-data"
   fileFormFieldName:@"file"
               toURL:url
         withOptions:options
             success:success
             failure:failure];
}

- (void)uploadPhoto:(NSString *)photoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
            success:(ASAVkontakteSuccessBlock)success
            failure:(ASAVkontakteFailureBlock)failure
{
    DDLogVerbose(@"%s", __FUNCTION__);

    [self uploadFile:photoPath
        fileMIMEType:@"image/jpeg"
   fileFormFieldName:@"photo"
               toURL:url
         withOptions:options
             success:success
             failure:failure];
}

- (void)uploadAlbumPhoto:(NSString *)photoPath
                   toURL:(NSURL *)url
             withOptions:(NSDictionary *)options
                 success:(ASAVkontakteSuccessBlock)success
                 failure:(ASAVkontakteFailureBlock)failure
{
    DDLogVerbose(@"%s", __FUNCTION__);

    [self uploadFile:photoPath
        fileMIMEType:@"image/jpeg"
   fileFormFieldName:@"file1"
               toURL:url
         withOptions:options
             success:success
             failure:failure];
}


- (void)uploadAudio:(NSString *)audioPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
            success:(ASAVkontakteSuccessBlock)success
            failure:(ASAVkontakteFailureBlock)failure
{
    DDLogVerbose(@"%s", __FUNCTION__);

    [self uploadFile:audioPath
        fileMIMEType:@"multipart/form-data"
   fileFormFieldName:@"file"
               toURL:url
         withOptions:options
             success:success
             failure:failure];
}

- (void)uploadVideo:(NSString *)videoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
            success:(ASAVkontakteSuccessBlock)success
            failure:(ASAVkontakteFailureBlock)failure
{
    DDLogVerbose(@"%s", __FUNCTION__);

    [self uploadFile:videoPath
        fileMIMEType:@"multipart/form-data"
   fileFormFieldName:@"video_file"
               toURL:url
         withOptions:options
             success:success
             failure:failure];
}

- (void)uploadFile:(NSString *)filePath
      fileMIMEType:(NSString *)mimeType
 fileFormFieldName:(NSString *)fieldName
             toURL:(NSURL *)url
       withOptions:(NSDictionary *)options
           success:(ASAVkontakteSuccessBlock)success
           failure:(ASAVkontakteFailureBlock)failure
{
    DDLogVerbose(@"%s", __FUNCTION__);

    NSData *documentData = [NSData dataWithContentsOfFile:filePath];

    // getting filename
    NSString *fileName = [[filePath componentsSeparatedByString:@"/"]
                                    lastObject];

    // we have key-value pairs to append to URL
    if([options count] != 0) {
        NSMutableString *newURL = [[url description] mutableCopy];

        [options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
        {
            [newURL appendFormat:@"&%@=%@", key, [obj encodeURL]];
        }];

        url = [NSURL URLWithString:newURL];
    }

    AFHTTPClient *httpClient = [[AFHTTPClient alloc]
                                              initWithBaseURL:url];

    NSMutableURLRequest *uploadRequest = [httpClient
            multipartFormRequestWithMethod:@"POST"
                                      path:@""
                                parameters:nil
                 constructingBodyWithBlock:^(
                         id <AFMultipartFormData> formData)
                 {
                     [formData appendPartWithFileData:documentData
                                                 name:fieldName
                                             fileName:fileName
                                             mimeType:mimeType];
                 }];

    AFHTTPRequestOperation *operation = [httpClient
            HTTPRequestOperationWithRequest:uploadRequest
                                    success:^(
                                            AFHTTPRequestOperation *operation,
                                            id responseObject)
                                    {
                                        NSDictionary *response = [NSJSONSerialization
                                                JSONObjectWithData:responseObject
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];

                                        success(response);
                                    }
                                    failure:^(
                                            AFHTTPRequestOperation *operation,
                                            NSError *error)
                                    {
                                        failure(error);
                                    }];
    [operation start];
}


@end