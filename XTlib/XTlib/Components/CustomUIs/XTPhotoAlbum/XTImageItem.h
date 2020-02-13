//
//  XTImageItem.h
//  XTlib
//
//  Created by teason23 on 2019/10/23.
//  Copyright © 2019 teason23. All rights reserved.
//将所有的heic 转为 jpg 输出.

#import <Foundation/Foundation.h>
#import <UIkit/UIKit.h>
#import <Photos/Photos.h>

typedef enum : NSUInteger {        
    XTImageItem_type_jpeg,
    XTImageItem_type_png,
    XTImageItem_type_gif,
    XTImageItem_type_heic, // 仅标记
} XTImageItem_type ;

@interface XTImageItem : NSObject
@property (strong, nonatomic) UIImage           *image  ;
@property (strong, nonatomic) NSData            *data   ;
@property (nonatomic)         XTImageItem_type  imgType ;


/// photokit init
- (instancetype)initWithData:(NSData *)data info:(NSDictionary *)info ;
/// camera init
- (instancetype)initWithImage:(UIImage *)image info:(NSDictionary *)info ;

+ (XTImageItem_type)imageFormatForImageInfo:(NSDictionary *)info ;
+ (BOOL)imageIsHeicType:(NSDictionary *)info ;


@end


