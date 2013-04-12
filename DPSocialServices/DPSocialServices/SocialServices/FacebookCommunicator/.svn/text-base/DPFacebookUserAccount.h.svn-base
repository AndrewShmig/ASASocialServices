//
//  DPFacebookUserAccount.h
//
//  Created by Andrew Shmig on 14.12.12.
//  Copyright (c) 2012 digipeople. All rights reserved.
//
//  Класс пользователя Facebook
//
//  Содержит в себе действующий access token и время, когда истечет срок его действия
//
//

#import <Foundation/Foundation.h>


static NSString *const kFACEBOOK_GRAPH_URL = @"https://graph.facebook.com/";
static NSString *const kFACEBOOK_USER_URL = @"https://graph.facebook.com/me";
static NSString *const kFACEBOOK_USER_FRIENDS_URL = @"https://graph.facebook.com/me/friends";
static NSString *const kFACEBOOK_USER_INBOX_URL = @"https://graph.facebook.com/me/inbox";
static NSString *const kFACEBOOK_USER_OUTBOX_URL = @"https://graph.facebook.com/me/outbox";
static NSString *const kFACEBOOK_USER_PHOTO_URL = @"https://graph.facebook.com/me/picture";
static NSString *const kFACEBOOK_USER_FEED_URL = @"https://graph.facebook.com/me/feed";


@interface DPFacebookUserAccount : NSObject

@property (nonatomic, readonly) NSString *accessToken;
@property (nonatomic, readonly) NSUInteger expirationTime;

@property (nonatomic, copy) void (^errorBlock)(NSError *);
@property (nonatomic, copy) void (^successBlock)(NSDictionary *);

- (id)initWithAccessToken:(NSString *)accessToken
           expirationTime:(NSUInteger)expirationTime;
- (id)initWithAccessToken:(NSString *)accessToken;

- (void)obtainInfo;
- (void)obtainInfoFields:(NSArray *)fields;

- (void)obtainPhoto;

- (void)publishToFeed:(NSString *)text;
- (void)publishToFeedCustomOptions:(NSDictionary *)options;

- (void)obtainFriends;
- (void)obtainFriendsCustomFields:(NSArray *)fields;

- (void)obtainDialogWithId:(NSString *)dialogId;
- (void)obtainDialogCommentsWithId:(NSString *)dialogId;
- (void)obtainDialogCommentsWithId:(NSString *)dialogId count:(NSUInteger)count;
- (void)obtainDialogCommentsWithId:(NSString *)dialogId
                             count:(NSUInteger)count
                            offset:(NSUInteger)offset;

- (void)obtainInboxDialogs;
- (void)obtainInboxDialogsCount:(NSUInteger)count;

- (void)obtainOutboxDialogs;
- (void)obtainOutboxDialogsCount:(NSUInteger)count;

@end
