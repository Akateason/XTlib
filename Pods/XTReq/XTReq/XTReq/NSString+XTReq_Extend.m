//
//  NSString+XTReq_Extend.m
//  XTReq
//
//  Created by teason23 on 2018/2/22.
//  Copyright © 2018年 teaason. All rights reserved.
//

#import "NSString+XTReq_Extend.h"

@implementation NSString (XTReq_Extend)

- (NSString *)minusSpaceStr
{
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet] ;
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"] ;
    
    NSArray *parts = [self componentsSeparatedByCharactersInSet:whitespaces] ;
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings] ;
    
    return [filteredArray componentsJoinedByString:@" "] ;
}

- (NSString *)minusReturnStr
{
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] ;
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""] ;
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""] ;
    
    return content ;
}


static NSString *const kSingleQuotes = @"&SingleQuotes&" ;

// 转义单引号  '  -> \'
- (NSString *)encodeTransferredMeaningForSingleQuotes
{
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] ;
    content = [content stringByReplacingOccurrencesOfString:@"\'" withString:kSingleQuotes] ;
    NSLog(@"content : %@",content) ;
    return content ;
}

// 转义单引号  \' -> '
- (NSString *)decodeTransferredMeaningForSingleQuotes
{
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] ;
    content = [content stringByReplacingOccurrencesOfString:kSingleQuotes withString:@"\'"] ;
    return content ;
}


@end
