//
//  ASAVkontakteCommunicator.h
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>

@class ASAVkontakteUserAccount;

static const NSString *kVkontakteAppId = @"3541027";
static const NSString *kVkontaktePrivateKey = @"EImkkJQ8jF7obXFVSHIZ";
static const NSString *kVkontaktePermissionList = @"friends,status,wall,messages,offline,photos,docs,audio";

@interface ASAVkontakteCommunicator : NSObject <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webView;

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
            onSuccessBlock:(void (^)(ASAVkontakteUserAccount *))acceptedBlock;

@end
