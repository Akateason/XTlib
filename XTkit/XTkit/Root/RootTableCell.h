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

@property (strong, nonatomic) NSIndexPath *indexPath ;
@property (strong, nonatomic, readonly) id model ;

// initial in pure code way
+ (instancetype)cellWithTable:(UITableView *)tableView ;

#pragma mark - rewrite in sub cls
// UI and Layout
- (void)prepareUI ;

/**
 * set model rewrite in subclass
 *
 *    - (void)configure:(id)model {
 *          [super configure: model] ;
 *
 *          // do configuration ...
 *    }
 *
 */
- (void)configure:(id)model ;
- (void)configure:(id)model
        indexPath:(NSIndexPath *)indexPath ;

// height
+ (CGFloat)cellHeight ;
- (CGFloat)cellHeight ;

@end
