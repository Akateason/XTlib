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
 @param model           any viewModel
 @param indexPath       indexPath for Cell
 *
 * USAGE
 *    - (void)configure:(id)model {
 *          [super configure: model] ;
 *
 *          // do configuration ...
 *    }
 *
 */
- (void)configure:(id)model indexPath:(NSIndexPath *)indexPath ;
- (void)configure:(id)model ;

// height
+ (CGFloat)cellHeight ;
+ (CGFloat)cellHeightForModel:(id)model ;

@end
