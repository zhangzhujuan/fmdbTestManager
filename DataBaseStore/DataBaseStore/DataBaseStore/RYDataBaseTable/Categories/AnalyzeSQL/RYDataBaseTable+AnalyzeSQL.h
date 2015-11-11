//
//  RYDataBaseTable+AnalyzeSQL.h
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import "RYDataBaseTable.h"

@interface RYDataBaseTable (AnalyzeSQL)

- (NSString *)analyzeOfCreateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo;

- (NSString *)analyzeOfUpdateTableWithTabelName:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo primary:(NSDictionary *)primary;

- (NSString *)analyzeOfInsertTableWithTabelName:(NSString *)tableName dataList:(NSArray *)dataList;

@end
