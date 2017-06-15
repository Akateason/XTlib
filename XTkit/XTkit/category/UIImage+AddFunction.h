//
//  UIImage+AddFunction.h
//  ParkingSys
//
//  Created by mini1 on 14-6-13.
//  Copyright (c) 2014年 mini1. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface UIImage (AddFunction)

#pragma mark -- 
#pragma mark - style
//裁剪圆形 + 边框
- (UIImage *)cutImageWithCircleWithBorderWidth:(CGFloat)margin
                            AndWithBorderColor:(UIColor *)borderColor ;

+ (UIImage *)image:(UIImage *)image
          rotation:(UIImageOrientation)orientation ;

//裁剪正方
+ (UIImage *)squareImageFromImage:(UIImage *)image
                     scaledToSize:(CGFloat)newSize ;

//添加水印
- (UIImage *)imageWithWaterMask:(UIImage*)mask
                         inRect:(CGRect)rect;

//缩略图thumbnail
+ (UIImage *)thumbnailWithImage:(UIImage *)image
                           size:(CGSize)asize;
// 等比缩放
- (UIImage *)imageCompressForSize:(UIImage *)sourceImage
                       targetSize:(CGSize)size ;
- (UIImage *)imageCompressForWidth:(UIImage *)sourceImage
                       targetWidth:(CGFloat)defineWidth ;
//压缩图片质量
+ (UIImage *)compressQualityWithOriginImage:(UIImage *)sourceImage ;

//相册获取
+ (UIImage *)fetchFromLibrary:(ALAsset *)asset ;

//拍完照片的自适应旋转(和相机一起用)
+ (UIImage *)fixOrientation:(UIImage *)aImage;

//生成纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;

//改变图片颜色
- (UIImage *) imageWithTintColor:(UIColor *)tintColor ;

- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor ;

- (UIImage *) imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode ;


//将UIView转成UIImage
+ (UIImage *)getImageFromView:(UIView *)theView ;

//模糊
- (UIImage *)blur ;

- (UIImage *)boxblurImageWithBlur:(CGFloat)blur ;

#pragma mark -- 
#pragma mark - convert
//1.UIimage转换NSdata
- (NSData *)imageToData ;
//2.NSdata转换UIimage
- (UIImage *)dataToImage:(NSData *)_data ;

@end
