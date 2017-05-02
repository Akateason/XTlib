//
//  XTFMDB.h
//  XTkit
//
//  Created by teason23 on 2017/4/28.
//  Copyright © 2017年 teason. All rights reserved.
//
// 目前只满足. 无容器, 无嵌套. 且第一行必须是主键的model
// 未涉及queue. 线程安全 ?
// 事务 回滚 多行
// insert update 需要合并 ?


#import <Foundation/Foundation.h>
#import "FastCodeHeader.h"

@interface XTFMDB : NSObject

AS_SINGLETON(XTFMDB)

#pragma mark -
- (void)configureDB:(NSString *)name ; // App Did Launch .

#pragma mark --
#pragma mark - create
- (void)createTable:(Class)cls
         primarykey:(NSString *)pkName ;

#pragma mark --
#pragma mark - insert
- (int)insert:(id)model ; // return lastRowId .

#pragma mark --
#pragma mark - update
- (BOOL)update:(id)model ;

#pragma mark --
#pragma mark - select
- (NSArray *)selectAllFrom:(Class)cls ;
- (NSArray *)selectAllFrom:(Class)cls
                     where:(NSString *)strWhere ; // WHERE ID = '1'

#pragma mark --
#pragma mark - delete
- (BOOL)deleteFrom:(NSString *)tableName
             where:(NSString *)strWhere ;

- (BOOL)dropTable:(Class)cls ;


@end
