//
//  DPVkontakteUserAccount.m
//
//  Created by Andrew Shmig on 18.12.12.
//  Copyright (c) 2012 DigiPeople Inc. All rights reserved.
//

#import "DPVkontakteUserAccount.h"
#import "NSString+encodeURL.h"

#define LOG_ON 1

#if LOG_ON == 1
# define DEBUG_CURRENT_METHOD() NSLog(@"%s", __FUNCTION__)
# define DEBUG_INFO(x) NSLog(@"%@", x)
#endif

static const NSInteger kTIME_OUT_INTERVAL = 3*60; // 3 минуты

static const NSString *VkontakteUserAccountDomain = @"VkontakteUserAccountDomain";

enum
{
    VkontakteUserAccountRequestError = -1
};

@implementation DPVkontakteUserAccount

@synthesize accessToken = _accessToken;
@synthesize userId = _userId;
@synthesize expirationTime = _expirationTime;
@synthesize errorBlock = _errorBlock;
@synthesize successBlock = _successBlock;

#pragma mark - Init method
- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                      expirationTime:(NSInteger)expirationTime
                              userId:(NSInteger)userId
{
    self = [super init];

    if (self) {
        // init
        _accessToken = accessToken;
        _userId = userId;
        _expirationTime = expirationTime;


        _errorBlock = [^(NSError *error)
        { // default error block
            DEBUG_INFO(@"[DPVkontakteUserAccount] errorBlock is empty.");
        } copy];

        _successBlock = [^(NSDictionary *dictionary)
        { // default success block
            DEBUG_INFO(@"[DPVkontakteUserAccount] successBlock is empty.");
        } copy];
    }

    return self;
}

- (id)initUserAccountWithAccessToken:(NSString *)accessToken
                              userId:(NSUInteger)userId
{
    return [self initUserAccountWithAccessToken:accessToken
                                 expirationTime:0
                                         userId:userId];
}

- (id)init
{
    @throw [NSException exceptionWithName:@"Invalid init method used."
                                   reason:@"Invalid init method used."
                                 userInfo:nil];
}

#pragma mark - Public VK User methods

- (void)obtainInfo
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_INFO_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uids"   : @(_userId),
                                    @"fields" : @"nickname,screen_name,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,has_mobile,contacts,education,online,counters,relation,last_seen,activity,can_write_private_message,can_see_all_posts,can_post,universities"}];
}

- (void)obtainInfoCustomOptions:(NSDictionary *)options
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_INFO_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:options];
}

- (void)obtainInfoWithCustomOptions:(NSDictionary *)options
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_INFO_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:options];
}

- (void)obtainInfoForUser:(NSString *)userId
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_INFO_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uids"   : userId,
                                    @"fields" : @"nickname,screen_name,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,has_mobile,contacts,education,online,counters,relation,last_seen,activity,can_write_private_message,can_see_all_posts,can_post,universities"}];
}

- (void)postToWall:(NSString *)text
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_WALL_POST_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"owner_id" : @(_userId),
                                    @"message"  : text}];

}

- (void)postToWallWithCustomOptions:(NSDictionary *)options
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_WALL_POST_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:options];
}

- (void)uploadPhoto:(NSString *)photoPath
{

    DEBUG_CURRENT_METHOD();

    // шаг 1 - С помощью метода photos.getMessagesUploadServer приложение
    //         узнает http-адрес для загрузки фотографии в личное сообщение.
    NSDictionary *responseJSON = [self photosGetMessagesUploadServer];

    // шаг 2 - Приложение формирует POST-запрос на полученный адрес.
    //         Запрос должен включать поле photo, содержащее файл с
    //         изображением (JPG, PNG, BMP или GIF)
    responseJSON = [self uploadMessagesPhoto:photoPath options:responseJSON];

    // шаг 3 - С помощью метода photos.saveMessagesPhoto приложение передает
    //         серверу полученные данные (server, photo и hash) и получает данные
    //         о загруженной фотографии.
    responseJSON = [self photosSaveMessagesPhoto:responseJSON];

    _successBlock(responseJSON);
}

- (void)sendPrivateMessage:(NSString *)message
                  toUserId:(NSString *)userId
{
    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_SEND_MESSAGE_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid":userId,
                                    @"message":message}];
}

- (void)sendPrivateMessage:(NSString *)message
                     photo:(NSString *)photoPath
                  toUserId:(NSString *)userId
{
    DEBUG_CURRENT_METHOD();

    __block id me = self;

    // сохраняем основной блок обработки успешного исхода запроса
    void (^successBlockCopy)(NSDictionary *) = _successBlock;

    // блок обработки результата отправки фотографии на сервер ВК
    _successBlock = ^(NSDictionary *response){
        NSString *attachmentId = response[@"response"][0][@"id"];
        NSDictionary *options = @{@"uid"        : userId,
                                  @"message"    : message,
                                  @"attachment" : attachmentId};

        // возвращаем первоначальный блок обработки в случае успеха
        [me setSuccessBlock:successBlockCopy];

        // отправляем сообщение с опциями
        [me sendPrivateMessageWithCustomOptions:options];
    };

    // отправка фотографии на сервер ВК
    [self uploadPhoto:photoPath];
}


