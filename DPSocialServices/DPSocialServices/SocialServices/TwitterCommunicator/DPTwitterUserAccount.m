//
//  DPTwitterUserAccount.m
//
//  Created by AndrewShmig on 11.12.12.
//  Copyright (c) 2012 AndrewShmig. All rights reserved.
//

#import "DPTwitterUserAccount.h"

#define LOG_ON 1

#if LOG_ON == 1
# define DEBUG_CURRENT_METHOD() NSLog(@"%s", __FUNCTION__)
# define DEBUG_INFO(x) NSLog(@"%@", x)
#endif

static const NSString *kTwitterUserAccountDomain = @"kTwitterUserAccountDomain";

enum {
  TwitterUserAccountRequestError,
  TwitterUserAccountNilTwitterUserId
};

@implementation DPTwitterUserAccount

@synthesize oauthToken = _oauthToken,
            oauthTokenSecret = _oauthTokenSecret,
            screenName = _screenName,
            twitterUserID = _twitterUserID;

@synthesize errorBlock = _errorBlock,
            successBlock = _successBlock;

#pragma mark - Initialization
// huh! your done here %)
- (id)init {
  @throw ([NSException exceptionWithName:@"Invalid init method used."
                                  reason:@"Invalid init method used."
                                userInfo:nil]);
}

- (id)initWithToken:(NSString *)token
        tokenSecret:(NSString *)tokenSecret
      twitterUserID:(NSString *)userId
     userScreenName:(NSString *)screenName {

  DEBUG_CURRENT_METHOD();

  self = [super init];

  if (self) {
    _oauthToken = [token copy];
    _oauthTokenSecret = [tokenSecret copy];
    _twitterUserID = [userId copy];
    _screenName = [screenName copy];

    _errorBlock = [^(NSError *error){ // default error block
      DEBUG_INFO(@"[TwitterUserAccount] errorBlock is empty.");
    } copy];

    _successBlock = [^(NSDictionary *dictionary){ // default success block
      DEBUG_INFO(@"[TwitterUserAccount] successBlock is empty.");
    } copy];
  }

  return self;
}

#pragma mark - Public methods
- (BOOL)isAuthorized {
  
  DEBUG_CURRENT_METHOD();
  
  __block BOOL authorized = NO;
  void (^errorBlockCopy)(NSError *) = [_errorBlock copy]; // делаем копию блока обработки ошибок, если он до этого был установлен
  
  _errorBlock = [^(NSError *error){
    NSDictionary *errors = [error userInfo][NSLocalizedDescriptionKey][@"errors"][0];
    
    // code = 89, Invalid or expired token
    if([errors[@"code"] compare:@89] == NSOrderedSame)
      authorized = NO;
    else
      authorized = YES;
  } copy];
  
  [self verifyCredentials];
  
  [self setErrorBlock:errorBlockCopy]; // восстанавливаем значение блока обработки ошибок
  
  return authorized;
}

- (void)setErrorBlock:(void (^)(NSError *))errorBlock {

  DEBUG_CURRENT_METHOD();

  if(errorBlock == nil)
    _errorBlock = [^(NSError *error){ // default error block
      DEBUG_INFO(@"[TwitterUserAccount] errorBlock is empty.");
    } copy];
  else
    _errorBlock = [errorBlock copy];
}

- (void)setSuccessBlock:(void (^)(NSDictionary *))successBlock {

  DEBUG_CURRENT_METHOD();

  if(successBlock == nil)
    _successBlock = [^(NSDictionary *dictionary){ // default success block
      DEBUG_INFO(@"[TwitterUserAccount] successBlock is empty.");
    } copy];
  else
    _successBlock = [successBlock copy];
}

- (void)obtainInfo {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USERS_SHOW_URL HTTPMethod:@"GET"
               paramsDictionary:@{@"user_id"          : _twitterUserID,
                                  @"include_entities" : @"false"}];
}

- (void)obtainSettings {

  DEBUG_CURRENT_METHOD();

  [self sendTwitterRequestURL:kTWITTER_USER_SETTINGS_URL
                   HTTPMethod:@"GET"
             paramsDictionary:@{}];
}

- (void)verifyCredentials {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_VERIFY_CREDENTIALS_URL
                     HTTPMethod:@"GET"
               paramsDictionary:@{@"include_entities" : @"false",
                                  @"skip_statuses"    : @"true"}];
}

- (void)verifyCredentialsWithCustomOptions:(NSDictionary *)options {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_VERIFY_CREDENTIALS_URL
                     HTTPMethod:@"GET"
               paramsDictionary:options];
}

- (void)updateProfileWithCustomOptions:(NSDictionary *)options {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_UPDATE_ACCOUNT_URL
                     HTTPMethod:@"POST"
               paramsDictionary:options];
}

