//
//  ASATwitterCommunicator.h
//
//  Created by AndrewShmig on 06.12.12.
//  Copyright (c) 2012 AndrewShmig. All rights reserved.
//
//

#import <Foundation/Foundation.h>

/*
* Consumer key, consumer secret
* */

extern NSString *const kTWITTER_CONSUMER_KEY;
extern NSString *const kTWITTER_CONSUMER_SECRET;


@class ASATwitterUserAccount;


@interface ASATwitterCommunicator : NSObject <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webView;

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(ASATwitterUserAccount *))acceptedBlock;

@end
