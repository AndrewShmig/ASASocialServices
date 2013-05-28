//
//  ASATwitterUserAccount.m
//
//  Created by AndrewShmig on 11.12.12.
//  Copyright (c) 2012 AndrewShmig. All rights reserved.
//

#import "ASATwitterUserAccount.h"
#import "NSString+encodeURL.h"
#import "ASATwitterCommunicator.h"
#import "NSString+HMACSHA1.h"
#import "NSData+toBase64.h"
#import "ASATwitterCommunicator+Utilities.h"


#define call_completion_block(block,value) if(block!=nil) block(value);


@implementation ASATwitterUserAccount
{
    void (^_successBlock) (id);
    void (^_failureBlock) (NSError *);
}


#pragma mark - Init

- (instancetype)initWithToken:(NSString *)token
                  tokenSecret:(NSString *)tokenSecret
                twitterUserID:(NSString *)userId
               userScreenName:(NSString *)screenName
{
    self = [super init];

    if (self) {
        _oauthToken = [token copy];
        _oauthTokenSecret = [tokenSecret copy];
        _twitterUserID = [userId copy];
        _screenName = [screenName copy];
    }

    return self;
}

#pragma mark - Public methods

- (void)performTwitterMethod:(NSString *)methodName
                  HTTPMethod:(NSString *)httpMethod
                     options:(NSDictionary *)options
                     success:(void (^)(id))success
                     failure:(void (^)(NSError *))failure
{
    __block NSMutableString *finalMethodName = [NSMutableString stringWithString:methodName];
    __block NSMutableDictionary *finalOptions = [NSMutableDictionary dictionary];
    NSString *finalHTTPMethod = [httpMethod uppercaseString];
    _successBlock = success;
    _failureBlock = failure;

    [options enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        NSString *keyObject = (NSString *)key;
        NSString *valueObject = (NSString *)obj;

        if([keyObject hasPrefix:@":"]){ // if placeholder - do not add it to options
            
            [finalMethodName replaceOccurrencesOfString:keyObject
                                             withString:valueObject
                                                options:NSCaseInsensitiveSearch
                                                  range:NSMakeRange(0, finalMethodName.length)];
        } else {
            finalOptions[keyObject] = valueObject;
        }
    }];

    [self sendTwitterRequestURL:finalMethodName
                     HTTPMethod:finalHTTPMethod
               paramsDictionary:finalOptions];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"[%@][%@]",
                                      self.screenName,
                                      self.twitterUserID];
}

#pragma mark - Private methods

- (BOOL)sendTwitterRequestURL:(NSString *)requestURL
                   HTTPMethod:(NSString *)httpMethod
             paramsDictionary:(NSDictionary *)params
{

    NSString *urlRequestString = [NSString stringWithFormat:@"%@.json", requestURL];
    NSURL *url = [NSURL URLWithString:urlRequestString];

    NSMutableString *paramsAsString = [[NSMutableString alloc] init];
    [params enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
    {
        [paramsAsString appendFormat:@"%@=%@&", key, [obj encodeURL]];
    }];

    if (![paramsAsString isEqualToString:@""])
        paramsAsString = (NSMutableString *) [paramsAsString substringToIndex:[paramsAsString length] - 1];

    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:httpMethod];

    if (![httpMethod isEqualToString:@"GET"]) {
        [urlRequest setHTTPBody:[[NSString stringWithFormat:@"%@",
                                                            paramsAsString]
                                                            dataUsingEncoding:NSUTF8StringEncoding]];
    } else {
        if(![paramsAsString isEqualToString:@""]){
            requestURL = [NSString stringWithFormat:@"%@?%@",
                                                    urlRequestString,
                                                    paramsAsString];
        } else {
            requestURL = urlRequestString;
        }

        url = [NSURL URLWithString:requestURL];
        [urlRequest setURL:url];
    }

    [urlRequest addValue:@"application/x-www-form-urlencoded"
      forHTTPHeaderField:@"Content-Type"];

    // generating request body
    NSString *oauth_nonce = [ASATwitterCommunicator generateNonceToken:32];

    NSUInteger timeSince1970 = (NSUInteger)[[NSDate date] timeIntervalSince1970];
    NSNumber *timeAsNumber = [NSNumber numberWithUnsignedInt:timeSince1970];
    NSString *oauth_timestamp = [NSString stringWithFormat:@"%@", timeAsNumber];

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

    NSString *signature_base_string = [ASATwitterCommunicator
            generateSignatureBaseString:dic
                  withHTTPRequestMethod:httpMethod
                          andRequestURL:urlRequestString];

    NSString *signing_key = [NSString stringWithFormat:@"%@&%@",
                                                       kTWITTER_CONSUMER_SECRET,
                                                       _oauthTokenSecret];
    NSString *oauth_signature = [[signature_base_string HMACSHA1:signing_key]
                                                        toBase64];

    NSString *authorization_header = [NSString stringWithFormat:@"OAuth oauth_consumer_key=\"%@\", oauth_nonce=\"%@\", oauth_signature=\"%@\", oauth_signature_method=\"%@\", oauth_timestamp=\"%@\", oauth_token=\"%@\", oauth_version=\"%@\"",
                                                                oauth_consumer_key,
                                                                oauth_nonce,
                                                                [oauth_signature encodeURL],
                                                                oauth_signature_method,
                                                                oauth_timestamp,
                                                                oauth_token,
                                                                oauth_version];

    [urlRequest setValue:authorization_header
      forHTTPHeaderField:@"Authorization"];

    NSError *error = nil;
    NSURLResponse *res = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:urlRequest
                                             returningResponse:&res
                                                         error:&error];

    if (response == nil) // скорее всего у нас нет интернет соединения
        response = [NSData data];

    NSInteger statusCode = [(NSHTTPURLResponse *) res statusCode];

    NSError *jsonParserError = nil;
    id jsonResponse = [NSJSONSerialization JSONObjectWithData:response
                                                      options:NSJSONReadingMutableContainers
                                                        error:&jsonParserError];

    if (jsonParserError != nil) {
        call_completion_block(_failureBlock, jsonParserError);
        return NO;
    }

    if (error != nil || statusCode != 200 || response == nil || [jsonResponse objectForKey:@"errors"] != nil) {
        error = [NSError errorWithDomain:@"ASATwitterUserAccountErrorDomain"
                                    code:-1
                                userInfo:@{@"HTTP Status Code" : @(statusCode),
                                           @"Errors"           : jsonResponse[@"errors"]}];
        call_completion_block(_failureBlock, error);
        return NO;
    }

    call_completion_block(_successBlock, jsonResponse);

    return YES;
}

@end
