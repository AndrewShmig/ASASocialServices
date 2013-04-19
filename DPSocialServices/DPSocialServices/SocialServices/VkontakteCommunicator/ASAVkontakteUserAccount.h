//
//  ASAVkontakteUserAccount.h
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>

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
@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/users
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Users)

- (void)usersGetWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)usersSearchWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)usersIsAppUserWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)usersGetSubscriptionsWithCustomOptions:(NSDictionary *)options
                                       success:(ASAVkontakteSuccessBlock)success
                                       failure:(ASAVkontakteFailureBlock)failure;

- (void)usersGetFollowersWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/groups
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Groups)

- (void)groupsIsMemberWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsGetByIdWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsGetWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsGetMembersWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsJoinWithCustomOptions:(NSDictionary *)options
                            success:(ASAVkontakteSuccessBlock)success
                            failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsLeaveWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsSearchWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsGetInvitesWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsBanUserWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsUnbanUserWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)groupsGetBannedWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/friends
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Friends)

- (void)friendsGetWithCustomOptions:(NSDictionary *)options
                            success:(ASAVkontakteSuccessBlock)success
                            failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsGetOnlineWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsGetMutualWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsGetRecentWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsGetRequestsWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsAddWithCustomOptions:(NSDictionary *)options
                            success:(ASAVkontakteSuccessBlock)success
                            failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsEditWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsDeleteWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsGetListsWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsAddListWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsEditListWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsDeleteListWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsGetAppUsersWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsGetByPhonesWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsDeleteAllRequestsWithCustomOptions:(NSDictionary *)options
                                          success:(ASAVkontakteSuccessBlock)success
                                          failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsGetSuggestionsWithCustomOptions:(NSDictionary *)options
                                       success:(ASAVkontakteSuccessBlock)success
                                       failure:(ASAVkontakteFailureBlock)failure;

- (void)friendsAreFriendsWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/wall
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Wall)

- (void)wallGetWithCustomOptions:(NSDictionary *)options
                         success:(ASAVkontakteSuccessBlock)success
                         failure:(ASAVkontakteFailureBlock)failure;

- (void)wallGetByIdWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)wallSavePostWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)wallPostWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)wallRepostWithCustomOptions:(NSDictionary *)options
                            success:(ASAVkontakteSuccessBlock)success
                            failure:(ASAVkontakteFailureBlock)failure;

- (void)wallGetRepostsWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)wallEditWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)wallDeleteWithCustomOptions:(NSDictionary *)options
                            success:(ASAVkontakteSuccessBlock)success
                            failure:(ASAVkontakteFailureBlock)failure;

- (void)wallRestoreWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)wallGetCommentsWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)wallAddCommentWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)wallDeleteCommentWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)wallRestoreCommentWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)wallGetLikesWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)wallAddLikeWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)wallDeleteLikeWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/photos
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Photos)

- (void)photosCreateAlbumWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)photosEditAlbumWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetAlbumsWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetAlbumCountWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetProfileWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetByIdWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetUploadServerWithCustomOptions:(NSDictionary *)options
                                       success:(ASAVkontakteSuccessBlock)success
                                       failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetProfileUploadServerWithCustomOptions:(NSDictionary *)options
                                              success:(ASAVkontakteSuccessBlock)success
                                              failure:(ASAVkontakteFailureBlock)failure;

- (void)photosSaveProfilePhotoWithCustomOptions:(NSDictionary *)options
                                        success:(ASAVkontakteSuccessBlock)success
                                        failure:(ASAVkontakteFailureBlock)failure;

- (void)photosSaveWallPhotoWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetWallUploadServerWithCustomOptions:(NSDictionary *)options
                                           success:(ASAVkontakteSuccessBlock)success
                                           failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetMessagesUploadServerWithCustomOptions:(NSDictionary *)options
                                               success:(ASAVkontakteSuccessBlock)success
                                               failure:(ASAVkontakteFailureBlock)failure;

