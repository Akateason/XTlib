//
//  SHMLargeImgScroll+Render.h
//  owl
//
//  Created by teason23 on 2020/7/7.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SHMLargeImgScroll.h"



@interface SHMLargeImgScroll (Render)

- (void)renderGallaryPhoto:(void(^)(void))complete;

- (void)renderLoadingState;

// 下载完成后,判断是否大图, 保存在本地. // 如果是大图,去生成缩略图.
- (void)renderDoneState:(void(^)(void))complete;

- (void)renderErrorState;

- (void)renderPhoto:(void(^)(void))complete;

+ (void)spinImage:(UIImage *)image
         spinRate:(int)rate
         complete:(void(^)(UIImage *img))complete;

- (void)showErrorViews:(BOOL)isOn;

@end


