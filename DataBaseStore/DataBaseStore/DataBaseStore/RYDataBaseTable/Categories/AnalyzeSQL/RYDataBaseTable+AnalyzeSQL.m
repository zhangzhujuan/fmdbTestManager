//
//  RYDataBaseTable+AnalyzeSQL.m
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import "RYDataBaseTable+AnalyzeSQL.h"

#define isEmptyString(string) ((string == nil || string.length == 0) ? YES : NO)

@implementation RYDataBaseTable (AnalyzeSQL)

- (NSString *)analyzeOfCreateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo
{
    
    NSMutableString *sql = [[NSMutableString alloc] init];
    
    NSMutableArray *columnList = [[NSMutableArray alloc] init];
    [columnInfo enumerateKeysAndObjectsUsingBlock:^(NSString *  columnName, NSString *  columnDescription, BOOL *  stop) {
        NSString *safeColumnName = columnName;
        NSString *safeDescription = columnDescription;
        
        if (isEmptyString(safeDescription)) {
            [columnList addObject:[NSString stringWithFormat:@"`%@`", safeColumnName]];
        } else {
            [columnList addObject:[NSString stringWithFormat:@"`%@` %@", safeColumnName, safeDescription]];
        }
    }];
    
    NSString *columns = [columnList componentsJoinedByString:@","];
    [sql appendFormat:@"CREATE TABLE IF NOT EXISTS `%@` (%@);", tableName, columns];
    
    return sql;
}

- (NSString *)analyzeOfUpdateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo primary:(NSDictionary *)primary;
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSMutableArray *valueList = [[NSMutableArray alloc] init];
    [columnInfo enumerateKeysAndObjectsUsingBlock:^(id   key, id   obj, BOOL *  stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [valueList addObject:[NSString stringWithFormat:@"`%@`='%@'", key,obj]];
        } else if ([obj isKindOfClass:[NSNull class]]) {
            [valueList addObject:[NSString stringWithFormat:@"`%@`=NULL", key]];
        } else {
            [valueList addObject:[NSString stringWithFormat:@"`%@`=%@", key, obj]];
        }
    }];
    NSString *primaryKey = [primary.allKeys lastObject];
    NSString *conditon = nil;
    if ([primary[primaryKey] isKindOfClass:[NSString class]]) {
        conditon = [NSString stringWithFormat:@"WHERE %@=`%@`",primaryKey,primary[primaryKey]];
    } else {
        conditon = [NSString stringWithFormat:@"WHERE %@=%@",primaryKey,primary[primaryKey]];
    }
    
    NSString *columns = [NSString stringWithFormat:@"%@ %@",[valueList componentsJoinedByString:@","],conditon];
    [sql appendFormat:@"UPDATE `%@` SET %@;", tableName, columns];
    return sql;
}

- (NSString *)analyzeOfInsertTableWithTabelName:(NSString *)tableName dataList:(NSArray *)dataList;
{
    NSMutableString *sql = [[NSMutableString alloc] init];
    NSMutableArray *valueItemList = [[NSMutableArray alloc] init];
    __block NSString *columString = nil;
    [dataList enumerateObjectsUsingBlock:^(NSDictionary *  description, NSUInteger idx, BOOL *  stop) {
        NSMutableArray *columList = [[NSMutableArray alloc] init];
        NSMutableArray *valueList = [[NSMutableArray alloc] init];
        
        [description enumerateKeysAndObjectsUsingBlock:^(NSString *  colum, NSString *  value, BOOL *  stop) {
            [columList addObject:[NSString stringWithFormat:@"`%@`", colum]];
            if ([value isKindOfClass:[NSString class]]) {
                [valueList addObject:[NSString stringWithFormat:@"'%@'", value]];
            } else if ([value isKindOfClass:[NSNull class]]) {
                [valueList addObject:@"NULL"];
            } else {
                [valueList addObject:[NSString stringWithFormat:@"'%@'", value]];
            }
        }];
        
        if (columString == nil) {
            columString = [columList componentsJoinedByString:@","];
        }
        NSString *valueString = [valueList componentsJoinedByString:@","];
        
        [valueItemList addObject:[NSString stringWithFormat:@"(%@)", valueString]];
    }];
    
    [sql appendFormat:@"INSERT INTO `%@` (%@) VALUES %@;", tableName, columString, [valueItemList componentsJoinedByString:@","]];
    return sql;
}




@end
