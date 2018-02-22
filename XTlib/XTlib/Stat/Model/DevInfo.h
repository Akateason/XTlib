//
//  DevInfo.h
//  XTkit
//
//  Created by teason23 on 2017/8/2.
//  Copyright © 2017年 teason. All rights reserved.
//  机型获取 首包 , 设备中只 上传一次 .

#import "XTDBModel.h"

@interface DevInfo : XTDBModel

@property (nonatomic,copy)      NSString     *UUID              ;
@property (nonatomic,copy)      NSString     *systemVersion     ; // 系统
@property (nonatomic,copy)      NSString     *phoneType         ; // 机型
@property (nonatomic)           long long    time               ; // occur time
@property (nonatomic,copy)      NSString     *dateStr           ; // occur time str
@property (nonatomic)           int          uploaded           ; // default 0 not upload

@end
