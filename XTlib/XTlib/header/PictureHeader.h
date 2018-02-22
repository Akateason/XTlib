//
//  PictureHeader.h
//
//  Created by apple on 15/7/13.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#ifndef PictureHeader_h
#define PictureHeader_h

// Global Images
#define IMG_NOPIC               [UIImage imageNamed:@"nopic"]
#define IMG_HEAD_NO             [UIImage imageNamed:@"headNo"]
#define IMG_PHONE_WID(STR,W)    [STR stringByAppendingString:[NSString stringWithFormat:@"?imageView/2/w/%@",@(W)]]

#define IMAGE_SIZE_SCALE2(_size_)        CGSizeMake(_size_.width * 2., _size_.height * 2.)

// Qiniu url
extern NSString *const URL_QINIU_HEAD ;

#endif
