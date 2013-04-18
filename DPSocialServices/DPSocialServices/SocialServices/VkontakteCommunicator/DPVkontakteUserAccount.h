//
//  DPVkontakteUserAccount.h
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>

static NSString *const kVKONTAKTE_API_URL = @"https://api.vk.com/method/";


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
                              userId:(NSInteger)userId;
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

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/video
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Video)

- (void)videoGetWithCustomOptions:(NSDictionary *)options;
- (void)videoEditWithCustomOptions:(NSDictionary *)options;
- (void)videoAddWithCustomOptions:(NSDictionary *)options;
- (void)videoSaveWithCustomOptions:(NSDictionary *)options;
- (void)videoDeleteWithCustomOptions:(NSDictionary *)options;
- (void)videoRestoreWithCustomOptions:(NSDictionary *)options;
- (void)videoSearchWithCustomOptions:(NSDictionary *)options;
- (void)videoGetUserVideosWithCustomOptions:(NSDictionary *)options;
- (void)videoGetAlbumsWithCustomOptions:(NSDictionary *)options;
- (void)videoAddAlbumWithCustomOptions:(NSDictionary *)options;
- (void)videoEditAlbumWithCustomOptions:(NSDictionary *)options;
- (void)videoDeleteAlbumWithCustomOptions:(NSDictionary *)options;
- (void)videoMoveToAlbumWithCustomOptions:(NSDictionary *)options;
- (void)videoGetCommentsWithCustomOptions:(NSDictionary *)options;
- (void)videoCreateCommentWithCustomOptions:(NSDictionary *)options;
- (void)videoDeleteCommentWithCustomOptions:(NSDictionary *)options;
- (void)videoEditCommentWithCustomOptions:(NSDictionary *)options;
- (void)videoGetTagsWithCustomOptions:(NSDictionary *)options;
- (void)videoPutTagWithCustomOptions:(NSDictionary *)options;
- (void)videoRemoveTagWithCustomOptions:(NSDictionary *)options;
- (void)videoGetNewTagsWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/audio
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Audio)

- (void)audioGetWithCustomOptions:(NSDictionary *)options;
- (void)audioGetByIdWithCustomOptions:(NSDictionary *)options;
- (void)audioGetLyricsWithCustomOptions:(NSDictionary *)options;
- (void)audioSearchWithCustomOptions:(NSDictionary *)options;
- (void)audioGetUploadServerWithCustomOptions:(NSDictionary *)options;
- (void)audioSaveWithCustomOptions:(NSDictionary *)options;
- (void)audioAddWithCustomOptions:(NSDictionary *)options;
- (void)audioDeleteWithCustomOptions:(NSDictionary *)options;
- (void)audioEditWithCustomOptions:(NSDictionary *)options;
- (void)audioReorderWithCustomOptions:(NSDictionary *)options;
- (void)audioRestoreWithCustomOptions:(NSDictionary *)options;
- (void)audioGetAlbumsWithCustomOptions:(NSDictionary *)options;
- (void)audioAddAlbumWithCustomOptions:(NSDictionary *)options;
- (void)audioEditAlbumWithCustomOptions:(NSDictionary *)options;
- (void)audioDeleteAlbumWithCustomOptions:(NSDictionary *)options;
- (void)audioMoveToAlbumWithCustomOptions:(NSDictionary *)options;
- (void)audioGetBroadcastWithCustomOptions:(NSDictionary *)options;
- (void)audioSetBroadcastWithCustomOptions:(NSDictionary *)options;
- (void)audioGetRecommendationsWithCustomOptions:(NSDictionary *)options;
- (void)audioGetCountWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/messages
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Messages)

