//
//  ASATwitterUserAccount.h
//
//  Created by AndrewShmig on 11.12.12.
//  Copyright (c) 2012 AndrewShmig. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import "NSData+toBase64.h"
#import "NSString+encodeURL.h"
#import "NSString+toBase64.h"
#import "NSString+HMACSHA1.h"
#import "ASATwitterCommunicator.h"

static NSString *const kTWITTER_STATUS_UPDATE_URL = @"https://api.twitter.com/1.1/statuses/update.json";
static NSString *const kTWITTER_DIRECT_MESSAGES_NEW_URL = @"https://api.twitter.com/1.1/direct_messages/new.json";
static NSString *const kTWITTER_DIRECT_MESSAGES_URL = @"https://api.twitter.com/1.1/direct_messages.json";
static NSString *const kTWITTER_DIRECT_MESSAGES_SHOW_URL = @"https://api.twitter.com/1.1/direct_messages/show.json";
static NSString *const kTWITTER_DIRECT_MESSAGES_DESTROY_URL = @"https://api.twitter.com/1.1/direct_messages/destroy.json";
static NSString *const kTWITTER_SENT_DIRECT_MESSAGES_URL = @"https://api.twitter.com/1.1/direct_messages/sent.json";
static NSString *const kTWITTER_FRIENDS_LIST_URL = @"https://api.twitter.com/1.1/friends/list.json";
static NSString *const kTWITTER_FOLLOWERS_LIST_URL = @"https://api.twitter.com/1.1/followers/list.json";
static NSString *const kTWITTER_USERS_SHOW_URL = @"http://api.twitter.com/1.1/users/show.json";
static NSString *const kTWITTER_USER_SETTINGS_URL = @"https://api.twitter.com/1.1/account/settings.json";
static NSString *const kTWITTER_USER_VERIFY_CREDENTIALS_URL = @"https://api.twitter.com/1.1/account/verify_credentials.json";
static NSString *const kTWITTER_USER_UPDATE_ACCOUNT_URL = @"https://api.twitter.com/1.1/account/update_profile.json";
static NSString *const kTWITTER_USER_BLOCKED_USERS_URL = @"https://api.twitter.com/1.1/blocks/ids.json";
static NSString *const kTWITTER_USER_CREATE_BLOCK_URL = @"https://api.twitter.com/1.1/blocks/create.json";
static NSString *const kTWITTER_USER_UNBLOCK_BLOCK_URL = @"https://api.twitter.com/1.1/blocks/destroy.json";
static NSString *const kTWITTER_DESTROY_STATUS_URL = @"https://api.twitter.com/1.1/statuses/destroy/:id.json";

@interface ASATwitterUserAccount : NSObject

@property (nonatomic, readonly) NSString *screenName;
@property (nonatomic, readonly) NSString *twitterUserID;
@property (nonatomic, readonly) NSString *oauthToken;
@property (nonatomic, readonly) NSString *oauthTokenSecret;

@property (nonatomic, copy) void (^errorBlock) (NSError *);
@property (nonatomic, copy) void (^successBlock) (NSDictionary *);

- (id)initWithToken:(NSString *)token
        tokenSecret:(NSString *)tokenSecret
      twitterUserID:(NSString *)userId
     userScreenName:(NSString *)screenName;

- (BOOL)isAuthorized;

- (void)obtainInfo;

- (void)obtainSettings;

- (void)verifyCredentials;

- (void)verifyCredentialsCustomOptions:(NSDictionary *)options;

- (void)updateProfileCustomOptions:(NSDictionary *)options;

- (void)obtainFriendsWithCursor:(NSString *)cursor;

- (void)obtainFriendsCustomOptions:(NSDictionary *)options;

- (void)obtainFollowersWithCursor:(NSString *)cursor;

- (void)obtainFollowersCustomOptions:(NSDictionary *)options;

- (void)showInfoForUserId:(NSString *)userId;

- (void)showInfoForUserScreenName:(NSString *)screenName;

- (void)showInfoForUserCustomOptions:(NSDictionary *)options;

- (void)obtainUsersInBlock;

- (void)obtainUsersInBlockCursor:(NSString *)cursor;

- (void)blockUserId:(NSString *)userId;

- (void)blockUserScreenName:(NSString *)screenName;

- (void)blockUserCustomOptions:(NSDictionary *)options;

- (void)unblockUserId:(NSString *)userId;

- (void)unblockUserScreenName:(NSString *)screenName;

- (void)unblockUserCustomOptions:(NSDictionary *)options;

- (void)obtainDirectMessages;

- (void)obtainDirectMessagesCount:(NSUInteger)count;

- (void)obtainDirectMessagesSinceId:(NSString *)sinceId;

- (void)obtainDirectMessagesCustomOptions:(NSDictionary *)options;

- (void)obtainSentDirectMessages;

- (void)obtainSentDirectMessagesCount:(NSUInteger)count;

- (void)obtainSentDirectMessagesSinceId:(NSString *)sinceId;

- (void)obtainSentDirectMessagesPage:(NSUInteger)page;

- (void)obtainSentDirectMessagesCustomOptions:(NSDictionary *)options;

- (void)obtainDirectMessageId:(NSString *)directMessageId;

- (void)destroyDirectMessageId:(NSString *)directMessageId;

- (void)destroyDirectMessageCustomOptions:(NSDictionary *)options;

- (void)tweet:(NSString *)text;

- (void)tweetCustomOptions:(NSDictionary *)options;

- (void)destroyTweetId:(NSString *)tweetId;

- (void)sendDirectMessage:(NSString *)msg
                   userId:(NSString *)userId;

- (void)sendDirectMessage:(NSString *)msg
           userScreenName:(NSString *)screenName;

@end