- (void)obtainDirectMessages {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_DIRECT_MESSAGES_URL HTTPMethod:@"GET"
               paramsDictionary:@{@"include_entities" : @"false",
                                  @"skip_statuses"    : @"true"}];
}

- (void)obtainDirectMessagesCount:(NSUInteger)count {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_DIRECT_MESSAGES_URL HTTPMethod:@"GET"
               paramsDictionary:@{@"include_entities" : @"false",
                                  @"skip_statuses"    : @"true",
                                  @"count"            : @(count)}];
}

- (void)obtainDirectMessagesSinceId:(NSString *)sinceId {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_DIRECT_MESSAGES_URL HTTPMethod:@"GET"
               paramsDictionary:@{@"since_id"         : sinceId,
                                  @"skip_statuses"    : @"true",
                                  @"include_entities" : @"false"}];
}

- (void)obtainDirectMessagesCustomOptions:(NSDictionary *)options {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_DIRECT_MESSAGES_URL HTTPMethod:@"GET"
               paramsDictionary:options];
}

- (void)obtainSentDirectMessages {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_SENT_DIRECT_MESSAGES_URL
                     HTTPMethod:@"GET"
               paramsDictionary:@{@"include_entities" : @"false"}];
}

- (void)obtainSentDirectMessagesCount:(NSUInteger)count {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_SENT_DIRECT_MESSAGES_URL
                     HTTPMethod:@"GET"
               paramsDictionary:@{@"include_entities" : @"false",
                                  @"count"            : @(count)}];
}

- (void)obtainSentDirectMessagesSinceId:(NSString *)sinceId {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_SENT_DIRECT_MESSAGES_URL
                     HTTPMethod:@"GET"
               paramsDictionary:@{@"include_entities" : @"false",
                                  @"since_id"         : sinceId}];
}

- (void)obtainSentDirectMessagesPage:(NSUInteger)page {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_SENT_DIRECT_MESSAGES_URL
                     HTTPMethod:@"GET"
               paramsDictionary:@{@"include_entities" : @"false",
                                  @"page"             : @(page)}];
}

- (void)obtainSentDirectMessagesCustomOptions:(NSDictionary *)options {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_SENT_DIRECT_MESSAGES_URL
                     HTTPMethod:@"GET"
               paramsDictionary:options];
}

- (void)obtainDirectMessageId:(NSString *)directMessageId {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_DIRECT_MESSAGES_SHOW_URL
                     HTTPMethod:@"GET"
               paramsDictionary:@{@"id" : directMessageId}];
}

- (void)destroyDirectMessageId:(NSString *)directMessageId {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_DIRECT_MESSAGES_DESTROY_URL
                     HTTPMethod:@"POST"
               paramsDictionary:@{@"id"               : directMessageId,
                                  @"include_entities" : @"false"}];
}

- (void)destroyDirectMessageCustomOptions:(NSDictionary *)options {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_DIRECT_MESSAGES_DESTROY_URL
                     HTTPMethod:@"POST"
               paramsDictionary:options];
}

- (void)tweet:(NSString *)text {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_STATUS_UPDATE_URL HTTPMethod:@"POST"
               paramsDictionary:@{@"status" : text}];
}

- (void)tweetWithCustomOptions:(NSDictionary *)options {
  
  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_STATUS_UPDATE_URL HTTPMethod:@"POST"
               paramsDictionary:options];
}

- (void)destroyTweetId:(NSString *)tweetId {

  DEBUG_CURRENT_METHOD();

  NSString *tweetURL = [kTWITTER_DESTROY_STATUS_URL
          stringByReplacingOccurrencesOfString:@":id"
                  withString:tweetId];

  [self sendTwitterRequestURL:tweetURL
                   HTTPMethod:@"POST"
             paramsDictionary:@{@"trim_user":@"true"}];
}

- (void)sendDirectMessage:(NSString *)msg userId:(NSString *)userId {

  DEBUG_CURRENT_METHOD();

  if(userId == nil) {
    NSError *error = [NSError
            errorWithDomain:kTwitterUserAccountDomain
                       code:TwitterUserAccountNilTwitterUserId
                   userInfo:@{NSLocalizedDescriptionKey : @"User id can not be nil."}];

    _errorBlock(error);
    return;
  }

    [self sendTwitterRequestURL:kTWITTER_DIRECT_MESSAGES_NEW_URL
                     HTTPMethod:@"POST"
               paramsDictionary:@{@"user_id" : userId,
                                  @"text"    : msg}];
}

