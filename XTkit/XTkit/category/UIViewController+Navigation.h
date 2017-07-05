//
//  UIViewController+Navigation.h
//  XTkit
//
//  Created by teason23 on 2017/7/5.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NavigationBackButtonOnClick)(void) ;

@interface UIViewController (Navigation)
@property (nonatomic,copy) NavigationBackButtonOnClick navigationDidClickBackButton ;
@end
