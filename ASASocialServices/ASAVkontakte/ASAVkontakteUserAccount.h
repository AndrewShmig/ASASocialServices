//
//  ASAVkontakteUserAccount.h
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>


typedef void (^ASAVkontakteSuccessBlock) (NSDictionary *JSON);
typedef void (^ASAVkontakteFailureBlock) (NSError *error);
typedef void (^ASAVkontakteProgressBlock) (NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite);


static NSString *const kVkontakteAPIURL = @"https://api.vk.com/method/";
static NSString *const kVkontakteErrorDomain = @"ASAVkontakteErrorDomain";
static NSString *const kVkontakteLoginPasswordOAuthURL = @"https://oauth.vk.com/token";


@interface ASAVkontakteUserAccount : NSObject

@property (nonatomic, readonly) NSString *accessToken;
@property (nonatomic, readonly) NSInteger expirationTime;
@property (nonatomic, readonly) NSInteger userId;

// -----------------------------------------------------------------------------
// Initialize VKUserAccount with accessToken, expirationTime and userId.
// -----------------------------------------------------------------------------
- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                      expirationTime:(NSInteger)expirationTime
                              userId:(NSInteger)userId;

// -----------------------------------------------------------------------------
// Initialize VKUserAccount with accessToken and userId.
// expirationTime is set to 0.
// -----------------------------------------------------------------------------
- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSInteger)userId;

// -----------------------------------------------------------------------------
// To use this method your application should be approved.
// Documentation: https://vk.com/developers.php?o=-1&p=%CF%F0%FF%EC%E0%FF%2B%C0%E2%F2%EE%F0%E8%E7%E0%F6%E8%FF
//
// Obtain access_token using user login+password and init VKUserAccount.
// This method performs request to VK server to obtain accessToken, if
// request succeeds then success block is executed, else - failure block.
// If request succeeds accessToken, expirationTime and userId properties are set
// before any block gets executed.
// -----------------------------------------------------------------------------
- (id)initUserAccountWithLogin:(NSString *)login
                      password:(NSString *)password
                   permissions:(NSArray *)permissions
                       success:(ASAVkontakteSuccessBlock)success
                       failure:(ASAVkontakteFailureBlock)failure;

// -----------------------------------------------------------------------------
// Performs request to VK method with custom options
// -----------------------------------------------------------------------------
- (void)performVKMethod:(NSString *)methodName
                options:(NSDictionary *)options
                success:(ASAVkontakteSuccessBlock)success
                failure:(ASAVkontakteFailureBlock)failure;
@end

// -----------------------------------------------------------------------------
// Upload files to VK servers
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Upload)

- (void)uploadDocument:(NSString *)documentPath
                 toURL:(NSURL *)url
           withOptions:(NSDictionary *)options
               success:(ASAVkontakteSuccessBlock)success
               failure:(ASAVkontakteFailureBlock)failure
              progress:(ASAVkontakteProgressBlock)progress;

- (void)uploadPhoto:(NSString *)photoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
            success:(ASAVkontakteSuccessBlock)success
            failure:(ASAVkontakteFailureBlock)failure
           progress:(ASAVkontakteProgressBlock)progress;

- (void)uploadAlbumPhoto:(NSString *)photoPath
                   toURL:(NSURL *)url
             withOptions:(NSDictionary *)options
                 success:(ASAVkontakteSuccessBlock)success
                 failure:(ASAVkontakteFailureBlock)failure
                progress:(ASAVkontakteProgressBlock)progress;

- (void)uploadAudio:(NSString *)audioPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
            success:(ASAVkontakteSuccessBlock)success
            failure:(ASAVkontakteFailureBlock)failure
           progress:(ASAVkontakteProgressBlock)progress;

- (void)uploadVideo:(NSString *)videoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
            success:(ASAVkontakteSuccessBlock)success
            failure:(ASAVkontakteFailureBlock)failure
           progress:(ASAVkontakteProgressBlock)progress;

@end