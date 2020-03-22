//
//  XTLargeImageCompressUtil.h
//  xtlib
//
//  Created by teason23 on 2020/2/25.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface XTLargeImageCompressUtil : NSObject
//TODO
+ (void)downsize:(nullable UIImage *)sourceImage
        complete:(void(^)(UIImage *image))completion ;



    



+ (UIImage *)scaledImageFromData:(NSData *)data
                           width:(CGFloat)width ;

@end