- (void)messagesGetWithCustomOptions:(NSDictionary *)options;
- (void)messagesGetDialogsWithCustomOptions:(NSDictionary *)options;
- (void)messagesGetByIdWithCustomOptions:(NSDictionary *)options;
- (void)messagesSearchWithCustomOptions:(NSDictionary *)options;
- (void)messagesGetHistoryWithCustomOptions:(NSDictionary *)options;
- (void)messagesSendWithCustomOptions:(NSDictionary *)options;
- (void)messagesDeleteWithCustomOptions:(NSDictionary *)options;
- (void)messagesDeleteDialogWithCustomOptions:(NSDictionary *)options;
- (void)messagesRestoreWithCustomOptions:(NSDictionary *)options;
- (void)messagesMarkAsNewWithCustomOptions:(NSDictionary *)options;
- (void)messagesMarkAsReadWithCustomOptions:(NSDictionary *)options;
- (void)messagesGetLongPollServerWithCustomOptions:(NSDictionary *)options;
- (void)messagesGetLongPollHistoryWithCustomOptions:(NSDictionary *)options;
- (void)messagesCreateChatWithCustomOptions:(NSDictionary *)options;
- (void)messagesEditChatWithCustomOptions:(NSDictionary *)options;
- (void)messagesGetChatUsersWithCustomOptions:(NSDictionary *)options;
- (void)messagesSetActivityWithCustomOptions:(NSDictionary *)options;
- (void)messagesSearchDialogsWithCustomOptions:(NSDictionary *)options;
- (void)messagesAddChatUserWithCustomOptions:(NSDictionary *)options;
- (void)messagesRemoveChatUserWithCustomOptions:(NSDictionary *)options;
- (void)messagesGetLastActivityWithCustomOptions:(NSDictionary *)options;
- (void)messagesGetChatWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/newsfeed
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Newsfeed)

- (void)newsfeedGetWithCustomOptions:(NSDictionary *)options;
- (void)newsfeedGetRecommendedWithCustomOptions:(NSDictionary *)options;
- (void)newsfeedGetCommentsWithCustomOptions:(NSDictionary *)options;
- (void)newsfeedGetMentionsWithCustomOptions:(NSDictionary *)options;
- (void)newsfeedGetBannedWithCustomOptions:(NSDictionary *)options;
- (void)newsfeedAddBanWithCustomOptions:(NSDictionary *)options;
- (void)newsfeedDeleteBanWithCustomOptions:(NSDictionary *)options;
- (void)newsfeedSearchWithCustomOptions:(NSDictionary *)options;
- (void)newsfeedGetListsWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/likes
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Likes)

- (void)likesGetListWithCustomOptions:(NSDictionary *)options;
- (void)likesAddWithCustomOptions:(NSDictionary *)options;
- (void)likesDeleteWithCustomOptions:(NSDictionary *)options;
- (void)likesIsLikedWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/account
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Account)

- (void)accountGetCountersWithCustomOptions:(NSDictionary *)options;
- (void)accountSetNameInMenuWithCustomOptions:(NSDictionary *)options;
- (void)accountSetOnlineWithCustomOptions:(NSDictionary *)options;
- (void)accountImportContactsWithCustomOptions:(NSDictionary *)options;
- (void)accountRegisterDeviceWithCustomOptions:(NSDictionary *)options;
- (void)accountUnregisterDeviceWithCustomOptions:(NSDictionary *)options;
- (void)accountSetSilenceModeWithCustomOptions:(NSDictionary *)options;
- (void)accountGetPushSettingsWithCustomOptions:(NSDictionary *)options;
- (void)accountGetAppPermissionsWithCustomOptions:(NSDictionary *)options;
- (void)accountGetActiveOffersWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/status
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Status)

- (void)statusGetWithCustomOptions:(NSDictionary *)options;
- (void)statusSetWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/pages
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Pages)

- (void)pagesGetWithCustomOptions:(NSDictionary *)options;
- (void)pagesSaveWithCustomOptions:(NSDictionary *)options;
- (void)pagesSaveAccessWithCustomOptions:(NSDictionary *)options;
- (void)pagesGetHistoryWithCustomOptions:(NSDictionary *)options;
- (void)pagesGetTitlesWithCustomOptions:(NSDictionary *)options;
- (void)pagesGetVersionWithCustomOptions:(NSDictionary *)options;
- (void)pagesParseWikiWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/board
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Board)

- (void)boardGetTopicsWithCustomOptions:(NSDictionary *)options;
- (void)boardGetCommentsWithCustomOptions:(NSDictionary *)options;
- (void)boardAddTopicWithCustomOptions:(NSDictionary *)options;
- (void)boardAddCommentWithCustomOptions:(NSDictionary *)options;
- (void)boardDeleteTopicWithCustomOptions:(NSDictionary *)options;
- (void)boardEditTopicWithCustomOptions:(NSDictionary *)options;
- (void)boardEditCommentWithCustomOptions:(NSDictionary *)options;
- (void)boardRestoreCommentWithCustomOptions:(NSDictionary *)options;
- (void)boardDeleteCommentWithCustomOptions:(NSDictionary *)options;
- (void)boardOpenTopicWithCustomOptions:(NSDictionary *)options;
- (void)boardCloseTopicWithCustomOptions:(NSDictionary *)options;
- (void)boardFixTopicWithCustomOptions:(NSDictionary *)options;
- (void)boardUnfixTopicWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/notes
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Notes)

