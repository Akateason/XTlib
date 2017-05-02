//
//  ShareAlertView.h
//  SuBaoJiang
//
//  Created by apple on 15/7/13.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShareAlertViewDelegate <NSObject>
- (void)cancel ;
- (void)clickCollectionIndex:(NSInteger)index ;
@end

@interface ShareAlertView : UIView
@property (nonatomic,weak) id <ShareAlertViewDelegate> delegate ;
@end
