//
//  RootTableCell.h
//  XTkit
//
//  Created by teason on 2017/4/20.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface RootTableCell : UITableViewCell

// initial without Xib or Storyborad
+ (instancetype)cellWithTable:(UITableView *)tableView ;

#pragma mark - rewrite in sub cls
// UI and Layout
- (void)prepare ;
// set model
- (void)configure:(id)model ;
// height
+ (CGFloat)cellHeight ;

@end
