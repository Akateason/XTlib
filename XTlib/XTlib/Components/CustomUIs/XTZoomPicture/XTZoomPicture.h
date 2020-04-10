//
//  XTZoomPicture.h
//  XTZoomPicture
//
//  Created by teason on 15/12/3.
//  Copyright © 2015年 teason. All rights reserved.
// *** 处理小图片的缩放, 不适合大图渲染 *** //
//

#import <UIKit/UIKit.h>


@interface XTZoomPicture : UIScrollView
@property (nonatomic, strong) UIImageView *imageView;

- (id)initWithFrame:(CGRect)frame
          backImage:(UIImage *)backImage
             tapped:(void (^)(void))tapped;

- (id)initWithFrame:(CGRect)frame
           imageUrl:(NSString *)urlString
             tapped:(void (^)(void))tapped
       loadComplete:(void (^)(void))loadComplete;


- (void)resetToOrigin;

@end
