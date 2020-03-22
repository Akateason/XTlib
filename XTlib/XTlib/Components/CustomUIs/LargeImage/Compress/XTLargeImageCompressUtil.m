//
//  XTLargeImageCompressUtil.m
//  xtlib
//
//  Created by teason23 on 2020/2/25.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "XTLargeImageCompressUtil.h"

@implementation XTLargeImageCompressUtil


/*
 *定义一张图片可以占用的最大空间
 */
//每个像素占用的字节数
static const size_t kBytesPerPixel = 4;
//色彩空间占用的字节数
static const size_t kBitsPerComponent = 8;
static const CGFloat kDestImageSizeMB = 60.0f;

static const CGFloat kSourceImageTileSizeMB = 20.0f;

static const CGFloat kBytesPerMB = 1024.0f * 1024.0f;
//1MB可以存储多少像素
static const CGFloat kPixelsPerMB = kBytesPerMB / kBytesPerPixel;
//如果像素小于这个值，则不解压缩
static const CGFloat kDestTotalPixels = kDestImageSizeMB * kPixelsPerMB;
static const CGFloat kTileTotalPixels = kSourceImageTileSizeMB * kPixelsPerMB;
//static const CGFloat kTileTotalPixels = 52480 ;//52480;

static const CGFloat kDestSeemOverlap = 2.0f;   // the numbers of pixels to overlap the seems where tiles meet.

