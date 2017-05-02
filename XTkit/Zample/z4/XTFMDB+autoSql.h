//
//  XTFMDB+autoSql.h
//  XTkit
//
//  Created by teason23 on 2017/5/2.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTFMDB.h"

@interface XTFMDB (autoSql)

+ (NSString *)sqlCreateTableWithClass:(Class)cls
                           primaryKey:(NSString *)primaryKey ;

+ (NSString *)sqlInsertWithModel:(id)model ;

+ (NSString *)sqlUpdateWithModel:(id)model ;

+ (NSString *)sqlDeleteWithTableName:(NSString *)tableName
                               where:(NSString *)strWhere ;

+ (NSString *)drop:(NSString *)tableName ;


@end
