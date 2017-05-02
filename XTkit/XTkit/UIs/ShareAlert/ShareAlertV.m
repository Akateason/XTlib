//
//  ShareAlertV.m
//  SuBaoJiang
//
//  Created by apple on 15/7/13.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "ShareAlertV.h"
#import "ShareAlertView.h"
#import "XTAnimation.h"
#import "ScreenHeader.h"



@interface ShareAlertV () <ShareAlertViewDelegate,AlertBackgroundViewDelegate>
{
    UIViewController *ctrller ;
}
@property (nonatomic,strong) ShareAlertView *alertView ;
@end

@implementation ShareAlertV

- (ShareAlertView *)alertView
{
    if (!_alertView)
    {
        _alertView = [[[NSBundle mainBundle] loadNibNamed:@"ShareAlertView" owner:self options:nil] lastObject] ;
        
        CGFloat height = 245.0 ;
        CGRect rect = CGRectZero ;
        rect.size = CGSizeMake(APPFRAME.size.width, height) ;
        rect.origin = CGPointMake(0, APPFRAME.size.height - height) ;
        _alertView.frame = rect ;
        _alertView.delegate = self ;
        if (![_alertView superview])
        {
            [self addSubview:_alertView] ;
            [XTAnimation smallBigBestInCell:_alertView] ;
        }
    }
    
    return _alertView ;
}


- (instancetype)initWithController:(UIViewController *)controller
{
    self = [super init] ;
    if (self)
    {
        self.delegate = self ;
        [self alertView] ;
        ctrller = controller ;
        [ctrller.view addSubview:self] ;
    }
    
    return self;
}

#pragma mark - ShareAlertViewDelegate BackgroundViewDelegate
- (void)cancel
{
    [self removeFromSuperview] ;
}

- (void)clickCollectionIndex:(NSInteger)index
{
    [self cancel] ;

//    NSLog(@"%d",index) ;
    if (self.aDelegate && [self.aDelegate respondsToSelector:@selector(clickIndex:)]) {
        [self.aDelegate clickIndex:index] ;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
