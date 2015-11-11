//
//  RYDataBaseTable.m
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import "RYDataBaseTable.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabaseQueue.h"
#import "RYDataBaseTable+AnalyzeSQL.h"


#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@interface RYDataBaseTable ()

@property (strong, nonatomic) FMDatabaseQueue * dbQueue;
@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, copy) NSMutableString *sqlString;

@property (nonatomic, weak) id<RYDataBaseTableProtocol> child;

@end

@implementation RYDataBaseTable

- (instancetype)init
{
    self = [super init];
    if (self && [self conformsToProtocol:@protocol(RYDataBaseTableProtocol)]) {
        self.child = (RYDataBaseTable <RYDataBaseTableProtocol> *)self;
        
        [self createTable];
        
    } else {
        NSException *exception = [NSException exceptionWithName:@"RYDataBaseTable init error" reason:@"the child class must conforms to protocol: <RYDataBaseTableProtocol>" userInfo:nil];
        @throw exception;
    }
    return self;
}

- (void)createTable
{
    NSString * dbPath = [PATH_OF_DOCUMENT stringByAppendingPathComponent:[self.child databaseName]];
    NSLog(@"%@",dbPath);
    if (_dbQueue) {
        [self close];
    }
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    [self createTable:[self.child tableName] columnInfo:[self.child columnInfo]];
}

- (void)close {
    [_dbQueue close];
    _dbQueue = nil;
}

- (void)dealloc
{
    [self close];
}

#pragma mark - public methods

- (BOOL)createTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo
{
    NSString * sql = [self analyzeOfCreateTableWithTabelName:tableName columnInfo:columnInfo];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    
    return result;
}

- (BOOL)insertTable:(NSString *)tableName dataList:(NSArray *)dataList
{
    NSString * sql = [self analyzeOfInsertTableWithTabelName:tableName dataList:dataList];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    return result;
}

- (BOOL)updateTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo primary:(NSDictionary *)primary
{
    NSString * sql = [self analyzeOfUpdateTableWithTabelName:tableName columnInfo:columnInfo primary:primary];
    __block BOOL result;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        result = [db executeUpdate:sql];
    }];
    return result;
}

- (NSArray *)fetchTableWithSql:(NSString *)sql
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            
        }
        [rs close];
    }];
    return nil;
}


#pragma mark - getters and setters
- (NSMutableString *)sqlString
{
    if (_sqlString == nil) {
        _sqlString = [[NSMutableString alloc] init];
    }
    return _sqlString;
}


@end