- (void)sendDirectMessage:(NSString *)msg userScreenName:(NSString *)screenName {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_DIRECT_MESSAGES_NEW_URL
                     HTTPMethod:@"POST"
               paramsDictionary:@{@"screen_name" : screenName,
                                  @"text"        : msg}];
}

- (void)obtainFriendsWithCursor:(NSString *)cursor {

  DEBUG_CURRENT_METHOD();

  if (cursor == nil || [cursor isEqualToString:@""])
    cursor = @"-1";

    [self sendTwitterRequestURL:kTWITTER_FRIENDS_LIST_URL HTTPMethod:@"GET"
               paramsDictionary:@{@"user_id"               : _twitterUserID,
                                  @"cursor"                : cursor,
                                  @"skip_status"           : @"true",
                                  @"include_user_entities" : @"false"}];
}

- (void)obtainFriendsWithCustomOptions:(NSDictionary *)options {
  
  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_FRIENDS_LIST_URL HTTPMethod:@"GET"
               paramsDictionary:options];
}

- (void)showInfoForUserId:(NSString *)userId {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USERS_SHOW_URL HTTPMethod:@"GET"
               paramsDictionary:@{@"user_id"          : userId,
                                  @"include_entities" : @"false"}];
}

- (void)showInfoForUserScreenName:(NSString *)screenName {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USERS_SHOW_URL HTTPMethod:@"GET"
               paramsDictionary:@{@"screen_name"      : screenName,
                                  @"include_entities" : @"false"}];
}

- (void)showInfoForUserWithCustomOptions:(NSDictionary *)options {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USERS_SHOW_URL HTTPMethod:@"GET"
               paramsDictionary:options];
}

- (void)obtainUsersInBlock {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_BLOCKED_USERS_URL
                     HTTPMethod:@"GET"
               paramsDictionary:@{@"stringify_ids" : @"true",
                                  @"cursor"        : @"-1"}];
}

- (void)obtainUsersInBlockCursor:(NSString *)cursor {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_BLOCKED_USERS_URL
                     HTTPMethod:@"GET"
               paramsDictionary:@{@"stringify_ids" : @"true",
                                  @"cursor"        : cursor}];
}

- (void)blockUserId:(NSString *)userId {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_CREATE_BLOCK_URL
                     HTTPMethod:@"POST"
               paramsDictionary:@{@"user_id"          : userId,
                                  @"skip_statuses"    : @"true",
                                  @"include_entities" : @"false"}];
}

- (void)blockUserScreenName:(NSString *)screenName {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_BLOCKED_USERS_URL
                     HTTPMethod:@"POST"
               paramsDictionary:@{@"screen_name"      : screenName,
                                  @"skip_statuses"    : @"true",
                                  @"include_entities" : @"false"}];
}

- (void)blockUserWithCustomOptions:(NSDictionary *)options {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_CREATE_BLOCK_URL
                     HTTPMethod:@"POST"
               paramsDictionary:options];
}

- (void)unblockUserId:(NSString *)userId {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_UNBLOCK_BLOCK_URL
                     HTTPMethod:@"POST"
               paramsDictionary:@{@"user_id"          : userId,
                                  @"include_entities" : @"false",
                                  @"skip_statuses"    : @"true"}];
}

- (void)unblockUserScreenName:(NSString *)screenName {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_UNBLOCK_BLOCK_URL
                     HTTPMethod:@"POST"
               paramsDictionary:@{@"screen_name"      : screenName,
                                  @"include_entities" : @"false",
                                  @"skip_statuses"    : @"true"}];
}

- (void)unblockUserWithCustomOptions:(NSDictionary *)options {

  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_USER_UNBLOCK_BLOCK_URL
                     HTTPMethod:@"POST"
               paramsDictionary:options];
}

- (void)obtainFollowersWithCursor:(NSString *)cursor {

  DEBUG_CURRENT_METHOD();

  if (cursor == nil || [cursor isEqualToString:@""])
    cursor = @"-1";

    [self sendTwitterRequestURL:kTWITTER_FOLLOWERS_LIST_URL HTTPMethod:@"GET"
               paramsDictionary:@{@"user_id"               : _twitterUserID,
                                  @"cursor"                : cursor,
                                  @"skip_status"           : @"true",
                                  @"include_user_entities" : @"false"}];
}

- (void)obtainFollowersWithCursorWithCustomOptions:(NSDictionary *)options {
  
  DEBUG_CURRENT_METHOD();

    [self sendTwitterRequestURL:kTWITTER_FOLLOWERS_LIST_URL HTTPMethod:@"GET"
               paramsDictionary:options];
}

- (NSString *)description {

  return [NSString stringWithFormat:@"Screen name:%@ Id:%@",
                                    _screenName, _twitterUserID];
}

