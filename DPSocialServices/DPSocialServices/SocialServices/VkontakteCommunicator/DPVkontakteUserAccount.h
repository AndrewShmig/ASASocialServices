//
//  DPVkontakteUserAccount.h
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>

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
@end

@interface DPVkontakteUserAccount(Users)
@end

@interface DPVkontakteUserAccount(Groups)
@end

@interface DPVkontakteUserAccount(Friends)
@end

@interface DPVkontakteUserAccount(Wall)
@end

@interface DPVkontakteUserAccount(Photos)
@end

@interface DPVkontakteUserAccount(Video)
@end

@interface DPVkontakteUserAccount(Audio)
@end

@interface DPVkontakteUserAccount(Messages)
@end

@interface DPVkontakteUserAccount(Newsfeed)
@end

@interface DPVkontakteUserAccount(Likes)
@end

@interface DPVkontakteUserAccount(Account)
@end

@interface DPVkontakteUserAccount(Status)
@end

@interface DPVkontakteUserAccount(Pages)
@end

@interface DPVkontakteUserAccount(Board)
@end

@interface DPVkontakteUserAccount(Notes)
@end

@interface DPVkontakteUserAccount(Places)
@end

@interface DPVkontakteUserAccount(Polls)
@end

@interface DPVkontakteUserAccount(Docs)
@end

@interface DPVkontakteUserAccount(Fave)
@end

@interface DPVkontakteUserAccount(Notifications)
@end

@interface DPVkontakteUserAccount(Stats)
@end

@interface DPVkontakteUserAccount(Search)
@end

@interface DPVkontakteUserAccount(Apps)
@end