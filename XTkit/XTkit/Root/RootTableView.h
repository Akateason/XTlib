//
//  RootTableView.h
//  带上下拉刷新的tableView基类. 只需关注处理数据 .
//
//  Created by TuTu on 15/12/3.
//  Copyright © 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"

@protocol RootTableViewDelegate <NSObject>
@optional
- (void)loadNew:(void(^)(void))endRefresh   ;
- (void)loadMore:(void(^)(void))endRefresh  ;
@end

@interface RootTableView : UITableView

@property (nonatomic,weak) id <RootTableViewDelegate> xt_Delegate ;
// DEFAULT IS `NO`  -> ONLY GIF IMAGES , SHOW WORDS WHEN IT BECOMES `YES`
@property (nonatomic) BOOL showRefreshDetail ;
// DEFAULT IS `NO`  -> MANUALLY LOADING . AUTOMATICALLY LOAD WHEN IT BECOMES `YES`
@property (nonatomic) BOOL automaticallyLoadMore ;
// DEFAULT IS `YES` -> EVERYTIME INITIAL WITH AUTO LOAD NEW . CHANGE IT TO `NO` IF NECESSARY .
@property (nonatomic) BOOL automaticallyLoadNew ;

// pull header
- (void)pullDownRefreshHeader ;

// prepareStyle . u can rewrite in subclass
- (void)prepareStyle ;

@end
