//
//  ASAVkontakteCommunicator.h
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>

@class ASAVkontakteUserAccount;

static const NSString *kVKONTAKTE_APP_ID = @"3541027";
static const NSString *kVKONTAKTE_PRIVATE_KEY = @"EImkkJQ8jF7obXFVSHIZ";
static const NSString *kVKONTAKTE_PERMISSIONS_LIST = @"friends,status,wall,messages,offline,photos,docs,audio";

@interface ASAVkontakteCommunicator : NSObject <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webView;

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
            onSuccessBlock:(void (^)(ASAVkontakteUserAccount *))acceptedBlock;

@end
