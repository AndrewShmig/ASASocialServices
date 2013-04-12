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

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/users
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Users)

- (void)usersGetWithCustomOptions:(NSDictionary *)options;
- (void)usersSearchWithCustomOptions:(NSDictionary *)options;
- (void)usersIsAppUserWithCustomOptions:(NSDictionary *)options;
- (void)usersGetSubscriptionsWithCustomOptions:(NSDictionary *)options;
- (void)usersGetFollowersWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/groups
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Groups)

- (void)groupsIsMemberWithCustomOptions:(NSDictionary *)options;
- (void)groupsGetByIdWithCustomOptions:(NSDictionary *)options;
- (void)groupsGetWithCustomOptions:(NSDictionary *)options;
- (void)groupsGetMembersWithCustomOptions:(NSDictionary *)options;
- (void)groupsJoinWithCustomOptions:(NSDictionary *)options;
- (void)groupsLeaveWithCustomOptions:(NSDictionary *)options;
- (void)groupsSearchWithCustomOptions:(NSDictionary *)options;
- (void)groupsGetInvitesWithCustomOptions:(NSDictionary *)options;
- (void)groupsBanUserWithCustomOptions:(NSDictionary *)options;
- (void)groupsUnbanUserWithCustomOptions:(NSDictionary *)options;
- (void)groupsGetBannedWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/friends
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Friends)

- (void)friendsGetWithCustomOptions:(NSDictionary *)options;
- (void)friendsGetOnlineWithCustomOptions:(NSDictionary *)options;
- (void)friendsGetMutualWithCustomOptions:(NSDictionary *)options;
- (void)friendsGetRecentWithCustomOptions:(NSDictionary *)options;
- (void)friendsGetRequestsWithCustomOptions:(NSDictionary *)options;
- (void)friendsAddWithCustomOptions:(NSDictionary *)options;
- (void)friendsEditWithCustomOptions:(NSDictionary *)options;
- (void)friendsDeleteWithCustomOptions:(NSDictionary *)options;
- (void)friendsGetListsWithCustomOptions:(NSDictionary *)options;
- (void)friendsAddListWithCustomOptions:(NSDictionary *)options;
- (void)friendsEditListWithCustomOptions:(NSDictionary *)options;
- (void)friendsDeleteListWithCustomOptions:(NSDictionary *)options;
- (void)friendsGetAppUsersWithCustomOptions:(NSDictionary *)options;
- (void)friendsGetByPhonesWithCustomOptions:(NSDictionary *)options;
- (void)friendsDeleteAllRequestsWithCustomOptions:(NSDictionary *)options;
- (void)friendsGetSuggestionsWithCustomOptions:(NSDictionary *)options;
- (void)friendsAreFriendsWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/wall
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Wall)

- (void)wallGetWithCustomOptions:(NSDictionary *)options;
- (void)wallGetByIdWithCustomOptions:(NSDictionary *)options;
- (void)wallSavePostWithCustomOptions:(NSDictionary *)options;
- (void)wallPostWithCustomOptions:(NSDictionary *)options;
- (void)wallRepostWithCustomOptions:(NSDictionary *)options;
- (void)wallGetRepostsWithCustomOptions:(NSDictionary *)options;
- (void)wallEditWithCustomOptions:(NSDictionary *)options;
- (void)wallDeleteWithCustomOptions:(NSDictionary *)options;
- (void)wallRestoreWithCustomOptions:(NSDictionary *)options;
- (void)wallGetCommentsWithCustomOptions:(NSDictionary *)options;
- (void)wallAddCommentWithCustomOptions:(NSDictionary *)options;
- (void)wallDeleteCommentWithCustomOptions:(NSDictionary *)options;
- (void)wallRestoreCommentWithCustomOptions:(NSDictionary *)options;
- (void)wallGetLikesWithCustomOptions:(NSDictionary *)options;
- (void)wallAddLikeWithCustomOptions:(NSDictionary *)options;
- (void)wallDeleteLikeWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/photos
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Photos)

- (void)photosCreateAlbumWithCustomOptions:(NSDictionary *)options;
- (void)photosEditAlbumWithCustomOptions:(NSDictionary *)options;
- (void)photosGetAlbumsWithCustomOptions:(NSDictionary *)options;
- (void)photosGetWithCustomOptions:(NSDictionary *)options;
- (void)photosGetAlbumCountWithCustomOptions:(NSDictionary *)options;
- (void)photosGetProfileWithCustomOptions:(NSDictionary *)options;
- (void)photosGetByIdWithCustomOptions:(NSDictionary *)options;
- (void)photosGetUploadServerWithCustomOptions:(NSDictionary *)options;
- (void)photosGetProfileUploadServerWithCustomOptions:(NSDictionary *)options;
- (void)photosSaveProfilePhotoWithCustomOptions:(NSDictionary *)options;
- (void)photosSaveWallPhotoWithCustomOptions:(NSDictionary *)options;
- (void)photosGetWallUploadServerWithCustomOptions:(NSDictionary *)options;
- (void)photosGetMessagesUploadServerWithCustomOptions:(NSDictionary *)options;
- (void)photosSaveMessagesPhotoWithCustomOptions:(NSDictionary *)options;
- (void)photosSearchWithCustomOptions:(NSDictionary *)options;
- (void)photosSaveWithCustomOptions:(NSDictionary *)options;
- (void)photosEditWithCustomOptions:(NSDictionary *)options;
- (void)photosMoveWithCustomOptions:(NSDictionary *)options;
- (void)photosMakeCoverWithCustomOptions:(NSDictionary *)options;
- (void)photosReorderAlbumsWithCustomOptions:(NSDictionary *)options;
- (void)photosReorderPhotosWithCustomOptions:(NSDictionary *)options;
- (void)photosGetAllWithCustomOptions:(NSDictionary *)options;
- (void)photosGetUserPhotosWithCustomOptions:(NSDictionary *)options;
- (void)photosDeleteAlbumWithCustomOptions:(NSDictionary *)options;
- (void)photosDeleteWithCustomOptions:(NSDictionary *)options;
- (void)photosConfirmTagWithCustomOptions:(NSDictionary *)options;
- (void)photosGetCommentsWithCustomOptions:(NSDictionary *)options;
- (void)photosGetAllCommentsWithCustomOptions:(NSDictionary *)options;
- (void)photosCreateCommentWithCustomOptions:(NSDictionary *)options;
- (void)photosDeleteCommentWithCustomOptions:(NSDictionary *)options;
- (void)photosRestoreCommentWithCustomOptions:(NSDictionary *)options;
- (void)photosEditCommentWithCustomOptions:(NSDictionary *)options;
- (void)photosGetTagsWithCustomOptions:(NSDictionary *)options;
- (void)photosPutTagWithCustomOptions:(NSDictionary *)options;
- (void)photosRemoveTagWithCustomOptions:(NSDictionary *)options;
- (void)photosGetNewTagsWithCustomOptions:(NSDictionary *)options;

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