//
//  DPFacebookCommunicator.h
//
//  Created by AndrewShmig on 14.12.12.
//  Copyright (c) 2012 digipeople. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString *kFACEBOOK_APP_ID = @"179674345510190";
static const NSString *kFACEBOOK_APP_SECRET = @"3688f94c073e79b10f82152b2cc0849e";
static const NSString *kFACEBOOK_PERMISSIONS = @"";

@class DPFacebookUserAccount;

@interface DPFacebookCommunicator : NSObject <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webView;

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
              onErrorBlock:(void (^)(NSError *))errorBlock
            onSuccessBlock:(void (^)(DPVkontakteUserAccount *))acceptedBlock;

@end
