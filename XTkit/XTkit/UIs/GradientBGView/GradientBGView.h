//
//  GradientBGView.h
//  pro
//
//  Created by TuTu on 16/9/18.
//  Copyright © 2016年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef IB_DESIGNABLE
IB_DESIGNABLE
#endif

#ifndef IBInspectable
#define IBInspectable
#endif
@interface GradientBGView : UIView

/* Both points are
 * defined in a unit coordinate space that is then mapped to the
 * view's bounds rectangle when drawn. (I.e. [0,0] is the top-left
 * corner of the view, [1,1] is the bottom-right corner.) */
@property (nonatomic) IBInspectable CGPoint inputPoint0;
@property (nonatomic) IBInspectable CGPoint inputPoint1;

@property (nonatomic) IBInspectable UIColor *inputColor0;
@property (nonatomic) IBInspectable UIColor *inputColor1;

@end