#pragma mark - PRIVATE METHOD
- (BOOL)sendTwitterRequestURL:(NSString *)requestURL
                   HTTPMethod:(NSString *)httpMethod
             paramsDictionary:(NSDictionary *)params {

  DEBUG_CURRENT_METHOD();

  NSString *urlRequestString = requestURL;
  NSURL *url = [NSURL URLWithString:urlRequestString];

  NSMutableString *paramsAsString = [[NSMutableString alloc] init];
  [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [paramsAsString appendFormat:@"%@=%@&", key, [obj encodeURL]];
  }];

  if (![paramsAsString isEqualToString:@""])
    paramsAsString = (NSMutableString *) [paramsAsString substringToIndex:[paramsAsString length] - 1];

  NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
  [urlRequest setHTTPMethod:httpMethod];

  if (![httpMethod isEqualToString:@"GET"]) {
    [urlRequest setHTTPBody:[[NSString stringWithFormat:@"%@", paramsAsString]
            dataUsingEncoding:NSUTF8StringEncoding]];
  } else {
    requestURL = [NSString stringWithFormat:@"%@?%@", requestURL, paramsAsString];
    url = [NSURL URLWithString:requestURL];
    [urlRequest setURL:url];
  }

  [urlRequest addValue:@"application/x-www-form-urlencoded"
    forHTTPHeaderField:@"Content-Type"];

  // generating request body
  NSString *oauth_nonce = [DPTwitterCommunicator generateNonceToken:32];
  NSString *oauth_timestamp = [NSString stringWithFormat:@"%@",
                              [NSNumber numberWithUnsignedInt:[[NSDate date] timeIntervalSince1970]]];
  NSString *oauth_consumer_key = kTWITTER_CONSUMER_KEY;
  NSString *oauth_signature_method = @"HMAC-SHA1";
  NSString *oauth_version = @"1.0";
  NSString *oauth_token = _oauthToken;

  // calculating signature
  NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
  [dic setObject:oauth_consumer_key forKey:@"oauth_consumer_key"];
  [dic setObject:oauth_nonce forKey:@"oauth_nonce"];
  [dic setObject:oauth_signature_method forKey:@"oauth_signature_method"];
  [dic setObject:oauth_timestamp forKey:@"oauth_timestamp"];
  [dic setObject:oauth_version forKey:@"oauth_version"];
  [dic setObject:oauth_token forKey:@"oauth_token"];
  [dic addEntriesFromDictionary:params];

  NSString *signature_base_string = [DPTwitterCommunicator
          generateSignatureBaseString:dic
                withHTTPRequestMethod:httpMethod
                        andRequestURL:urlRequestString];

  NSString *signing_key = [NSString stringWithFormat:@"%@&%@",
                                                     kTWITTER_CONSUMER_SECRET,
                                                     _oauthTokenSecret];
  NSString *oauth_signature = [[signature_base_string HMACSHA1:signing_key] toBase64];

  NSString *authorization_header = [NSString stringWithFormat:@"OAuth oauth_consumer_key=\"%@\", oauth_nonce=\"%@\", oauth_signature=\"%@\", oauth_signature_method=\"%@\", oauth_timestamp=\"%@\", oauth_token=\"%@\", oauth_version=\"%@\"",
                                                              oauth_consumer_key, oauth_nonce, [oauth_signature encodeURL], oauth_signature_method, oauth_timestamp, oauth_token, oauth_version];

  [urlRequest setValue:authorization_header forHTTPHeaderField:@"Authorization"];

  NSError *error = nil;
  NSURLResponse *res = nil;
  NSData *response = [NSURLConnection sendSynchronousRequest:urlRequest
                                           returningResponse:&res
                                                       error:&error];
  
  if(response == nil) // скорее всего у нас нет интернет соединения
    response = [NSData data];

  NSInteger statusCode = [(NSHTTPURLResponse *) res statusCode];

  NSError *jsonParserError = nil;
  id jsonResponse = [NSJSONSerialization JSONObjectWithData:response
                                                    options:NSJSONReadingMutableContainers
                                                      error:&jsonParserError];
  
  if(jsonParserError != nil) {
    _errorBlock(jsonParserError);
    return NO;
  }

  if (error != nil || statusCode != 200 || response == nil || [jsonResponse objectForKey:@"errors"] != nil) {
     error = [NSError errorWithDomain:kTwitterUserAccountDomain
                                 code:TwitterUserAccountRequestError
                             userInfo:@{NSLocalizedDescriptionKey:jsonResponse,
                                      @"HTTP Status Code":@(statusCode)}];
    _errorBlock(error);
    return NO;
  }

  _successBlock(jsonResponse);

  return YES;
}

@end
