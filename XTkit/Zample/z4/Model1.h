//
//  Model1.h
//  XTkit
//
//  Created by teason23 on 2017/5/2.
//  Copyright © 2017年 teason. All rights reserved.

// 目前只满足. 无容器, 无嵌套. 且第一行必须是主键的model

#import <Foundation/Foundation.h>

@interface Model1 : NSObject

@property (nonatomic) int           idModel ; // pk
@property (nonatomic) int           age ;
@property (nonatomic) float         floatVal ;
@property (nonatomic) long long     tick ;
@property (nonatomic,copy) NSString *title ;

@end
