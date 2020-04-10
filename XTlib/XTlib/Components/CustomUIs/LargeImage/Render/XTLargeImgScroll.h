//
//  XTLargeImgScroll.h
//  XTlib
//
//  Created by teason23 on 2020/4/10.
//  Copyright © 2020 teason23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XTTiledLargeImageView.h"


NS_ASSUME_NONNULL_BEGIN

@interface XTLargeImgScroll : UIScrollView <UIScrollViewDelegate>
@property (strong, nonatomic)    XTTiledLargeImageView         *largeImgView;

- (id)initWithFrame:(CGRect)frame;
- (void)setupLargeImage:(UIImage *)img;
@end

NS_ASSUME_NONNULL_END
