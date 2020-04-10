//
//  XTZoomPicture.h
//  XTZoomPicture
//
//  Created by teason on 15/12/3.
//  Copyright © 2015年 teason. All rights reserved.
// *** 处理小图片的缩放, 不适合大图渲染 *** //
// 需要 setImageView

#import <UIKit/UIKit.h>


@interface XTZoomPicture : UIScrollView
@property (nonatomic, strong) UIImageView *imageView;
- (void)onTapped:(void(^)(void))tapped;
- (void)reset;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)init ;
@end
