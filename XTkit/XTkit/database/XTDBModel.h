//
//  XTDBModel.h
//  XTkit
//
//  Created by teason23 on 2017/5/4.
//  Copyright © 2017年 teason. All rights reserved.
//
// 特性
// 1.Model直接存储.获取. 无需转换
// 2.增删改查. 脱离sql语句
// 3.主键自增. 插入不需设主键
// 4.Model满足. 无容器, 无嵌套. model的第一个属性必须是数字主键.且命名中须包含'pkid'.默认为pkid
// 5.任何操作. 线程安全
// 6.批量操作支持实务. 支持回滚. 线程安全
//


#import <Foundation/Foundation.h>

static NSString *const kPkid = @"pkid" ;

@interface XTDBModel : NSObject
// primaryKey
@property (nonatomic,assign) int pkid ;

#pragma mark - create
+ (BOOL)createTable ;

#pragma mark - insert
- (int)insert ;// return lastRowId .
+ (BOOL)insertList:(NSArray *)modelList ;

#pragma mark - update
- (BOOL)update ;
+ (BOOL)updateList:(NSArray *)modelList ;

#pragma mark - select
+ (NSArray *)selectAll ;
+ (NSArray *)selectWhere:(NSString *)strWhere ; //param e.g. @" pkid = '1' "
+ (instancetype)findFirstWhere:(NSString *)strWhere ;
+ (BOOL)hasModelWhere:(NSString *)strWhere ;

#pragma mark - delete
- (BOOL)deleteModel ;
+ (BOOL)deleteModelWhere:(NSString *)strWhere ; //param e.g. @" pkid = '1' "
+ (BOOL)dropTable ;

#pragma mark - props Sqlite Keywords
+ (NSDictionary *)modelPropertiesSqliteKeywords ;

@end
