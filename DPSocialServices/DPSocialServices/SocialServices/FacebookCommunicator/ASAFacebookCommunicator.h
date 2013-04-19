//
//  ASAFacebookCommunicator.h
//
//  Created by AndrewShmig on 14.12.12.
//  Copyright (c) 2012 digipeople. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString *kFACEBOOK_APP_ID = @"179674345510190";
static const NSString *kFACEBOOK_APP_SECRET = @"a931a310e63713512ad51f15b9ca36bc";
static const NSString *kFACEBOOK_PERMISSIONS = @"publish_stream,email,read_mailbox,user_online_presence,friends_online_presence,offline_access";

@class ASAFacebookUserAccount;

@interface ASAFacebookCommunicator : NSObject <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webView;

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(ASAFacebookUserAccount *))acceptedBlock;

@end
