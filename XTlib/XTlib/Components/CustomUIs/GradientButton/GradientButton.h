//
//  GradientButton.h
//  SwiftCall
//可以删除了. 用RootCustomView替代.
//  Created by teason23 on 2018/3/27.
//  Copyright © 2018年 weyl. All rights reserved.
// ---------------------------------------------------------------- //
//  e.g.
//    GradientButton *bt222 = [GradientButton buttonWithType:UIButtonTypeCustom] ;
//    [self.view addSubview:bt222] ;
//    [bt222 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@100) ;
//        make.height.equalTo(@40) ;
//        make.center.equalTo(self.view) ;
//    }] ;
//    [bt222 setNeedsLayout] ;
//    [bt222 layoutIfNeeded] ;
//    [bt222 addColors:@[(__bridge id)[UIColor redColor].CGColor,(__bridge id)[UIColor yellowColor].CGColor]] ;
//
// ---------------------------------------------------------------- //

#import <UIKit/UIKit.h>


@interface GradientButton : UIButton

- (void)addColors:(NSArray *)colors;

- (void)addColors:(NSArray *)colors bounds:(CGRect)bounds;

@end
