//
//  UIViewController+HowToUse.h
//  XTkit
//
//  Created by teason on 2017/4/24.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HowToUse)

@property (nonatomic,readonly)  int           guidingIndex      ;
@property (nonatomic,strong)    NSArray       *guidingStrList   ;
@property (nonatomic,strong)    UIImageView   *imgViewGuide     ;

- (void)setupHowToUseInCtrller ;

@end
