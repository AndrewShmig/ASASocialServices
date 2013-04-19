//
//  ASAVkontakteUserAccount.h
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>
#import "ASAVkontakteMethods.h"

static NSString *const kVKONTAKTE_API_URL = @"https://api.vk.com/method/";

typedef void (^ASAVkontakteSuccessBlock) (NSDictionary *);
typedef void (^ASAVkontakteFailureBlock) (NSError *);

@interface ASAVkontakteUserAccount : NSObject

@property (nonatomic, readonly) NSString *accessToken;
@property (nonatomic, readonly) NSInteger expirationTime;
@property (nonatomic, readonly) NSInteger userId;

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                      expirationTime:(NSInteger)expirationTime
                              userId:(NSInteger)userId;

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSInteger)userId;

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
               failure:(ASAVkontakteFailureBlock)failure;

- (void)uploadPhoto:(NSString *)photoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
            success:(ASAVkontakteSuccessBlock)success
            failure:(ASAVkontakteFailureBlock)failure;

- (void)uploadAlbumPhoto:(NSString *)photoPath
                   toURL:(NSURL *)url
             withOptions:(NSDictionary *)options
                 success:(ASAVkontakteSuccessBlock)success
                 failure:(ASAVkontakteFailureBlock)failure;

- (void)uploadAudio:(NSString *)audioPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
            success:(ASAVkontakteSuccessBlock)success
            failure:(ASAVkontakteFailureBlock)failure;

- (void)uploadVideo:(NSString *)videoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options
            success:(ASAVkontakteSuccessBlock)success
            failure:(ASAVkontakteFailureBlock)failure;

@end