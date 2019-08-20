//
//  Zample7Controller.m
//  XTkit
//
//  Created by teason23 on 2017/5/12.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample7Controller.h"
#import <XTBase/XTBase.h>


@interface Zample7Controller ()

@end


@implementation Zample7Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //    UIScrollView *scroll = (UIScrollView *)[self.view xt_wrapperWithScrollView] ;
    //    self.view = scroll ;


    UIView *addView      = [[[NSBundle mainBundle] loadNibNamed:@"Z7LongView" owner:self options:nil] lastObject];
    UIScrollView *scroll = (UIScrollView *)[addView xt_wrapperWithScrollView];
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
