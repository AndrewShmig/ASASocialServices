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


@implementation ASATwitterUserAccount

#pragma mark - Init

#pragma mark - Public methods

#pragma mark - Private methods

- (BOOL)sendTwitterRequestURL:(NSString *)requestURL
                   HTTPMethod:(NSString *)httpMethod
             paramsDictionary:(NSDictionary *)params {

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
  NSString *oauth_nonce = [ASATwitterCommunicator generateNonceToken:32];
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

  NSString *signature_base_string = [ASATwitterCommunicator
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
     error = [NSError errorWithDomain:@"ASATwitterUserAccountErrorDomain"
                                 code:-1
                             userInfo:@{NSLocalizedDescriptionKey:jsonResponse,
                                      @"HTTP Status Code":@(statusCode)}];
    _errorBlock(error);
    return NO;
  }

  _successBlock(jsonResponse);

  return YES;
}

@end
