//
//  NSString+Extend.m
//  SuBaoJiang
//
//  Created by apple on 15/7/17.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "NSString+Extend.h"

@implementation NSString (Extend)

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

// 去掉小数点后面的0
+ (NSString *)changeFloat:(NSString *)stringFloat
{
    const char *floatChars = [stringFloat UTF8String] ;
    NSUInteger length = [stringFloat length] ;
    NSUInteger zeroLength = 0 ;
    NSInteger i = length - 1 ;
    for(; i>=0; i--)
    {
        if(floatChars[i] == '0'/*0x30*/)
        {
            zeroLength++;
        } else {
            if(floatChars[i] == '.')
                i--;
            break;
        }
    }
    NSString *returnString;
    if(i == -1) {
        returnString = @"0" ;
    } else {
        returnString = [stringFloat substringToIndex:i+1] ;
    }
    return returnString;
}

// 数组切换','字符串
+ (NSString *)getCommaStringWithArray:(NSArray *)array
{
    NSString *strResult = @"" ;
    
    for (int i = 0; i < array.count; i++)
    {
        if (i == array.count - 1)
        {
            NSString *tempStr = [NSString stringWithFormat:@"%@",array[i]] ;
            strResult = [strResult stringByAppendingString:tempStr];
        }
        else
        {
            NSString *tempStr = [NSString stringWithFormat:@"%@,",array[i]] ;
            strResult = [strResult stringByAppendingString:tempStr];
        }
    }
    
    return strResult ;
}

+ (NSArray *)getArrayFromCommaString:(NSString *)commaStr
{
    return [commaStr componentsSeparatedByString:@","] ;
}


@end
