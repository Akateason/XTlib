//
//  CtrlHelpVC.m
//  XTlib
//
//  Created by teason23 on 2018/3/14.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "CtrlHelpVC.h"
#import "NibVC.h"

@interface CtrlHelpVC ()

@end

@implementation CtrlHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor redColor] ;
    
    NSLog(@"my nav vc %@",self.view.xt_navigationController) ;
    
    NibVC *aVC = [NibVC getCtrllerFromNIB] ;
    [self presentViewController:aVC animated:YES completion:nil] ;
    
    
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom] ;
    bt.backgroundColor = [UIColor whiteColor] ;
    [self.view addSubview:bt] ;
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 40)) ;
        make.left.bottom.equalTo(self.view) ;
    }] ;
    [[bt rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(__kindof UIControl * _Nullable x) {
         [self.navigationController pushViewController:aVC animated:YES] ;
     }] ;
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
