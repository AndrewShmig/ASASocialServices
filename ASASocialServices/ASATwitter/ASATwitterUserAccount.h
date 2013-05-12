//
//  ASATwitterUserAccount.h
//
//  Created by AndrewShmig on 11.12.12.
//  Copyright (c) 2012 AndrewShmig. All rights reserved.
//
//

#import <Foundation/Foundation.h>


@interface ASATwitterUserAccount : NSObject

@property (nonatomic, readonly) NSString *screenName;
@property (nonatomic, readonly) NSString *twitterUserID;
@property (nonatomic, readonly) NSString *oauthToken;
@property (nonatomic, readonly) NSString *oauthTokenSecret;

@property (nonatomic, copy) void (^errorBlock) (NSError *);
@property (nonatomic, copy) void (^successBlock) (NSDictionary *);

- (instancetype)initWithToken:(NSString *)token
                  tokenSecret:(NSString *)tokenSecret
                twitterUserID:(NSString *)userId
               userScreenName:(NSString *)screenName;

- (void)performTwitterMethod:(NSString *)methodName
                  HTTPMethod:(NSString *)httpMethod
                     options:(NSDictionary *)options
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure;

@end
