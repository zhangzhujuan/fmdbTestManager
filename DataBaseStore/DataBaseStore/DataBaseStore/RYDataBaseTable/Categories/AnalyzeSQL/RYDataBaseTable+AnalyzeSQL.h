//
//  RYDataBaseTable+AnalyzeSQL.h
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import "RYDataBaseTable.h"

@interface RYDataBaseTable (AnalyzeSQL)
/**
 *   @author xiaerfei, 15-11-11 14:11:18
 *
 *   analyze CREATE TABLE sql
 *
 *   @param tableName  tableName
 *   @param columnInfo columnInfo
 *
 *   @return SQL
 */
- (NSString *)analyzeOfCreateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo;
/**
 *   @author xiaerfei, 15-11-11 14:11:27
 *
 *   analyze UPDATE sql
 *
 *   @param tableName  tableName
 *   @param columnInfo columnInfo
 *   @param primary    primary
 *
 *   @return SQL
 */
- (NSString *)analyzeOfUpdateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo primary:(NSDictionary *)primary;
/**
 *   @author xiaerfei, 15-11-11 14:11:55
 *
 *   analyze INSERT sql
 *
 *   @param tableName tableName
 *   @param dataList  dataList
 *
 *   @return SQL
 */
- (NSString *)analyzeOfInsertTableWithTabelName:(NSString *)tableName dataList:(NSArray *)dataList;

@end
