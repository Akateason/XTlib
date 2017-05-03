//
//  XTFMDB.h
//  XTkit
//
//  Created by teason23 on 2017/4/28.
//  Copyright © 2017年 teason. All rights reserved.
//
//
// XTFMDB 特性
// 1.Model直接存储.获取. 无需转换
// 2.增删改查. 脱离sql语句
// 3.主键自增. 插入不需设主键
// 4.Model满足. 无容器, 无嵌套. 且第一行必须是主键的model . **注意: model的第一个属性必须是数字主键.且命名中须包含'id'两个字.
// 5.单条操作. 非线程安全
// 6.批量操作支持实务. 支持回滚. 线程安全
//



#import <Foundation/Foundation.h>
#import "FastCodeHeader.h"

@interface XTFMDB : NSObject

AS_SINGLETON(XTFMDB)

#pragma mark --
#pragma mark - configure
// App Did Launch .
- (void)configureDB:(NSString *)name ;


#pragma mark --
#pragma mark - create
- (void)createTable:(Class)cls
         primarykey:(NSString *)pkName ;


#pragma mark --
#pragma mark - insert
// return lastRowId .
- (int)insert:(id)model ;
- (void)insertList:(NSArray *)modelList
        completion:(void(^)(BOOL bSuccess))completion ;


#pragma mark --
#pragma mark - update
- (BOOL)update:(id)model ;
- (void)updateList:(NSArray *)modelList
        completion:(void(^)(BOOL bSuccess))completion ;


#pragma mark --
#pragma mark - select
- (NSArray *)selectAllFrom:(Class)cls ;
- (NSArray *)selectFrom:(Class)cls
                  where:(NSString *)strWhere ; //param e.g. @" WHERE ID = '1' "


#pragma mark --
#pragma mark - delete
- (BOOL)deleteFrom:(NSString *)tableName
             where:(NSString *)strWhere ; //param e.g. @" WHERE ID = '1' "
- (BOOL)dropTable:(Class)cls ;

@end