- (void)photosSaveMessagesPhotoWithCustomOptions:(NSDictionary *)options
                                         success:(ASAVkontakteSuccessBlock)success
                                         failure:(ASAVkontakteFailureBlock)failure;

- (void)photosSearchWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)photosSaveWithCustomOptions:(NSDictionary *)options
                            success:(ASAVkontakteSuccessBlock)success
                            failure:(ASAVkontakteFailureBlock)failure;

- (void)photosEditWithCustomOptions:(NSDictionary *)options
                            success:(ASAVkontakteSuccessBlock)success
                            failure:(ASAVkontakteFailureBlock)failure;

- (void)photosMoveWithCustomOptions:(NSDictionary *)options
                            success:(ASAVkontakteSuccessBlock)success
                            failure:(ASAVkontakteFailureBlock)failure;

- (void)photosMakeCoverWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)photosReorderAlbumsWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)photosReorderPhotosWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetAllWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetUserPhotosWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)photosDeleteAlbumWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)photosDeleteWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)photosConfirmTagWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetCommentsWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetAllCommentsWithCustomOptions:(NSDictionary *)options
                                      success:(ASAVkontakteSuccessBlock)success
                                      failure:(ASAVkontakteFailureBlock)failure;

- (void)photosCreateCommentWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)photosDeleteCommentWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)photosRestoreCommentWithCustomOptions:(NSDictionary *)options
                                      success:(ASAVkontakteSuccessBlock)success
                                      failure:(ASAVkontakteFailureBlock)failure;

- (void)photosEditCommentWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetTagsWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)photosPutTagWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)photosRemoveTagWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)photosGetNewTagsWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/video
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Video)

- (void)videoGetWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)videoEditWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)videoAddWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)videoSaveWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)videoDeleteWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)videoRestoreWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)videoSearchWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)videoGetUserVideosWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)videoGetAlbumsWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)videoAddAlbumWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)videoEditAlbumWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)videoDeleteAlbumWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)videoMoveToAlbumWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)videoGetCommentsWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)videoCreateCommentWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)videoDeleteCommentWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)videoEditCommentWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)videoGetTagsWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)videoPutTagWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)videoRemoveTagWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)videoGetNewTagsWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/audio
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Audio)

- (void)audioGetWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)audioGetByIdWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)audioGetLyricsWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)audioSearchWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)audioGetUploadServerWithCustomOptions:(NSDictionary *)options
                                      success:(ASAVkontakteSuccessBlock)success
                                      failure:(ASAVkontakteFailureBlock)failure;

- (void)audioSaveWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)audioAddWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)audioDeleteWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)audioEditWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)audioReorderWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)audioRestoreWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)audioGetAlbumsWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)audioAddAlbumWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)audioEditAlbumWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)audioDeleteAlbumWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)audioMoveToAlbumWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)audioGetBroadcastWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)audioSetBroadcastWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)audioGetRecommendationsWithCustomOptions:(NSDictionary *)options
                                         success:(ASAVkontakteSuccessBlock)success
                                         failure:(ASAVkontakteFailureBlock)failure;

- (void)audioGetCountWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/messages
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Messages)

- (void)messagesGetWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesGetDialogsWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesGetByIdWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesSearchWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesGetHistoryWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesSendWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesDeleteWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesDeleteDialogWithCustomOptions:(NSDictionary *)options
                                      success:(ASAVkontakteSuccessBlock)success
                                      failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesRestoreWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesMarkAsNewWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesMarkAsReadWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesGetLongPollServerWithCustomOptions:(NSDictionary *)options
                                           success:(ASAVkontakteSuccessBlock)success
                                           failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesGetLongPollHistoryWithCustomOptions:(NSDictionary *)options
                                            success:(ASAVkontakteSuccessBlock)success
                                            failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesCreateChatWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesEditChatWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesGetChatUsersWithCustomOptions:(NSDictionary *)options
                                      success:(ASAVkontakteSuccessBlock)success
                                      failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesSetActivityWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesSearchDialogsWithCustomOptions:(NSDictionary *)options
                                       success:(ASAVkontakteSuccessBlock)success
                                       failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesAddChatUserWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesRemoveChatUserWithCustomOptions:(NSDictionary *)options
                                        success:(ASAVkontakteSuccessBlock)success
                                        failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesGetLastActivityWithCustomOptions:(NSDictionary *)options
                                         success:(ASAVkontakteSuccessBlock)success
                                         failure:(ASAVkontakteFailureBlock)failure;

