//
//  XTImageItem.m
//  XTlib
//
//  Created by teason23 on 2019/10/23.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTImageItem.h"

@implementation XTImageItem

/// photokit init
- (instancetype)initWithData:(NSData *)data info:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        _imgType = [self.class imageFormatForImageInfo:info] ;
        _data = data ;
        _image = [UIImage imageWithData:data] ;
    }
    return self;
}

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
    if ([key isEqualToString:@"com.compuserve.gif"]) {
        return XTImageItem_type_gif ;
    }
    else if ([key isEqualToString:@"public.jpeg"] || [key isEqualToString:@"public.jpeg-2000"]) {
        return XTImageItem_type_jpeg ;
    }
    else if ([key isEqualToString:@"public.png"]) {
        return XTImageItem_type_png ;
    }

    return XTImageItem_type_jpeg ;
}



@end
