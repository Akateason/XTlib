//
//  XTFMDB.m
//  XTkit
//
//  Created by teason23 on 2017/4/28.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTFMDB.h"
#import "FMDB.h"
#import "XTFMDB+autoSql.h"
#import "XTJson.h"
#import "YYModel.h"

#define SQLITE_NAME( _name_ )   [name stringByAppendingString:@".sqlite"]

#define DB                  [XTFMDB sharedInstance].database
#define QUEUE               [XTFMDB sharedInstance].queue

@interface XTFMDB ()

@property (nonatomic,strong) FMDatabase         *database   ;
@property (nonatomic,strong) FMDatabaseQueue    *queue      ;

@end



@implementation XTFMDB

DEF_SINGLETON(XTFMDB)

#pragma mark --
#pragma mark - configure
- (void)configureDB:(NSString *)name
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) ;
    NSString *documentPath = [filePath firstObject] ;
    NSLog(@"xt_db documentPath :\n%@", documentPath) ;
    NSLog(@"xt_db sqlName  : %@",name) ;
    NSString *path = [documentPath stringByAppendingPathComponent:SQLITE_NAME(name)] ;
    DB = [FMDatabase databaseWithPath:path] ;
    [DB open] ;
    QUEUE = [FMDatabaseQueue databaseQueueWithPath:path] ;
}


#pragma mark --
#pragma mark - create
- (void)createTable:(Class)cls
         primarykey:(NSString *)pkName
{
    NSString *tableName = NSStringFromClass(cls) ;
    
    if (![self verify]) return ;
    
    if(![self isTableExist:tableName])
    {
        // create table
        NSString *sql = [[XTFMDB class] sqlCreateTableWithClass:cls
                                                     primaryKey:pkName] ;
        BOOL bSuccess = [DB executeUpdate:sql] ;
        if (bSuccess) NSLog(@"xt_db create success") ;
        else NSLog(@"xt_db create fail") ;
    }
    else
        NSLog(@"xt_db already exist") ;
}

#pragma mark --
#pragma mark - insert

- (int)insert:(id)model
{
    NSString *tableName = NSStringFromClass([model class]) ;
    if (![self verify]) return -1 ;
    if(![self isTableExist:tableName]) return -2 ;
    
    BOOL bSuccess = [DB executeUpdate:[[XTFMDB class] sqlInsertWithModel:model]] ;
              
    if (bSuccess)
    {
        int lastID = (int)[DB lastInsertRowId] ;
        NSLog(@"xt_db insert success lastRowID : %d",lastID) ;
        return lastID ;
    }
    else
    {
        NSLog(@"xt_db insert fail") ;
    }
    return -3 ;
}

- (void)insertList:(NSArray *)modelList
        completion:(void(^)(BOOL bSuccess))completion
{
    if (![self verify]) return ;
    if (![self isTableExist:NSStringFromClass([[modelList firstObject] class])]) return ;
    
    [QUEUE inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        for (int i = 0; i < [modelList count]; i++)
        {
            id model = [modelList objectAtIndex:i] ;
            
            BOOL bSuccess = [db executeUpdate:[[XTFMDB class] sqlInsertWithModel:model]] ;
            
            if (bSuccess)
            {
                NSLog(@"xt_db transaction insert Successfrom index :%d",i) ;
            }
            else
            {
                // error
                NSLog(@"xt_db transaction insert Failure from index :%d",i) ;
                *rollback = TRUE ;
                if (completion) completion(FALSE) ;
                return ;
            }
        }
        NSLog(@"xt_db transaction insert all complete") ;
        if (completion) completion(TRUE) ;
    }] ;
}



#pragma mark --
#pragma mark - update
- (BOOL)update:(id)model
{
    NSString *tableName = NSStringFromClass([model class]) ;
    if (![self verify]) return FALSE ;
    if (![self isTableExist:tableName]) return FALSE ;
    
    BOOL bSuccess = [DB executeUpdate:[[XTFMDB class] sqlUpdateWithModel:model]] ;
    
    if (bSuccess)
    {
        NSLog(@"xt_db update success") ;
        return TRUE ;
    }
    else
    {
        NSLog(@"xt_db update fail") ;
    }
    return FALSE ;
}

- (void)updateList:(NSArray *)modelList
        completion:(void(^)(BOOL bSuccess))completion
{
    if (![self verify]) return ;
    if (![self isTableExist:NSStringFromClass([[modelList firstObject] class])]) return ;
    
    [QUEUE inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        for (int i = 0; i < [modelList count]; i++)
        {
            id model = [modelList objectAtIndex:i] ;
            BOOL bSuccess = [db executeUpdate:[[XTFMDB class] sqlUpdateWithModel:model]] ;
            
            if (bSuccess)
            {
                NSLog(@"xt_db transaction update Successfrom index :%d",i) ;
            }
            else
            {
                // error
                NSLog(@"xt_db transaction update Failure from index :%d",i) ;
                *rollback = TRUE ;
                if (completion) completion(FALSE) ;
                break ;
            }
        }
        NSLog(@"xt_db transaction update all complete") ;
        if (completion) completion(TRUE) ;
    }] ;
}

#pragma mark --
#pragma mark - select
- (NSArray *)selectAllFrom:(Class)cls
{
    return [self selectFrom:cls where:@""] ;
}

- (NSArray *)selectFrom:(Class)cls
                  where:(NSString *)strWhere
{
    NSString *tableName = NSStringFromClass(cls) ;
    if (![self verify]) return nil ;
    if(![self isTableExist:tableName]) return nil ;

    
    NSMutableArray *resultList = [@[] mutableCopy] ;
    FMResultSet *rs = [DB executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ %@",tableName,strWhere]] ;
    while ([rs next])
    {
        [resultList addObject:[cls yy_modelWithDictionary:[rs resultDictionary]]] ;
    }
    [rs close] ;
    return resultList ;
}


#pragma mark --
#pragma mark - delete
- (BOOL)deleteFrom:(NSString *)tableName
             where:(NSString *)strWhere
{
    if (![self verify]) return FALSE ;
    if(![self isTableExist:tableName]) return FALSE ;

    BOOL bSuccess = [DB executeUpdate:[[XTFMDB class] sqlDeleteWithTableName:tableName where:strWhere]] ;
    
    if (bSuccess)
    {
        NSLog(@"xt_db delete model success") ;
        return TRUE ;
    }
    else
    {
        NSLog(@"xt_db delete model fail") ;
    }
    return FALSE ;
}

- (BOOL)dropTable:(Class)cls
{
    NSString *tableName = NSStringFromClass(cls) ;
    if (![self verify]) return FALSE ;
    if(![self isTableExist:tableName]) return FALSE ;
    
    BOOL bSuccess = [DB executeUpdate:[[XTFMDB class] drop:tableName]] ;
    
    if (bSuccess)
    {
        NSLog(@"xt_db drop success") ;
        return TRUE ;
    }
    else
    {
        NSLog(@"xt_db drop fail") ;
    }
    return FALSE ;
}

#pragma mark --
#pragma mark - private
- (BOOL)verify
{
    if (!DB) {
        NSLog(@"xt_db not exist") ;
        return FALSE;
    }
    if (![DB open]) {
        NSLog(@"xt_db open failed") ;
        return FALSE;
    }
    
    return TRUE ;
}

- (BOOL)isTableExist:(NSString *)tableName
{
    BOOL bExist = [DB tableExists:tableName] ;
    if (!bExist) NSLog(@"xt_db table not created") ;
    return bExist ;
}

@end
