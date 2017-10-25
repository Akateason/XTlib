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
@required
- (void)loadNew:(void(^)(void))endRefresh   ;
@optional
- (void)loadMore:(void(^)(void))endRefresh  ;
@end

@interface RootTableView : UITableView
@property (nonatomic,weak) id <RootTableViewDelegate> xt_Delegate ;
/**
 REFRESH STYLE: 
 DEFAULT IS `NO`  -> ONLY GIF IMAGES , SHOW WORDS WHEN IT BECOMES `YES`
 */
@property (nonatomic) BOOL isShowRefreshDetail ;
/**
 is auto LOAD MORE:
 DEFAULT IS `NO`  -> MANUALLY LOADING . AUTOMATICALLY LOAD WHEN IT BECOMES `YES`
 */
@property (nonatomic) BOOL isAutomaticallyLoadMore ;
/**
 PULL DOWN HEADER
 */
- (void)pullDownRefreshHeader ;
/**
 PULL DOWN HEADER
 @param isBackGround    pull header in backgound or not .
 */
- (void)pullDownRefreshHeaderInBackGround:(BOOL)isBackGround ;
/**
 prepareStyle
 u can rewrite in subclass if needed
 */
- (void)prepareStyle ;

/**
 endRefresh header and footer if needed .
 */
- (void)endRefresh ;
@end













