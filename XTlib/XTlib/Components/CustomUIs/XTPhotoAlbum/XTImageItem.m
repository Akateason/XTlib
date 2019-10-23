//
//  XTImageItem.m
//  XTlib
//
//  Created by teason23 on 2019/10/23.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTImageItem.h"
#import <CoreServices/CoreServices.h>

@implementation XTImageItem



/// 只能从相机拍摄
- (instancetype)initWithImage:(UIImage *)image info:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        _imgType = [self.class imageFormatForImageInfo:info] ;
        _image = image ;
    }
    return self;
}

+ (XTImageItem_type)imageFormatForImageInfo:(NSDictionary *)info {
    NSString *key = info[@"PHImageFileUTIKey"] ;
    if ([key isEqualToString:(__bridge NSString *)kUTTypeGIF]) {
        return XTImageItem_type_gif ;
    }
    else if ([key isEqualToString:(__bridge NSString *)kUTTypeJPEG] || [key isEqualToString:(__bridge NSString *)kUTTypeJPEG2000]) {
        return XTImageItem_type_jpeg ;
    }
    else if ([key isEqualToString:(__bridge NSString *)kUTTypePNG]) {
        return XTImageItem_type_png ;
    }

    return XTImageItem_type_jpeg ;
}



@end
