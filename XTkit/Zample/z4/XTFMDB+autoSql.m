//
//  XTFMDB+autoSql.m
//  XTkit
//
//  Created by teason23 on 2017/5/2.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTFMDB+autoSql.h"
#import <objc/runtime.h>
#import "NSObject+Reflection.h"
#import "XTJson.h"

@implementation XTFMDB (autoSql)

+ (NSString *)sqlCreateTableWithClass:(Class)cls
                           primaryKey:(NSString *)primaryKey
{
    NSString *tableName = NSStringFromClass(cls) ;
    NSMutableString *strProperties = [@"" mutableCopy] ;
    
    unsigned int outCount ;
    Ivar *ivars = class_copyIvarList(cls, &outCount) ;
    if (!outCount) {
        NSLog(@"xt_db model no instanceVal") ;
        return nil ;
    }
    
    for (int i = 0; i < outCount; i++)
    {
        NSString *name = [[NSString stringWithCString:ivar_getName(ivars[i])
                                            encoding:NSUTF8StringEncoding]
                          substringFromIndex:1];
        NSString *type = [NSObject decodeType:ivar_getTypeEncoding(ivars[i])] ;
        NSString *sqlType = [self sqlTypeWithType:type] ;
        
        
        NSString *strTmp = nil ;
        if ([name containsString:primaryKey])
        {
            // pk AUTOINCREMENT .
            strTmp = [NSString stringWithFormat:@"%@ %@ PRIMARY KEY AUTOINCREMENT DEFAULT '1',",name,sqlType] ;
        }
        else
        {
            // default
            strTmp = [NSString stringWithFormat:@"%@ %@ NOT NULL %@ ,",name,sqlType,[self defaultValWithSqlType:sqlType]] ;
        }
        [strProperties appendString:strTmp] ;
    }
    free(ivars) ;

    NSString *resultSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ ( %@ )",
                           tableName,
                           [strProperties substringToIndex:strProperties.length - 1] ] ;
    NSLog(@"xt_db sql create : \n%@",resultSql) ;
    return resultSql ;
}


+ (NSString *)sqlInsertWithModel:(id)model
{
    NSDictionary *dic = [XTJson getJsonWithModel:model] ;
    NSString *tableName = NSStringFromClass([model class]) ;
    
    unsigned int outCount ;
    Ivar *ivars = class_copyIvarList([model class], &outCount) ;
    if (!outCount) {
        NSLog(@"xt_db model no instanceVal") ;
        return nil ;
    }
    
    NSString *propertiesStr = @"" ;
    NSString *questionStr   = @"" ;
    
    for (int i = 0; i < outCount; i++)
    {
        NSString *name = [[NSString stringWithCString:ivar_getName(ivars[i])
                                             encoding:NSUTF8StringEncoding]
                          substringFromIndex:1] ;
        
        if (i == 0 && [name containsString:@"id"])
        {
            // 插入排除主键id (已经自增)
            continue ;
        }
        
        // prop
        propertiesStr = [propertiesStr stringByAppendingString:[NSString stringWithFormat:@"%@ ,",name]] ;
        // question
        questionStr = [questionStr stringByAppendingString:[NSString stringWithFormat:@"'%@' ,",dic[name]]] ;
    }
    free(ivars) ;
    
    propertiesStr = [propertiesStr substringToIndex:propertiesStr.length - 1] ;
    questionStr = [questionStr substringToIndex:questionStr.length - 1] ;
    
    NSString *strResult = [NSString stringWithFormat:@"INSERT INTO %@ ( %@ ) VALUES ( %@ )",tableName,propertiesStr,questionStr] ;
    NSLog(@"xt_db sql insert : \n%@",strResult) ;
    return strResult ;
}


+ (NSString *)sqlUpdateWithModel:(id)model
{
    NSString *tableName = NSStringFromClass([model class]) ;
    NSDictionary *dic = [XTJson getJsonWithModel:model] ;

    unsigned int outCount ;
    Ivar *ivars = class_copyIvarList([model class], &outCount) ;
    if (!outCount) {
        NSLog(@"xt_db model no instanceVal") ;
        return nil ;
    }
    
    NSString *setsStr = @"" ;
    NSString *whereStr = @"" ;
    NSString *primaryKey = nil ;
    
    for (int i = 0; i < outCount; i++)
    {
        NSString *name = [[NSString stringWithCString:ivar_getName(ivars[i])
                                             encoding:NSUTF8StringEncoding]
                          substringFromIndex:1] ;
        
        if (i == 0 && [name containsString:@"id"])
        {
            primaryKey = name ;
            continue ;
        }
        
        // setstr
        NSString *tmpStr = [NSString stringWithFormat:@"%@ = '%@' ,",name,dic[name]] ;
        setsStr = [setsStr stringByAppendingString:tmpStr] ;
    }
    free(ivars) ;

    setsStr = [setsStr substringToIndex:setsStr.length - 1] ;
    whereStr = [NSString stringWithFormat:@"%@ = %@",primaryKey,dic[primaryKey]] ;
    
    NSString *strResult = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE %@",tableName,setsStr,whereStr] ;
    NSLog(@"xt_db sql update : \n%@",strResult) ;
    return strResult ;
}

+ (NSString *)sqlDeleteWithTableName:(NSString *)tableName
                               where:(NSString *)strWhere
{
    return [NSString stringWithFormat:@"DELETE FROM %@ %@",tableName,strWhere] ;
}


+ (NSString *)drop:(NSString *)tableName
{
    return [NSString stringWithFormat:@"DROP TABLE %@",tableName] ;
}





+ (NSString *)sqlTypeWithType:(NSString *)strType
{
    if ([strType containsString:@"int"] || [strType containsString:@"Integer"])
    {
        return @"INTEGER" ;
    }
    else if ([strType containsString:@"float"] || [strType containsString:@"double"])
    {
        return @"DOUBLE" ;
    }
    else if ([strType containsString:@"long"])
    {
        return @"BIGINT" ;
    }
    else if ([strType containsString:@"NSString"] || [strType containsString:@"char"])
    {
        return @"TEXT" ;
    }
    NSLog(@"xt_db no type to transform !!") ;
    return nil ;
}

+ (NSString *)defaultValWithSqlType:(NSString *)sqlType
{
    if ([sqlType containsString:@"TEXT"] || [sqlType containsString:@"char"]) {
        return @" DEFAULT '' " ;
    }
    else return @" DEFAULT '0' " ;
}





@end
