//
//  NSString+XTReq_Extend.h
//  XTReq
//
//  Created by teason23 on 2018/2/22.
//  Copyright © 2018年 teaason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (XTReq_Extend)
// 去除空格.
- (NSString *)minusSpaceStr ;

// \n
- (NSString *)minusReturnStr ;

// 转义单引号  '  -> \'
- (NSString *)encodeTransferredMeaningForSingleQuotes ;
// 转义单引号  \' -> '
- (NSString *)decodeTransferredMeaningForSingleQuotes ;

@end
