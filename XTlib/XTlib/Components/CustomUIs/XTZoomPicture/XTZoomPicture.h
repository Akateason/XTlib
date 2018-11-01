//
//  XTZoomPicture.h
//  XTZoomPicture
//
//  Created by TuTu on 15/12/3.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XTZoomPicture : UIScrollView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *backImage;

- (id)initWithFrame:(CGRect)frame
          backImage:(UIImage *)backImage
                max:(float)max
                min:(float)min
               flex:(float)flex
             tapped:(void (^)(void))tapped;

- (void)resetToOrigin;

@end
