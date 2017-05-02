//
//  ResultParsered.m
//  SuBaoJiang
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "ResultParsered.h"

@implementation ResultParsered

//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"errCode" : @"returnCode" ,
             @"message" : @"returnMsg"  ,
             @"info"    : @"returnData"}
    ;
}


@end
