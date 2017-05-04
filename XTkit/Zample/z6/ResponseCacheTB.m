//
//  ResponseCacheTB.m
//  XTkit
//
//  Created by teason23 on 2017/5/4.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "ResponseCacheTB.h"

@implementation ResponseCacheTB

// 非数字主键.
- (void)createTable:(Class)cls
         primarykey:(NSString *)pkName
{
//    NSString *tableName = NSStringFromClass(cls) ;
//    
//    if (![self verify]) return ;
//    
//    if(![self isTableExist:tableName])
//    {
//        [QUEUE inDatabase:^(FMDatabase *db) {
//            // create table
//            NSString *sql = [[XTFMDB class] sqlCreateTableWithClass:cls
//                                                         primaryKey:pkName] ;
//            BOOL bSuccess = [db executeUpdate:sql] ;
//            if (bSuccess) NSLog(@"xt_db create success") ;
//            else NSLog(@"xt_db create fail") ;
//        }] ;
//    }
//    else
//        NSLog(@"xt_db already exist") ;
}


@end
