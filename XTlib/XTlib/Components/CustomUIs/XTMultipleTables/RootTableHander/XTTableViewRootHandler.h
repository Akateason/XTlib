//
//  XTTableViewRootHandler.h
//  XTMultipleTables
//
//  Created by TuTu on 15/12/7.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface XTTableViewRootHandler : NSObject

@property (nonatomic) CGFloat offsetY; // cache offsetY .

// 这个参数要改成dic. 分别挂钩 1.header放置banner, 2.
- (instancetype)initWithTable:(UITableView *)table;

- (void)handleTableDatasourceAndDelegate:(UITableView *)table;
- (void)refreshOffsetYWithTable:(UITableView *)table;
- (void)table:(UITableView *)table IsFromCenter:(BOOL)isFromCenter;

@end
