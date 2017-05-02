//
//  ResultParsered.h
//  SuBaoJiang
//
//  Created by apple on 15/6/4.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResultParsered : NSObject

@property (nonatomic)           NSInteger       errCode     ;
@property (nonatomic,copy)      NSString        *message    ;
@property (nonatomic,strong)    NSDictionary    *info       ;

@end
