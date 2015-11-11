//
//  RYDataBaseTable.h
//  RYDataBaseStore
//
//  Created by xiaerfei on 15/11/8.
//  Copyright © 2015年 geren. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RYDataBaseTableProtocol <NSObject>

@required
/**
 *  return the name of databse file, RYDataBaseTableProtocol will create CTDatabase by this string.
 *
 *  @return return the name of database file
 */
- (NSString *)databaseName;

/**
 *  the name of your table
 *
 *  @return return the name of your table
 */
- (NSString *)tableName;

/**
 *  column info with this table. If table not exists in database, RYDataBaseTable will create a table based on the column info you provided
 *
 *  @return return the column info of your table
 */
- (NSDictionary *)columnInfo;

@end



@interface RYDataBaseTable : NSObject



@property (nonatomic, weak, readonly) RYDataBaseTable <RYDataBaseTableProtocol> *child;



- (BOOL)createTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo;

- (BOOL)insertTable:(NSString *)tableName dataList:(NSArray *)dataList;

- (BOOL)updateTable:(NSString *)tableName columnInfo:(NSDictionary *)columnInfo primary:(NSDictionary *)primary;

- (NSArray *)fetchTableWithSql:(NSString *)sql;
@end
