//
//  ViewController.h
//  DPSocialServices
//
//  Created by AndrewShmig on 04/09/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ASAVkontakteCommunicator.h"
#import "ASAVkontakteUserAccount.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) ASAVkontakteCommunicator *vk;

@end