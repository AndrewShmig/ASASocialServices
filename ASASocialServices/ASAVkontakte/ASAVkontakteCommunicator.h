//
//  ASAVkontakteCommunicator.h
//
//  Created by Andrew Shmig on 18.12.12.
//

#import <Foundation/Foundation.h>

@class ASAVkontakteUserAccount;

static NSString *const kVkontakteAppId = @"3541027";
static NSString *const kVkontaktePrivateKey = @"EImkkJQ8jF7obXFVSHIZ";
static NSString *const kVkontaktePermissionList = @"friends,status,wall,messages,offline,photos,docs,audio";

@interface ASAVkontakteCommunicator : NSObject <UIWebViewDelegate>

- (id)initWithWebView:(UIWebView *)webView;

- (void)startOnCancelBlock:(void (^)(void))cancelBlock
            onSuccessBlock:(void (^)(ASAVkontakteUserAccount *))acceptedBlock;

@end
