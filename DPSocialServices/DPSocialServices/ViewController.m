//
//  ViewController.m
//
//  Created by AndrewShmig on 04/09/13.
//

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

    [_vk startOnCancelBlock:^{
        DDLogVerbose(@"[Cancel]");
    } onErrorBlock:^(NSError *error) {
        DDLogVerbose(@"[Error]: %@", error);
    } onSuccessBlock:^(ASAVkontakteUserAccount *account) {
        DDLogVerbose(@"%@", account);

        [account docsGetUploadServerWithCustomOptions:@{}
                                              success:^(NSDictionary *dictionary)
                                              {
                                                  NSString *uploadURL = dictionary[@"response"][@"upload_url"];
                                                  NSString *documentPath = [[NSBundle mainBundle]
                                                          pathForResource:@"document"
                                                                   ofType:@"pdf"];

                                                  [account uploadDocument:documentPath
                                                                    toURL:[NSURL URLWithString:uploadURL]
                                                              withOptions:@{}
                                                                  success:^(
                                                                          NSDictionary *dictionary)
                                                                  {
                                                                      DDLogVerbose(@"dictionary: %@", dictionary);

                                                                      [account docsSaveWithCustomOptions:@{@"file":dictionary[@"file"]}
                                                                                                 success:^(
                                                                                                         NSDictionary *dictionary)
                                                                                                 {
                                                                                                     DDLogVerbose(@"dictionary: %@", dictionary);
                                                                                                 }
                                                                                                 failure:nil];
                                                                  }
                                                                  failure:nil];
                                              }
                                              failure:nil];
    }];
}

@end
