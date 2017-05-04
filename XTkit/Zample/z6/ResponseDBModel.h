//
//  ResponseDBModel.h
//  XTkit
//
//  Created by teason23 on 2017/5/4.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTDBModel.h"

@interface ResponseDBModel : XTDBModel

@property (nonatomic,copy) NSString     *requestUrl     ; // unique     KEY
@property (nonatomic,copy) NSString     *response       ; //            VAL
@property (nonatomic)      int          cacheType       ; // ?
@property (nonatomic)      long long    createTime      ;
@property (nonatomic)      long long    updateTime      ;
@property (nonatomic)      int          isDelete        ;

@end
