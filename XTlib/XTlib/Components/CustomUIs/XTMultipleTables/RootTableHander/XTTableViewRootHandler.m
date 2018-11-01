//
//  XTTableViewRootHandler.m
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTTableViewRootHandler.h"


@interface XTTableViewRootHandler () <UITableViewDataSource, UITableViewDelegate>

@end


@implementation XTTableViewRootHandler

#pragma mark--
#pragma mark - Initialization
- (instancetype)initWithTable:(UITableView *)table {
    self = [super init];
    if (self) {
        [self handleTableDatasourceAndDelegate:table];
    }
    return self;
}

#pragma mark--
#pragma mark - Public
- (void)handleTableDatasourceAndDelegate:(UITableView *)table {
    // set datasource and delegate .
    table.dataSource = self;
    table.delegate   = self;
    // needs layout
    [table setNeedsLayout];
}

- (void)refreshOffsetYWithTable:(UITableView *)table {
    CGPoint offset      = table.contentOffset;
    offset.y            = self.offsetY;
    table.contentOffset = offset;
}

- (void)table:(UITableView *)table IsFromCenter:(BOOL)isFromCenter {
    //1. do sth . only center table will do .

    //2. do sth  left right table will do .
}

- (void)centerHandlerRefreshing {
}


#pragma mark - root table view delegate
- (void)loadNewData {
}

- (void)loadMoreData {
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


@end
