//
//  Zample4Controller.m
//  XTkit
//
//  Created by teason23 on 2017/4/28.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample4Controller.h"

#import "XTColor.h"
//#import "NSObject+Runtime.h"

@interface Zample4Controller ()

@end

@implementation Zample4Controller



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"color" ;
    
    self.view.backgroundColor = UIColorWithKey(@"xt_mainColor") ;
    
    UIView *view2 = [UIView new] ;
    [self.view addSubview:view2] ;
    view2.backgroundColor = UIColorWithKey(@"w_gray") ;
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view) ;
        make.height.mas_equalTo(100) ;
    }] ;
    
    [self test] ;
}

- (void)test
{
    UIView *view = [UIView new] ;
    view.backgroundColor = UIColorWithKey(@"tabbar_red") ;
    view.frame = CGRectMake(100, 200, 79, 79) ;
    [self.view addSubview:view] ;
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
