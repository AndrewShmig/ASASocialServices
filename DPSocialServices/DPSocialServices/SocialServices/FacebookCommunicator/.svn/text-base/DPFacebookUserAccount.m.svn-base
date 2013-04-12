//
//  DPFacebookUserAccount.m
//
//  Created by AndrewShmig on 14.12.12.
//  Copyright (c) 2012 digipeople. All rights reserved.
//

#import "DPFacebookUserAccount.h"
#import "NSString+encodeURL.h"

#define LOG_ON 1

#if LOG_ON == 1
# define DEBUG_CURRENT_METHOD() NSLog(@"%s", __FUNCTION__)
#endif

@implementation DPFacebookUserAccount
{
    NSString *_accessToken;
    NSUInteger _expirationTime;
}

@synthesize accessToken = _accessToken;
@synthesize expirationTime = _expirationTime;

#pragma mark - Init methods

- (id)initWithAccessToken:(NSString *)accessToken
           expirationTime:(NSUInteger)expirationTime
{
    DEBUG_CURRENT_METHOD();

    self = [super init];

    if (self) {

        if(accessToken == nil)
            @throw [NSException exceptionWithName:@"Access token can not be nil."
                                           reason:@"accessToken is nil."
                                         userInfo:@{}];

        _accessToken = [accessToken copy];
        _expirationTime = expirationTime;
    }

    return self;
}

- (id)initWithAccessToken:(NSString *)accessToken
{
    return [self initWithAccessToken:accessToken
                      expirationTime:0];
}


#pragma mark - Public methods

- (void)obtainInfo
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *personalInfo = [[NSString stringWithFormat:kFACEBOOK_USER_URL]
                                               mutableCopy];
    [personalInfo appendFormat:@"?access_token=%@", _accessToken];
    NSURL *url = [NSURL URLWithString:personalInfo];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)obtainInfoFields:(NSArray *)fields
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *personalInfo = [[NSString stringWithFormat:kFACEBOOK_USER_URL]
                                               mutableCopy];
    [personalInfo appendFormat:@"?access_token=%@", _accessToken];

    if ([fields count] != 0) {
        [personalInfo appendString:@"&fields="];

        for (NSString *field in fields) {
            [personalInfo appendFormat:@"%@,", field];
        }

        NSUInteger location = [personalInfo length] - 1;
        NSUInteger length = 1;
        NSRange range = NSMakeRange(location, length);
        [personalInfo deleteCharactersInRange:range]; // remove last unneeded ',' character
    }

    NSURL *url = [NSURL URLWithString:personalInfo];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)obtainPhoto
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [[NSString stringWithFormat:kFACEBOOK_USER_PHOTO_URL]
                                               mutableCopy];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];
    [urlAsString appendFormat:@"&redirect=false"];
    NSURL *url = [NSURL URLWithString:urlAsString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)publishToFeed:(NSString *)text
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_USER_FEED_URL];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];
    [urlAsString appendFormat:@"&message=%@", [text encodeURL]];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];

    _successBlock([self sendRequest:request]);
}

- (void)publishToFeedCustomOptions:(NSDictionary *)options
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_USER_FEED_URL];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];

    [options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        [urlAsString appendFormat:@"&%@=%@", key, [obj encodeURL]];
    }];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];

    _successBlock([self sendRequest:request]);
}


- (void)obtainFriends
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_USER_FRIENDS_URL];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)obtainFriendsCustomFields:(NSArray *)fields
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_USER_FRIENDS_URL];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];

    if([fields count] != 0) {
        [urlAsString appendString:@"&fields="];

        for(NSString *field in fields) {
            [urlAsString appendFormat:@"%@,", field];
        }

        NSUInteger location = [urlAsString length] - 1;
        NSUInteger length = 1;
        NSRange range = NSMakeRange(location, length);
        [urlAsString deleteCharactersInRange:range]; // remove last unneeded ',' character
    }

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)obtainDialogWithId:(NSString *)dialogId
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_GRAPH_URL];
    [urlAsString appendFormat:@"%@", dialogId];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)obtainDialogCommentsWithId:(NSString *)dialogId
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_GRAPH_URL];
    [urlAsString appendFormat:@"%@", dialogId];
    [urlAsString appendFormat:@"/comments"];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)obtainDialogCommentsWithId:(NSString *)dialogId count:(NSUInteger)count
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_GRAPH_URL];
    [urlAsString appendFormat:@"%@", dialogId];
    [urlAsString appendFormat:@"/comments"];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];
    [urlAsString appendFormat:@"&limit=%u", count];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)obtainDialogCommentsWithId:(NSString *)dialogId
                             count:(NSUInteger)count
                            offset:(NSUInteger)offset
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_GRAPH_URL];
    [urlAsString appendFormat:@"%@", dialogId];
    [urlAsString appendFormat:@"/comments"];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];
    [urlAsString appendFormat:@"&limit=%u", count];
    [urlAsString appendFormat:@"&offset=%u", offset];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}


- (void)obtainInboxDialogs
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_USER_INBOX_URL];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)obtainInboxDialogsCount:(NSUInteger)count
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_USER_INBOX_URL];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];
    [urlAsString appendFormat:@"&limit=%u", count];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}


- (void)obtainOutboxDialogs
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_USER_OUTBOX_URL];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}

- (void)obtainOutboxDialogsCount:(NSUInteger)count
{
    DEBUG_CURRENT_METHOD();

    NSMutableString *urlAsString = [NSMutableString string];
    [urlAsString appendFormat:@"%@", kFACEBOOK_USER_OUTBOX_URL];
    [urlAsString appendFormat:@"?access_token=%@", _accessToken];
    [urlAsString appendFormat:@"&limit=%u", count];

    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];

    _successBlock([self sendRequest:request]);
}


- (NSString *)description
{
    DEBUG_CURRENT_METHOD();

    return [NSString stringWithFormat:@"Access token: %@, expires in: %u",
                                      _accessToken,
                                      _expirationTime];
}

#pragma mark - Private methods

- (NSDictionary *)sendRequest:(NSMutableURLRequest *)request
{
    DEBUG_CURRENT_METHOD();

    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&response
                                                             error:&error];

    NSLog(@"===>%@", [NSString stringWithCString:[responseData bytes]
                                        encoding:NSUTF8StringEncoding]);

    if(error != nil) {
        _errorBlock(error);
        return nil;
    }

    NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
    if(statusCode != 200) {
        error = [NSError errorWithDomain:@"DPFacebookUserAccountDomain"
                                    code:-1
                                userInfo:@{@"Status code"          : [NSString stringWithFormat:@"%d",
                                                                                                statusCode],
                                           @"Server response body" : [NSString stringWithCString:[responseData bytes]
                                                                                        encoding:NSUTF8StringEncoding]}];

        _errorBlock(error);
        return nil;
    }

    error = nil;
    NSDictionary *responseAsJSON = [NSJSONSerialization JSONObjectWithData:responseData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&error];

    if(error != nil) {
        _errorBlock(error);
        return nil;
    }

    return responseAsJSON;
}

@end
