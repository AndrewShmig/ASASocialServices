//
//  ViewController.h
//  DPSocialServices
//
//  Created by AndrewShmig on 04/09/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DPTwitterCommunicator.h"
#import "DPVkontakteCommunicator.h"
#import "DPFacebookCommunicator.h"

#import "DPTwitterUserAccount.h"
#import "DPVkontakteUserAccount.h"
#import "DPFacebookUserAccount.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) DPTwitterCommunicator *twitter;

@end