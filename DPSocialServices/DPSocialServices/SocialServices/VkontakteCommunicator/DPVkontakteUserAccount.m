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

// -----------------------------------------------------------------------------
// Uploding files to VK servers
// -----------------------------------------------------------------------------
@implementation DPVkontakteUserAccount(Upload)

- (void)uploadDocument:(NSString *)documentPath
                 toURL:(NSURL *)url
           withOptions:(NSDictionary *)options
{
    [self uploadFile:documentPath
        fileMIMEType:@"multipart/form-data"
   fileFormFieldName:@"file"
               toURL:url
         withOptions:options];
}

- (void)uploadPhoto:(NSString *)photoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
{
    [self uploadFile:photoPath
        fileMIMEType:@"image/jpeg"
   fileFormFieldName:@"photo"
               toURL:url
         withOptions:options];
}

- (void)uploadAudio:(NSString *)audioPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
{
    [self uploadFile:audioPath
        fileMIMEType:@"multipart/form-data"
   fileFormFieldName:@"file"
               toURL:url
         withOptions:options];
}

- (void)uploadVideo:(NSString *)videoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
{
    [self uploadFile:videoPath
        fileMIMEType:@"multipart/form-data"
   fileFormFieldName:@"video_file"
               toURL:url
         withOptions:options];
}

- (void)uploadFile:(NSString *)filePath
      fileMIMEType:(NSString *)mimeType
 fileFormFieldName:(NSString *)fieldName
             toURL:(NSURL *)url
       withOptions:(NSDictionary *)options
{
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

                                        _successBlock(response);
                                    }
                                    failure:^(
                                            AFHTTPRequestOperation *operation,
                                            NSError *error)
                                    {
                                        _errorBlock(error);
                                    }];
    [operation start];
}


@end