

#import "RootCtrl.h"

@interface MyWebController : RootCtrl

@property (nonatomic, copy)     NSString    *urlStr ;
@property (strong, nonatomic)   UIWebView   *webView ;

- (void)startLoadingWebview ;

@end
