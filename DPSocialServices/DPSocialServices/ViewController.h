//
//  ViewController.h
//  DPSocialServices
//
//  Created by AndrewShmig on 04/09/13.
//

#import <UIKit/UIKit.h>

#import "ASAVkontakteCommunicator.h"
#import "ASAVkontakteUserAccount.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) ASAVkontakteCommunicator *vk;

@end