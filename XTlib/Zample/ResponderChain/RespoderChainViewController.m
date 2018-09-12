//
//  RespoderChainViewController.m
//  XTkit
//
//  Created by teason23 on 2017/11/25.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "RespoderChainViewController.h"
#import "UIResponder+ChainHandler.h"
#import "RCSubView.h"
#import "XTColorFetcher.h"
#import "XTlib.h"

@interface RespoderChainViewController ()
@property (strong,nonatomic) RCSubView *rcSubView ;
@end

@implementation RespoderChainViewController

- (BOOL)receiveHandleChain:(NSString *)identifier
                      info:(id)info
                    sender:(id)sender
{
    if ([identifier isEqualToString:@"a"]) {
        self.title = info ;
        ((RCSubView *)sender).backgroundColor = [[XTColorFetcher sharedInstance] randomColor] ;
    }
    return NO ;
}

- (void)viewDidLoad {
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    int flex = 10 ;
    for (int i = 1; i <= 20; i++) {
        UIView *aView = [UIView new] ;
        aView.backgroundColor = [[XTColorFetcher sharedInstance] randomColor] ;
        [[self onWhichView] addSubview:aView] ;
        [aView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(APP_WIDTH - flex * i, APP_HEIGHT - flex * i)) ;
            make.center.equalTo(self.view) ;
        }] ;
        
        if (i == 20) {
            self.rcSubView = ({
                RCSubView *view = [[RCSubView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)] ;
                [aView addSubview:view] ;
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.center.equalTo(aView) ;
                    make.size.mas_equalTo(CGSizeMake(100, 100)) ;
                }] ;
                view ;
            }) ;
        }
    }
}

- (UIView *)onWhichView {
    return ![self.view subviews].count ? self.view : [[self.view subviews] lastObject] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