- (void)messagesGetChatWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/newsfeed
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Newsfeed)

- (void)newsfeedGetWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)newsfeedGetRecommendedWithCustomOptions:(NSDictionary *)options
                                        success:(ASAVkontakteSuccessBlock)success
                                        failure:(ASAVkontakteFailureBlock)failure;

- (void)newsfeedGetCommentsWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)newsfeedGetMentionsWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)newsfeedGetBannedWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)newsfeedAddBanWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)newsfeedDeleteBanWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)newsfeedSearchWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)newsfeedGetListsWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/likes
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Likes)

- (void)likesGetListWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)likesAddWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)likesDeleteWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)likesIsLikedWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/account
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Account)

- (void)accountGetCountersWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)accountSetNameInMenuWithCustomOptions:(NSDictionary *)options
                                      success:(ASAVkontakteSuccessBlock)success
                                      failure:(ASAVkontakteFailureBlock)failure;

- (void)accountSetOnlineWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)accountImportContactsWithCustomOptions:(NSDictionary *)options
                                       success:(ASAVkontakteSuccessBlock)success
                                       failure:(ASAVkontakteFailureBlock)failure;

- (void)accountRegisterDeviceWithCustomOptions:(NSDictionary *)options
                                       success:(ASAVkontakteSuccessBlock)success
                                       failure:(ASAVkontakteFailureBlock)failure;

- (void)accountUnregisterDeviceWithCustomOptions:(NSDictionary *)options
                                         success:(ASAVkontakteSuccessBlock)success
                                         failure:(ASAVkontakteFailureBlock)failure;

- (void)accountSetSilenceModeWithCustomOptions:(NSDictionary *)options
                                       success:(ASAVkontakteSuccessBlock)success
                                       failure:(ASAVkontakteFailureBlock)failure;

- (void)accountGetPushSettingsWithCustomOptions:(NSDictionary *)options
                                        success:(ASAVkontakteSuccessBlock)success
                                        failure:(ASAVkontakteFailureBlock)failure;

- (void)accountGetAppPermissionsWithCustomOptions:(NSDictionary *)options
                                          success:(ASAVkontakteSuccessBlock)success
                                          failure:(ASAVkontakteFailureBlock)failure;

- (void)accountGetActiveOffersWithCustomOptions:(NSDictionary *)options
                                        success:(ASAVkontakteSuccessBlock)success
                                        failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/status
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Status)

- (void)statusGetWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)statusSetWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/pages
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Pages)

- (void)pagesGetWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)pagesSaveWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)pagesSaveAccessWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)pagesGetHistoryWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)pagesGetTitlesWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)pagesGetVersionWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)pagesParseWikiWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/board
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Board)

- (void)boardGetTopicsWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)boardGetCommentsWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)boardAddTopicWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)boardAddCommentWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)boardDeleteTopicWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)boardEditTopicWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)boardEditCommentWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)boardRestoreCommentWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)boardDeleteCommentWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)boardOpenTopicWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)boardCloseTopicWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)boardFixTopicWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)boardUnfixTopicWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/notes
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Notes)

- (void)notesGetWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)notesGetByIdWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)notesGetFriendsNotesWithCustomOptions:(NSDictionary *)options
                                      success:(ASAVkontakteSuccessBlock)success
                                      failure:(ASAVkontakteFailureBlock)failure;

