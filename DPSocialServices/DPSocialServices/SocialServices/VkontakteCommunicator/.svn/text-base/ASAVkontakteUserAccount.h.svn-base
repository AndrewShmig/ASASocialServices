//
//  DPVkontakteUserAccount.h
//
//  Created by Andrew Shmig on 18.12.12.
//  Copyright (c) 2012 DigiPeople Inc. All rights reserved.
//
//  Класс для работы с пользовательским аккаунтом ВК
//  Инициализация требует 3 параметра: access token, время окончания действия токена и пользовательский айди
//

#import <Foundation/Foundation.h>

static const NSString *kVKONTAKTE_USER_INFO_URL = @"https://api.vk.com/method/users.get";
static const NSString *kVKONTAKTE_USER_SUBSCRIPTIONS_URL = @"https://api.vk.com/method/users.getSubscriptions";
static const NSString *kVKONTAKTE_USER_FOLLOWERS_URL = @"https://api.vk.com/method/users.getFollowers";
static const NSString *kVKONTAKTE_USER_FRIENDS_URL = @"https://api.vk.com/method/friends.get";
static const NSString *kVKONTAKTE_USER_WALL_POST_URL = @"https://api.vk.com/method/wall.post";
static const NSString *kVKONTAKTE_USER_MESSAGES_URL = @"https://api.vk.com/method/messages.get";
static const NSString *kVKONTAKTE_USER_MESSAGES_USER_URL = @"https://api.vk.com/method/messages.getHistory";
static const NSString *kVKONTAKTE_PHOTO_UPLOAD_MESSAGES_SERVER_URL = @"https://api.vk.com/method/photos.getMessagesUploadServer";
static const NSString *kVKONTAKTE_PHOTO_SAVE_MESSAGES_UPLOADED_URL = @"https://api.vk.com/method/photos.saveMessagesPhoto";
static const NSString *kVKONTAKTE_USER_SEND_MESSAGE_URL = @"https://api.vk.com/method/messages.send";


@interface DPVkontakteUserAccount : NSObject

@property (nonatomic, readonly) NSString *accessToken;
@property (nonatomic, readonly) NSInteger expirationTime;
@property (nonatomic, readonly) NSInteger userId;

@property (nonatomic, copy) void (^errorBlock)(NSError *);
@property (nonatomic, copy) void (^successBlock)(NSDictionary *);

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                      expirationTime:(NSInteger)expirationTime
                              userId:(NSInteger)userId;

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSUInteger)userId;

- (void)obtainInfo;
- (void)obtainInfoForUser:(NSString *)userId;
- (void)obtainInfoCustomOptions:(NSDictionary *)options;

- (void)postToWall:(NSString *)text;
- (void)postToWallCustomOptions:(NSDictionary *)options;

- (void)uploadPhoto:(NSString *)photoPath;

- (void)sendPrivateMessage:(NSString *)message
                  toUserId:(NSString *)userId;
- (void)sendPrivateMessage:(NSString *)message
                     photo:(NSString *)photoPath
                  toUserId:(NSString *)userId;
- (void)sendPrivateMessageCustomOptions:(NSDictionary *)options;

- (void)obtainLastMessagesCustomOptions:(NSDictionary *)options;

- (void)obtainLastSentMessagesCount:(NSUInteger)count;
- (void)obtainLastSentMessagesCount:(NSUInteger)count
                             offset:(NSUInteger)offset;
- (void)obtainLastSentUnreadMessagesCount:(NSUInteger)count;
- (void)obtainLastSentUnreadMessagesCount:(NSUInteger)count
                                   offset:(NSUInteger)offset;

- (void)obtainDialogMessagesWithUser:(NSString *)userId;
- (void)obtainDialogMessagesWithUser:(NSString *)userId
                               count:(NSUInteger)count;
- (void)obtainDialogMessagesWithUser:(NSString *)userId
                               count:(NSUInteger)count
                              offset:(NSUInteger)offset;
- (void)obtainDialogMessagesCustomOptions:(NSDictionary *)options;

- (void)obtainFriends;
- (void)obtainFriendsCount:(NSUInteger)count;
- (void)obtainFriendsCount:(NSUInteger)count
                    offset:(NSUInteger)offset;
- (void)obtainFriendsCustomOptions:(NSDictionary *)options;

- (void)obtainSubscriptions;

- (void)obtainFollowers;
- (void)obtainFollowersCount:(NSUInteger)count;
- (void)obtainFollowersCount:(NSUInteger)count
                      offset:(NSUInteger)offset;
- (void)obtainFollowersCustomOptions:(NSDictionary *)options;

@end
