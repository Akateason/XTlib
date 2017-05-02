//
//  ShareAlertV.h
//  SuBaoJiang
//
//  Created by apple on 15/7/13.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "AlertBackgroundView.h"

@protocol ShareAlertVDelegate <NSObject>
- (void)clickIndex:(NSInteger)index ;
@end

@interface ShareAlertV : AlertBackgroundView
@property (nonatomic,weak) id <ShareAlertVDelegate> aDelegate ;
- (instancetype)initWithController:(UIViewController *)controller ;
@end