- (void)notesAddWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)notesEditWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)notesDeleteWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)notesGetCommentsWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)notesCreateCommentWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)notesEditCommentWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)notesDeleteCommentWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)notesRestoreCommentWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/places
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Places)

- (void)placesAddWithCustomOptions:(NSDictionary *)options
                           success:(ASAVkontakteSuccessBlock)success
                           failure:(ASAVkontakteFailureBlock)failure;

- (void)placesGetByIdWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)placesSearchWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)placesCheckinWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)placesGetCheckinsWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

- (void)placesGetTypesWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

- (void)placesGetCountriesWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)placesGetRegionsWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)placesGetStreeByIdWithCustomOptions:(NSDictionary *)options
                                    success:(ASAVkontakteSuccessBlock)success
                                    failure:(ASAVkontakteFailureBlock)failure;

- (void)placesGetCountryByIdWithCustomOptions:(NSDictionary *)options
                                      success:(ASAVkontakteSuccessBlock)success
                                      failure:(ASAVkontakteFailureBlock)failure;

- (void)placesGetCitiesWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)placesGetCityByIdWithCustomOptions:(NSDictionary *)options
                                   success:(ASAVkontakteSuccessBlock)success
                                   failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/polls
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Polls)

- (void)pollsGetByIdWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)pollsAddVoteWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)pollsDeleteVoteWithCustomOptions:(NSDictionary *)options
                                 success:(ASAVkontakteSuccessBlock)success
                                 failure:(ASAVkontakteFailureBlock)failure;

- (void)pollsGetVotersWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/docs
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Docs)

- (void)docsGetWithCustomOptions:(NSDictionary *)options
                         success:(ASAVkontakteSuccessBlock)success
                         failure:(ASAVkontakteFailureBlock)failure;

- (void)docsGetByIdWithCustomOptions:(NSDictionary *)options
                             success:(ASAVkontakteSuccessBlock)success
                             failure:(ASAVkontakteFailureBlock)failure;

- (void)docsGetUploadServerWithCustomOptions:(NSDictionary *)options
                                     success:(ASAVkontakteSuccessBlock)success
                                     failure:(ASAVkontakteFailureBlock)failure;

- (void)docsGetWallUploadServerWithCustomOptions:(NSDictionary *)options
                                         success:(ASAVkontakteSuccessBlock)success
                                         failure:(ASAVkontakteFailureBlock)failure;

- (void)docsSaveWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

- (void)docsDeleteWithCustomOptions:(NSDictionary *)options
                            success:(ASAVkontakteSuccessBlock)success
                            failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/fave
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Fave)

- (void)faveGetUsersWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)faveGetPhotosWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)faveGetPostsWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

- (void)faveGetVideosWithCustomOptions:(NSDictionary *)options
                               success:(ASAVkontakteSuccessBlock)success
                               failure:(ASAVkontakteFailureBlock)failure;

- (void)faveGetLinksWithCustomOptions:(NSDictionary *)options
                              success:(ASAVkontakteSuccessBlock)success
                              failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/notifications
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Notifications)

- (void)notificationsGetWithCustomOptions:(NSDictionary *)options
                                  success:(ASAVkontakteSuccessBlock)success
                                  failure:(ASAVkontakteFailureBlock)failure;

- (void)notificationsMarkAsViewedWithCustomOptions:(NSDictionary *)options
                                           success:(ASAVkontakteSuccessBlock)success
                                           failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/stats
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Stats)

- (void)statsGetWithCustomOptions:(NSDictionary *)options
                          success:(ASAVkontakteSuccessBlock)success
                          failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/search
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Search)

- (void)searchGetHintsWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Documentation: https://vk.com/dev/apps
// -----------------------------------------------------------------------------
@interface ASAVkontakteUserAccount (Apps)

- (void)appsGetCatalogWithCustomOptions:(NSDictionary *)options
                                success:(ASAVkontakteSuccessBlock)success
                                failure:(ASAVkontakteFailureBlock)failure;

@end

// -----------------------------------------------------------------------------
// Uploding files to VK servers
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