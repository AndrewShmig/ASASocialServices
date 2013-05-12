//
// Created by AndrewShmig on 5/7/13.
//
// Copyright (c) AndrewShmig. All rights reserved.
//
#import "ASATwitterCommunicator+Utilities.h"
#import "NSString+encodeURL.h"

@implementation ASATwitterCommunicator (Utilities)

+ (NSString *)generateNonceToken:(NSInteger)length
{
    NSLog(@"%s", __FUNCTION__);

    NSMutableString *result = [[NSMutableString alloc] init];
    NSString *all_chars = @"QWERTYUIOPASDFGHJKLZXCVBNMqwertyuiopasdfghjklzxcvbnm1234567890";

    srand(time(NULL));

    for (NSUInteger i = 0; i < length; i++) {
        NSUInteger index = (NSUInteger)(rand() % ([all_chars length] - 1));

        unichar newChar = [all_chars characterAtIndex:index];
        [result appendString:[NSString stringWithFormat:@"%c", newChar]];
    }

    return result;
}

/*
 Creating the signature base string

 The three values collected so far must be joined to make a single string, from which the signature will be generated. This is called the signature base string by the OAuth specification.

 To encode the HTTP method, base URL, and parameter string into a single string:

 * Convert the HTTP Method to uppercase and set the output string equal to this value.
 * Append the '&' character to the output string.
 * Percent encode the URL and append it to the output string.
 * Append the '&' character to the output string.
 * Percent encode the parameter string and append it to the output string.
 */

+ (NSString *)generateSignatureBaseString:(NSDictionary *)keyValuePairs
                    withHTTPRequestMethod:(NSString *)requestMethod
                            andRequestURL:(NSString *)requestURL
{
    NSLog(@"%s", __FUNCTION__);

    requestMethod = [requestMethod uppercaseString];

    // percent encoding each key-value
    NSMutableDictionary *new_dictionary = [[NSMutableDictionary alloc] init];
    [keyValuePairs enumerateKeysAndObjectsUsingBlock:^(id key,
                                                       id obj,
                                                       BOOL *stop)
    {
        NSString *new_key = [key encodeURL];
        NSString *new_value = [obj encodeURL];

        [new_dictionary setObject:new_value forKey:new_key];
    }];

    // sorting values
    NSMutableArray *sorted_array = [[NSMutableArray alloc] init];
    [new_dictionary enumerateKeysAndObjectsUsingBlock:^(id key,
                                                        id obj,
                                                        BOOL *stop)
    {
        [sorted_array addObject:key];
    }];

    sorted_array = [NSMutableArray arrayWithArray:[sorted_array sortedArrayUsingComparator:^NSComparisonResult (
            id obj1,
            id obj2)
    {
        NSString *str1 = (NSString *) obj1;
        NSString *str2 = (NSString *) obj2;

        return [str1 compare:str2];
    }]];

    // concatenating key-values
    NSMutableString *parameter_string = [[NSMutableString alloc] init];
    [sorted_array enumerateObjectsUsingBlock:^(id obj,
                                               NSUInteger idx,
                                               BOOL *stop)
    {
        [parameter_string appendString:[NSString stringWithFormat:@"%@=%@&",
                                                                  obj,
                                                                  [new_dictionary objectForKey:obj]]];
    }];

    // removing last char
    NSRange range;
    range.location = [parameter_string length] - 1;
    range.length = 1;
    [parameter_string deleteCharactersInRange:range];
    parameter_string = [NSMutableString stringWithString:[parameter_string encodeURL]];

    // generating signature base string
    NSMutableString *signature_base_string = [[NSMutableString alloc] init];
    [signature_base_string appendString:requestMethod];
    [signature_base_string appendString:@"&"];
    [signature_base_string appendString:[requestURL encodeURL]];
    [signature_base_string appendString:@"&"];
    [signature_base_string appendString:parameter_string];

    return signature_base_string;
}

@end