- (void)sendPrivateMessageWithCustomOptions:(NSDictionary *)options
{
    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_SEND_MESSAGE_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:options];
}

- (void)obtainLastSentMessagesCount:(NSUInteger)count
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_MESSAGES_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"out"   : @"1",
                                    @"count" : @(count)}];
}

- (void)obtainLastSentMessagesCount:(NSUInteger)count
                             offset:(NSUInteger)offset
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_MESSAGES_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"out"    : @1,
                                    @"count"  : @(count),
                                    @"offset" : @(offset)}];
}

- (void)obtainLastMessagesWithCustomOptions:(NSDictionary *)options
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_MESSAGES_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:options];
}

- (void)obtainLastSentUnreadMessagesCount:(NSUInteger)count
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_MESSAGES_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"out"   : @0,
                                    @"count" : @(count)}];
}

- (void)obtainLastSentUnreadMessagesCount:(NSUInteger)count
                                   offset:(NSUInteger)offset
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_MESSAGES_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"out"    : @1,
                                    @"count"  : @(count),
                                    @"offset" : @(offset)}];
}

- (void)obtainDialogMessagesWithUser:(NSString *)userId
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_MESSAGES_USER_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid" : userId,
                                    @"rev" : @1}];
}

- (void)obtainDialogMessagesWithUser:(NSString *)userId
                               count:(NSUInteger)count
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_MESSAGES_USER_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid"   : userId,
                                    @"rev"   : @1,
                                    @"count" : @(count)}];
}

- (void)obtainDialogMessagesWithUser:(NSString *)userId
                               count:(NSUInteger)count
                              offset:(NSUInteger)offset
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_MESSAGES_USER_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid"    : userId,
                                    @"rev"    : @1,
                                    @"count"  : @(count),
                                    @"offset" : @(offset)}];
}

- (void)obtainDialogMessagesWithCustomOptions:(NSDictionary *)options
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_MESSAGES_USER_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:options];
}

- (void)obtainFriends
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_FRIENDS_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid"    : @(_userId),
                                    @"order"  : @"name",
                                    @"fields" : @"uid,first_name,last_name,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,domain,has_mobile,education"}];

}

- (void)obtainFriendsCount:(NSUInteger)count
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_FRIENDS_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid"    : @(_userId),
                                    @"order"  : @"name",
                                    @"count"  : @(count),
                                    @"fields" : @"uid,first_name,last_name,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,domain,has_mobile,education"}];
}

- (void)obtainFriendsCount:(NSUInteger)count
                    offset:(NSUInteger)offset
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_FRIENDS_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid"    : @(_userId),
                                    @"order"  : @"name",
                                    @"count"  : @(count),
                                    @"offset" : @(offset),
                                    @"fields" : @"uid,first_name,last_name,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,domain,has_mobile,education"}];
}

- (void)obtainFriendsWithCustomOptions:(NSDictionary *)options
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_FRIENDS_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:options];
}

- (void)obtainSubscriptions
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_SUBSCRIPTIONS_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid" : @(_userId)}];
}

- (void)obtainFollowers
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_FOLLOWERS_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid"    : @(_userId),
                                    @"fields" : @"nickname,screen_name,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,has_mobile,rate,contacts,education,online"}];
}

- (void)obtainFollowersCount:(NSUInteger)count
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_FOLLOWERS_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid"    : @(_userId),
                                    @"count"  : @(count),
                                    @"fields" : @"nickname,screen_name,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,has_mobile,rate,contacts,education,online"}];
}

- (void)obtainFollowersCount:(NSUInteger)count
                      offset:(NSUInteger)offset
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_FOLLOWERS_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:@{@"uid"    : @(_userId),
                                    @"fields" : @"nickname,screen_name,sex,bdate,city,country,timezone,photo,photo_medium,photo_big,has_mobile,rate,contacts,education,online",
                                    @"count"  : @(count),
                                    @"offset" : @(offset)}];
}

- (void)obtainFollowersWithCustomOptions:(NSDictionary *)options
{

    DEBUG_CURRENT_METHOD();

    [self sendVkontakteRequestURL:kVKONTAKTE_USER_FOLLOWERS_URL
                       HTTPMethod:@"GET"
                 paramsDictionary:options];
}

- (NSString *)description
{

    DEBUG_CURRENT_METHOD();

    return [NSString stringWithFormat:@"User id:%lu, expiration time:%lu",
                                      (unsigned long) _userId,
                                      (unsigned long) _expirationTime];
}

#pragma mark - Закрытые методы

- (NSDictionary *)photosGetMessagesUploadServer
{

    DEBUG_CURRENT_METHOD();

    NSString *urlAsString = [NSString stringWithFormat:@"%@?access_token=%@",
                                                       kVKONTAKTE_PHOTO_UPLOAD_MESSAGES_SERVER_URL,
                                                       _accessToken];
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    return [self sendRequest:request];
}

