//
//  AlertBackgroundView.h
//  SuBaoJiang
//
//  Created by apple on 15/7/14.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AlertBackgroundViewDelegate <NSObject>
- (void)cancel ;
@end

@interface AlertBackgroundView : UIView
@property (nonatomic,weak) id <AlertBackgroundViewDelegate> delegate ;
@end
