//
//  ASAVkontakteUserAccount.m
//
//  Created by Andrew Shmig on 18.12.12.
//

#import "ASAVkontakteUserAccount.h"
#import "ASAVkontakteCommunicator.h"
#import "AFNetworking.h"
#import "NSString+encodeURL.h"
#import "DDLog.h"

#define return_from_block return
#define call_failure_block(param) if(failure!=nil){failure(param);}
#define call_success_block(param) if(success!=nil){success(param);}

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation ASAVkontakteUserAccount

@synthesize accessToken = _accessToken;
@synthesize userId = _userId;
@synthesize expirationTime = _expirationTime;

// -----------------------------------------------------------------------------
// Initialize VKUserAccount with accessToken, expirationTime and userId.
// -----------------------------------------------------------------------------
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

// -----------------------------------------------------------------------------
// Initialize VKUserAccount with accessToken and userId.
// expirationTime is set to 0.
// -----------------------------------------------------------------------------
- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSInteger)userId
{
    DDLogVerbose(@"%s", __FUNCTION__);

    return [self initUserAccountWithAccessToken:accessToken
                                 expirationTime:0
                                         userId:userId];
}

// -----------------------------------------------------------------------------
// Standart init
// -----------------------------------------------------------------------------
- (id)init
{
    DDLogVerbose(@"%s", __FUNCTION__);

    @throw [NSException exceptionWithName:@"Invalid init method used."
                                   reason:@"Invalid init method used."
                                 userInfo:nil];
}

// -----------------------------------------------------------------------------
// Obtain access_token using user login+password and init VKUserAccount.
// This method performs request to VK server to obtain accessToken, if
// request succeeds then success block is executed, else - failure block.
// If request succeeds accessToken, expirationTime and userId properties are set.
// -----------------------------------------------------------------------------
- (id)initUserAccountWithLogin:(NSString *)login
                      password:(NSString *)password
                   permissions:(NSArray *)permissions
                       success:(ASAVkontakteSuccessBlock)success
                       failure:(ASAVkontakteFailureBlock)failure
{
    self = [super init];

    if(self) {
        NSMutableString *kVKOauthURL = [kVkontakteLoginPasswordOAuthURL mutableCopy];

        // appending params
        [kVKOauthURL appendFormat:@"?grant_type=password"];
        [kVKOauthURL appendFormat:@"&client_id=%@", kVKONTAKTE_APP_ID];
        [kVKOauthURL appendFormat:@"&client_secret=%@", kVKONTAKTE_PRIVATE_KEY];
        [kVKOauthURL appendFormat:@"&username=%@", [login encodeURL]];
        [kVKOauthURL appendFormat:@"&password=%@", [password encodeURL]];

        if(permissions == nil)
            [kVKOauthURL appendFormat:@"&scope=%@", kVKONTAKTE_PERMISSIONS_LIST];
        else if([permissions count] != 0) {
            NSMutableString *permissionList = [NSMutableString string];

            for(NSString *permission in permissions) {
                [permissionList appendFormat:@",%@", permission];
            }

            NSRange firstChar = NSMakeRange(0, 1);
            [permissionList deleteCharactersInRange:firstChar];
        }

        NSURL *url = [NSURL URLWithString:kVKOauthURL];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];

        AFJSONRequestOperation *operation = [AFJSONRequestOperation
                JSONRequestOperationWithRequest:urlRequest
                                        success:^(NSURLRequest *request,
                                                  NSHTTPURLResponse *response,
                                                  id JSON)
                                        {
                                            DDLogVerbose(@"%@", JSON);

                                            if(JSON[@"error"] != nil) {
                                                NSError *error = [NSError errorWithDomain:kVkontakteErrorDomain
                                                                                     code:-1
                                                                                 userInfo:@{
                                                                                         @"Status code"     : @([response statusCode]),
                                                                                         @"Error"           : JSON[@"error"],
                                                                                         @"Server response" : [JSON description]}];

                                                call_failure_block(error);

                                                return_from_block;
                                            }

                                            _accessToken = JSON[@"access_token"];
                                            _expirationTime = [JSON[@"expires_in"] integerValue];
                                            _userId = [JSON[@"user_id"] integerValue];

                                            call_success_block(JSON);
                                        }
                                        failure:^(NSURLRequest *request,
                                                  NSHTTPURLResponse *response,
                                                  NSError *error,
                                                  id JSON)
                                        {
                                            _accessToken = nil;
                                            _expirationTime = 0;
                                            _userId = 0;

                                            call_failure_block(error);
                                        }];

        [operation start];
    }

    return self;
}

// -----------------------------------------------------------------------------
// Performs request to VK method with custom options
// -----------------------------------------------------------------------------
- (void)performVKMethod:(NSString *)methodName
                options:(NSDictionary *)options
                success:(ASAVkontakteSuccessBlock)success
                failure:(ASAVkontakteFailureBlock)failure
{
    DDLogVerbose(@"%s", __FUNCTION__);

    // appending params to URL
    NSMutableString *fullRequestURL = [NSMutableString stringWithFormat:@"%@%@",
                                                                        kVkontakteAPIURL,
                                                                        [methodName mutableCopy]];

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
                                        if(JSON[@"error"] != nil) {
                                            NSError *error = [NSError errorWithDomain:kVkontakteErrorDomain
                                                                                 code:-1
                                                                             userInfo:@{
                                                                                     @"Status code"     : @([response statusCode]),
                                                                                     @"Error code"      : JSON[@"error"][@"error_code"],
                                                                                     @"Error message"   : JSON[@"error"][@"error_msg"]}];
                                            call_failure_block(error);

                                            return_from_block;
                                        }

                                        call_success_block(JSON);
                                    }
                                    failure:^(NSURLRequest *request,
                                              NSHTTPURLResponse *response,
                                              NSError *error,
                                              id JSON)
                                    {
                                        DDLogError(@"Response status code: %d", [response statusCode]);
                                        DDLogError(@"Error: %@", error);
                                        DDLogError(@"JSON: %@", JSON);

                                        call_failure_block(error);
                                    }];

    [operation start];
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

                                        if(response[@"error"] != nil) {
                                            NSError *error = [NSError errorWithDomain:kVkontakteErrorDomain
                                                                                 code:-1
                                                                             userInfo:@{
                                                                                     @"Error code"    : response[@"error"][@"error_code"],
                                                                                     @"Error message" : response[@"error"][@"error_msg"]}];
                                            call_failure_block(error);

                                            return_from_block;
                                        }

                                        call_success_block(response);
                                    }
                                    failure:^(
                                            AFHTTPRequestOperation *operation,
                                            NSError *error)
                                    {
                                        call_failure_block(error);
                                    }];
    [operation start];
}


@end