//
//  ViewController.m
//  DataBaseStore
//
//  Created by xiaerfei on 15/11/10.
//  Copyright (c) 2015年 RongYu100. All rights reserved.
//

#import "ViewController.h"
#import "TestTable.h"



@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestTable *testTable = [[TestTable alloc] init];
    
    [testTable insertTable:@"test" dataList:@[@{@"name":@"erge",
                                               @"age":@(26),
                                               @"tomas":@"好好学习，天天向上！"}]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