- (void)notesGetWithCustomOptions:(NSDictionary *)options;
- (void)notesGetByIdWithCustomOptions:(NSDictionary *)options;
- (void)notesGetFriendsNotesWithCustomOptions:(NSDictionary *)options;
- (void)notesAddWithCustomOptions:(NSDictionary *)options;
- (void)notesEditWithCustomOptions:(NSDictionary *)options;
- (void)notesDeleteWithCustomOptions:(NSDictionary *)options;
- (void)notesGetCommentsWithCustomOptions:(NSDictionary *)options;
- (void)notesCreateCommentWithCustomOptions:(NSDictionary *)options;
- (void)notesEditCommentWithCustomOptions:(NSDictionary *)options;
- (void)notesDeleteCommentWithCustomOptions:(NSDictionary *)options;
- (void)notesRestoreCommentWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/places
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Places)

- (void)placesAddWithCustomOptions:(NSDictionary *)options;
- (void)placesGetByIdWithCustomOptions:(NSDictionary *)options;
- (void)placesSearchWithCustomOptions:(NSDictionary *)options;
- (void)placesCheckinWithCustomOptions:(NSDictionary *)options;
- (void)placesGetCheckinsWithCustomOptions:(NSDictionary *)options;
- (void)placesGetTypesWithCustomOptions:(NSDictionary *)options;
- (void)placesGetCountriesWithCustomOptions:(NSDictionary *)options;
- (void)placesGetRegionsWithCustomOptions:(NSDictionary *)options;
- (void)placesGetStreeByIdWithCustomOptions:(NSDictionary *)options;
- (void)placesGetCountryByIdWithCustomOptions:(NSDictionary *)options;
- (void)placesGetCitiesWithCustomOptions:(NSDictionary *)options;
- (void)placesGetCityByIdWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/polls
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Polls)

- (void)pollsGetByIdWithCustomOptions:(NSDictionary *)options;
- (void)pollsAddVoteWithCustomOptions:(NSDictionary *)options;
- (void)pollsDeleteVoteWithCustomOptions:(NSDictionary *)options;
- (void)pollsGetVotersWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/docs
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Docs)

- (void)docsGetWithCustomOptions:(NSDictionary *)options;
- (void)docsGetByIdWithCustomOptions:(NSDictionary *)options;
- (void)docsGetUploadServerWithCustomOptions:(NSDictionary *)options;
- (void)docsGetWallUploadServerWithCustomOptions:(NSDictionary *)options;
- (void)docsSaveWithCustomOptions:(NSDictionary *)options;
- (void)docsDeleteWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/fave
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Fave)

- (void)faveGetUsersWithCustomOptions:(NSDictionary *)options;
- (void)faveGetPhotosWithCustomOptions:(NSDictionary *)options;
- (void)faveGetPostsWithCustomOptions:(NSDictionary *)options;
- (void)faveGetVideosWithCustomOptions:(NSDictionary *)options;
- (void)faveGetLinksWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/notifications
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Notifications)

- (void)notificationsGetWithCustomOptions:(NSDictionary *)options;
- (void)notificationsMarkAsViewedWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/stats
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Stats)

- (void)statsGetWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/search
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Search)

- (void)searchGetHintsWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/apps
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Apps)

- (void)appsGetCatalogWithCustomOptions:(NSDictionary *)options;

@end

// -----------------------------------------------------------------------------
// Uploding files to VK servers
// -----------------------------------------------------------------------------
@interface DPVkontakteUserAccount(Upload)

- (void)uploadDocument:(NSString *)documentPath
                 toURL:(NSURL *)url
           withOptions:(NSDictionary *)options;

- (void)uploadPhoto:(NSString *)photoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options;

- (void)uploadAlbumPhoto:(NSString *)photoPath
                   toURL:(NSURL *)url
             withOptions:(NSDictionary *)options;

- (void)uploadAudio:(NSString *)audioPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options;

- (void)uploadVideo:(NSString *)videoPath
              toURL:(NSURL *)url
        withOptions:(NSDictionary *)options;

@end