- (NSDictionary *)photosSaveMessagesPhoto:(NSDictionary *)options
{

    DEBUG_CURRENT_METHOD();

    NSString *hash = options[@"hash"];
    NSString *photo = [options[@"photo"] encodeURL];
    NSString *server = options[@"server"];
    NSString *queryString = [NSString
            stringWithFormat:@"access_token=%@&hash=%@&photo=%@&server=%@",
            _accessToken, hash, photo, server];

    NSString *urlAsString = [NSString stringWithFormat:@"%@?%@",
                                                       kVKONTAKTE_PHOTO_SAVE_MESSAGES_UPLOADED_URL,
                                                       queryString];

    NSURL *url = [NSURL URLWithString:urlAsString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    return [self sendRequest:request];
}

- (NSDictionary *)sendRequest:(NSMutableURLRequest *)request
{
    DEBUG_CURRENT_METHOD();

    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];

    NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
    if (error != nil) {
        _errorBlock(error);
        return nil;
    }

    if (statusCode != 200) {
        error = [NSError errorWithDomain:VkontakteUserAccountDomain
                                    code:VkontakteUserAccountRequestError
                                userInfo:@{@"statusCode" : @(statusCode),
                                           @"response"   : [NSString stringWithCString:[responseData bytes]
                                                                              encoding:NSUTF8StringEncoding]}];

        _errorBlock(error);
        return nil;
    }

    return [NSJSONSerialization JSONObjectWithData:responseData
                                           options:NSJSONReadingMutableContainers
                                             error:nil];
}

- (NSDictionary *)uploadMessagesPhoto:(NSString *)photoPath
                              options:(NSDictionary *)options
{

    DEBUG_CURRENT_METHOD();

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&access_token=%@",
                                                                 options[@"response"][@"upload_url"],
                                                                 _accessToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *photoData = [NSData dataWithContentsOfFile:photoPath];
    NSURLResponse *response = nil;
    NSError *error = nil;

    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:kTIME_OUT_INTERVAL];

    NSString *boundary = @"AndrewShmigDelimiterString";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",
                                                       boundary];
    [request setValue:contentType forHTTPHeaderField:@"Content-Type"];

    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary]
                                dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"photo\"; filename=\"%@\"\r\n",
                                                 photoPath]
                                                 dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:photoData];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary]
                                dataUsingEncoding:NSUTF8StringEncoding]];

    [request setHTTPBody:body];

    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];

    NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];
    if (error != nil) {
        _errorBlock(error);
        return nil;
    }

    if (statusCode != 200) {
        error = [NSError errorWithDomain:VkontakteUserAccountDomain
                                    code:VkontakteUserAccountRequestError
                                userInfo:@{@"statusCode" : @(statusCode),
                                           @"response"   : [NSString stringWithCString:[responseData bytes]
                                                                              encoding:NSUTF8StringEncoding]}];
        _errorBlock(error);
        return nil;
    }

    return [NSJSONSerialization JSONObjectWithData:responseData
                                           options:NSJSONReadingMutableContainers
                                             error:nil];

}

- (BOOL)sendVkontakteRequestURL:(NSString *)requestURL
                     HTTPMethod:(NSString *)httpMethod
               paramsDictionary:(NSDictionary *)params
{

    DEBUG_CURRENT_METHOD();

    NSMutableString *mutableRequestURL = [requestURL mutableCopy];

    if ([httpMethod isEqualToString:@"GET"]) {
        [mutableRequestURL appendFormat:@"?"];

        [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
        {
            [mutableRequestURL appendFormat:@"%@=%@&", key, [obj encodeURL]];
        }];
    }

    [mutableRequestURL appendFormat:@"access_token=%@", _accessToken];

    NSURL *url = [NSURL URLWithString:mutableRequestURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    [request setHTTPMethod:httpMethod];
    [request addValue:@"application/x-www-form-urlencoded"
             forHTTPHeaderField:@"Content-Type"];


    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];

    NSInteger statusCode = [(NSHTTPURLResponse *) response statusCode];

    DEBUG_INFO(@(statusCode));

    NSError *jsonParserError = nil;
    id jsonResponse = [NSJSONSerialization JSONObjectWithData:responseData
                                                      options:NSJSONReadingMutableContainers
                                                        error:&jsonParserError];

    if (jsonParserError != nil) {
        _errorBlock(jsonParserError);
        return NO;
    }

    if (error != nil || statusCode != 200 || response == nil) {
        error = [NSError errorWithDomain:VkontakteUserAccountDomain
                                    code:VkontakteUserAccountRequestError
                                userInfo:@{NSLocalizedDescriptionKey : jsonResponse,
                                           @"HTTP Status Code"       : @(statusCode)}];
        _errorBlock(error);

        return NO;
    }

    _successBlock(jsonResponse);

    return YES;
}

@end