//分片压缩
//TODO 解决内存问题
+ (void)downsize:(nullable UIImage *)sourceImage complete:(void(^)(UIImage *image))completion {
    // 创建NSAutoreleasePool
    @autoreleasepool {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            // 获取图片，这个时候是不会绘制
            if( sourceImage == nil ) NSLog(@"input image not found!");
        
            // 拿到当前图片的宽高
            CGSize sourceResolution = CGSizeZero;
            sourceResolution.width = CGImageGetWidth(sourceImage.CGImage);
            sourceResolution.height = CGImageGetHeight(sourceImage.CGImage);
        
            // 当前图片的像素
            float sourceTotalPixels = sourceResolution.width * sourceResolution.height;
        
            // 当前图片渲染到界面上的大小
            float sourceTotalMB = sourceTotalPixels / kPixelsPerMB;
            
            // 获取当前最合适的图片渲染大小，计算图片的缩放比例
            float imageScale = kDestTotalPixels / sourceTotalPixels;
            
            // 拿到缩放后的宽高
            CGSize destResolution = CGSizeZero;
            
            destResolution.width = (int)( sourceResolution.width * imageScale );
            destResolution.height = (int)( sourceResolution.height * imageScale );
            
            // 生成一个rgb的颜色空间
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            
            // 缩放情况下的每一行的字节数
            int bytesPerRow = kBytesPerPixel * destResolution.width;
            
            // 计算缩放情况下的位图大小，申请一块内存
            void* destBitmapData = malloc( bytesPerRow * destResolution.height );
            if( destBitmapData == NULL ) NSLog(@"failed to allocate space for the output image!");
            
            // 根据计算的参数生成一个合适尺寸的位图
            CGContextRef destContext;
            destContext = CGBitmapContextCreate( destBitmapData, destResolution.width, destResolution.height, 8, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast );
            
            // 如果生成失败了释放掉之前申请的内存
            if( destContext == NULL ) {
                free( destBitmapData );
                NSLog(@"failed to create the output bitmap context!");
            }
            
            // 释放掉颜色空间
            CGColorSpaceRelease( colorSpace );
            
            // 坐标系转换
            CGContextTranslateCTM( destContext, 0.0f, destResolution.height );
            CGContextScaleCTM( destContext, 1.0f, -1.0f );
            
            // 分块绘制的宽度（原始宽度）
            CGRect sourceTile = CGRectZero;
            sourceTile.size.width = sourceResolution.width;
            
            // 分块绘制的高度
            sourceTile.size.height = (int)( kTileTotalPixels / sourceTile.size.width );
            NSLog(@"source tile size: %f x %f",sourceTile.size.width, sourceTile.size.height);
            sourceTile.origin.x = 0.0f;
            
            // 绘制到位图上的宽高
            CGRect destTile = CGRectZero;
            destTile.size.width = destResolution.width;
            destTile.size.height = sourceTile.size.height * imageScale;
            destTile.origin.x = 0.0f;
            NSLog(@"dest tile size: %f x %f",destTile.size.width, destTile.size.height);
            
            // 重合的像素
            float sourceSeemOverlap =  (int)((kDestSeemOverlap/destResolution.height)*sourceResolution.height);
            //NSLog(@"dest seem overlap: %f, source seem overlap: %f",destSeemOverlap, sourceSeemOverlap);
            CGImageRef sourceTileImageRef;
            
            // 分块绘制需要多少次才能绘制完成
            int iterations = (int)( sourceResolution.height / sourceTile.size.height );
            int remainder = (int)sourceResolution.height % (int)sourceTile.size.height;
            if( remainder ) iterations++;
            
            // 添加重合线条
            float sourceTileHeightMinusOverlap = sourceTile.size.height;
            sourceTile.size.height += sourceSeemOverlap;
            destTile.size.height += kDestSeemOverlap;
            
                        
            // 分块绘制
            for( int y = 0; y < iterations; ++y ) {
                // create an autorelease pool to catch calls to -autorelease made within the downsize loop.
                NSLog(@"iteration %d of %d",y+1,iterations);
                sourceTile.origin.y = y * sourceTileHeightMinusOverlap + sourceSeemOverlap;
                destTile.origin.y = ( destResolution.height ) - ( ( y + 1 ) * sourceTileHeightMinusOverlap * imageScale + kDestSeemOverlap );
                
                // 分块拿到图片数据
                sourceTileImageRef = CGImageCreateWithImageInRect( sourceImage.CGImage, sourceTile );
                
                // 计算绘制的位置
                if( y == iterations - 1 && remainder ) {
                    float dify = destTile.size.height;
                    destTile.size.height = CGImageGetHeight( sourceTileImageRef ) * imageScale;
                    dify -= destTile.size.height;
                    destTile.origin.y += dify;
                }
                
                // 绘制到位图上
                CGContextDrawImage( destContext, destTile, sourceTileImageRef );
                
                // 释放内存
                CGImageRelease( sourceTileImageRef );
            }
                
                // CGBitmapContextCreateImage 是内存暴增的问题
                CGImageRef destImageRef = CGBitmapContextCreateImage(destContext);
                CGContextRelease(destContext);
                if (destImageRef == NULL) {
                    completion(sourceImage);
                }
                //生成处理结束以后的图片
                UIImage *destImage = [UIImage imageWithCGImage:destImageRef scale:sourceImage.scale orientation:sourceImage.imageOrientation];
                CGImageRelease(destImageRef);
                if (destImage == nil) {
                    completion(sourceImage);
                }

                completion(sourceImage);
        });
    }
}






//  imageIO compress
+ (UIImage *)scaledImageFromData:(NSData *)data width:(CGFloat)width  {
    CFDataRef dataRef = (__bridge CFDataRef)data;
    CFDictionaryRef dataOpt = (__bridge CFDictionaryRef) @{(id) kCGImageSourceShouldCache : @NO} ;
    CGImageSourceRef source = CGImageSourceCreateWithData(dataRef, dataOpt);
    CFRelease(dataRef);
    
    CFDictionaryRef options = (__bridge CFDictionaryRef) @{
                                                           (id) kCGImageSourceCreateThumbnailWithTransform : @YES,
//                                                           (id) kCGImageSourceShouldCacheImmediately: @YES,
                                                           (id) kCGImageSourceCreateThumbnailFromImageAlways : @YES,
                                                           (id) kCGImageSourceThumbnailMaxPixelSize : @(width)
                                                           };
    CGImageRef scaledImageRef = CGImageSourceCreateThumbnailAtIndex(source, 0, options);
    UIImage *scaled = [UIImage imageWithCGImage:scaledImageRef];
    CGImageRelease(scaledImageRef);
    return scaled;
}


@end
