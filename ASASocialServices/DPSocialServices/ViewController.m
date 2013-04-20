//
//  ViewController.m
//
//  Created by AndrewShmig on 04/09/13.

#import "ViewController.h"
#import "DDLog.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation ViewController

@synthesize webView = _webView;
@synthesize vk = _vk;

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect frame = [[UIScreen mainScreen] bounds];
    _webView = [[UIWebView alloc] initWithFrame:frame];
    [_webView setHidden:NO];
    [self.view addSubview:_webView];

    _vk = [[ASAVkontakteCommunicator alloc] initWithWebView:_webView];

    ASAVkontakteUserAccount *me = [[ASAVkontakteUserAccount alloc]
                                                            initUserAccountWithLogin:@"andrewshmig@gmail.com"
                                                                            password:@"f34gq58j19922901"
                                                                         permissions:@[
                                                                                 @"status",
                                                                                 @"offline",
                                                                                 @"docs",
                                                                                 @"audio"]
                                                                             success:^(NSDictionary *dic){
                                                                                 DDLogVerbose(@"===>%@", dic);
                                                                             }
                                                                             failure:^(NSError *error){
                                                                                 DDLogVerbose(@"ERROR:%@", error);
                                                                             }];

//    [_vk startOnCancelBlock:^{
//        DDLogVerbose(@"[Cancel]");
//    } onErrorBlock:^(NSError *error) {
//        DDLogVerbose(@"[Error]: %@", error);
//    } onSuccessBlock:^(ASAVkontakteUserAccount *account) {
//        DDLogVerbose(@"%@", account);
//
//        [account performVKMethod:kVKVideoGetAlbums
//                         options:@{@"uid" : @""}
//                         success:^(NSDictionary *dictionary)
//                         {
//                             DDLogVerbose(@"audio: %@", dictionary);
//                         }
//                         failure:^(NSError *error){
//                             DDLogVerbose(@"====>%@", error);
//                         }];
//    }];
}

@end
