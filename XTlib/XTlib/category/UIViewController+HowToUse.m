//
//  UIViewController+HowToUse.m
//  XTkit
//
//  Created by teason on 2017/4/24.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UIViewController+HowToUse.h"
#import "ScreenHeader.h"
#import "DeviceSysHeader.h"
#import <objc/runtime.h>



@implementation UIViewController (HowToUse)

#pragma mark --
#pragma mark - prop

@dynamic    guidingIndex    ,
            guidingStrList  ,
            imgViewGuide    ;

static char guidingIndexKey    ;
static char guidingStrListKey  ;
static char imgViewGuideKey    ;

- (int)guidingIndex
{
    return [(NSNumber *)objc_getAssociatedObject(self, &guidingIndexKey) intValue] ;
}

- (void)setGuidingIndex:(int)guidingIndex
{
    objc_setAssociatedObject(self, &guidingIndexKey, @(guidingIndex), OBJC_ASSOCIATION_ASSIGN) ;
}

- (NSArray *)guidingStrList
{
    return objc_getAssociatedObject(self, &guidingStrListKey) ;
}

- (void)setGuidingStrList:(NSArray *)guidingStrList
{
    objc_setAssociatedObject(self, &guidingStrListKey, guidingStrList, OBJC_ASSOCIATION_COPY_NONATOMIC) ;
    
    self.guidingIndex = 0 ;
    self.imgViewGuide.image = [UIImage imageNamed:guidingStrList[self.guidingIndex]] ;
}

- (UIImageView *)imgViewGuide
{
    return objc_getAssociatedObject(self, &imgViewGuideKey) ;
}

- (void)setImgViewGuide:(UIImageView *)imgViewGuide
{
    objc_setAssociatedObject(self, &imgViewGuideKey, imgViewGuide, OBJC_ASSOCIATION_RETAIN_NONATOMIC) ;
}

#pragma mark --
#pragma mark - setup

- (void)setupHowToUseInCtrller
{
    self.imgViewGuide = [[UIImageView alloc] init] ;
    CGRect rectGuiding = APPFRAME ;
    rectGuiding.size.height = ( DEVICE_IS_IPHONE5 ) ? APP_HEIGHT : APP_WIDTH / 9.0 * 16.0 ;
    self.imgViewGuide.frame = rectGuiding ;
    self.imgViewGuide.backgroundColor = nil ;
    self.imgViewGuide.userInteractionEnabled = YES ;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(clickGuidingImageView)] ;
    [self.imgViewGuide addGestureRecognizer:tapGesture] ;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.imgViewGuide] ;
}

- (void)clickGuidingImageView
{
    self.guidingIndex ++ ;
    
    if (self.guidingIndex > self.guidingStrList.count - 1)
    {
        [self.imgViewGuide removeFromSuperview] ;
    }
    else
    {
        self.imgViewGuide.image = [UIImage imageNamed:self.guidingStrList[self.guidingIndex]] ;
    }
}




@end
