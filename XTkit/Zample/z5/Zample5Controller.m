//
//  Zample5Controller.m
//  XTkit
//
//  Created by teason23 on 2017/4/28.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample5Controller.h"
#import "UIColor+AllColors.h"
#import "XTColorFetcher.h"
#import <objc/runtime.h>
#import "NSObject+JKReflection.h"

@interface Zample5Controller ()

@end

@implementation Zample5Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"color" ;

    self.view.backgroundColor = [UIColor xt_mainColor] ;
    

    UIView *view2 = [UIView new] ;
    [self.view addSubview:view2] ;
    view2.backgroundColor = XTCOLOR(@"w_red") ;
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view) ;
        make.height.mas_equalTo(100) ;
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
