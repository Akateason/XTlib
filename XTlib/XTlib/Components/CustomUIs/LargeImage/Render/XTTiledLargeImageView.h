//
//  TiledImageView.h
//  owl
//
//  Created by teason23 on 2020/2/28.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager+largeImage.h"



@interface XTTiledLargeImageView : UIView
@property (strong, nonatomic)   UIImage   *image;
@property (nonatomic)           CGFloat   imageScale;
- (void)setImage:(UIImage *)image scale:(CGFloat)scale ;
@end


