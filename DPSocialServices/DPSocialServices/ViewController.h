//
//  ViewController.h
//  DPSocialServices
//
//  Created by AndrewShmig on 04/09/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPVkontakteCommunicator.h"
#import "DPVkontakteUserAccount.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) DPVkontakteCommunicator *vk;

@end