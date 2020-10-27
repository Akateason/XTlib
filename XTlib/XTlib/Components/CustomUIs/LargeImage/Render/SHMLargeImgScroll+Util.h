//
//  SHMLargeImgScroll+Util.h
//  owl
//
//  Created by teason23 on 2020/7/7.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SHMLargeImgScroll.h"



@interface SHMLargeImgScroll (Util)

- (void)turnOnActivityIndicator:(BOOL)on;

- (void)resetScrollToOrigin;
- (void)resetScrollToOriginAnimated:(BOOL)animated;

- (void)setupContainerFrame:(CGRect)frameToCenter;


/// getInfoFromImage Then SetContainerFrame
/// 1. 根据图片实际尺寸 和 屏幕尺寸 计算图片视图尺寸
/// @return tuple @[@(imageScale), @(imageRect)]
/// 2. 然后针对图片去setFrame
- (RACTuple *)getInfoFromImageThenSetContainerFrame:(UIImage *)img;

- (void)setupContainerFrameWithImage:(UIImage *)img;

- (BOOL)isRenderPhotoOnScreenCenter;

//[UIImage shm_spinImage:image rotation:orientation complete:complete];
/// get orientation
+ (UIImageOrientation)getUIImageOrientation:(NSInteger)spinRate;
@end


