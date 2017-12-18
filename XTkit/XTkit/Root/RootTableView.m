//
//  RootTableView.m
//  Demo_MjRefresh
//
//  Created by TuTu on 15/12/3.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "RootTableView.h"
#import "RootRefreshHeader.h"
#import "RootRefreshFooter.h"


@interface RootTableView ()

@end

@implementation RootTableView

#pragma mark --
#pragma mark - Public
- (void)pullDownRefreshHeader
{
    [self pullDownRefreshHeaderInBackGround:FALSE] ;
}

- (void)pullDownRefreshHeaderInBackGround:(BOOL)isBackGround ;
{
    if (isBackGround)
    {
        if (self.xt_Delegate && [self.xt_Delegate respondsToSelector:@selector(loadNew:)])
        {
            __weak RootTableView *weakSelf = self ;
            [self.xt_Delegate loadNew:^{
                [weakSelf reloadTableInMainThread] ;
                [weakSelf.mj_header endRefreshing] ;
            }] ;
        }
    }
    else
    {
        [self.mj_header beginRefreshing] ;
    }
}

#pragma mark --
#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame
                          style:style] ;
    if (self) {
        [self setup] ;
    }
    return self ;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup] ;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup] ;
    }
    return self;
}

- (void)setup
{
    self.estimatedRowHeight = 0 ;
    self.estimatedSectionHeaderHeight = 0 ;
    self.estimatedSectionFooterHeight = 0 ;
    [self prepareStyle]         ;
    [self setDefaultPublicAPIs] ;
}

- (void)prepareStyle
{
    self.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [self configureMJRefresh] ;
}

- (void)configureMJRefresh
{
    RootRefreshHeader *header = [RootRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataSelector)];
    self.mj_header = header;
    
    RootRefreshFooter *footer = [RootRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSelector)];
    self.mj_footer = footer;
}

- (void)setDefaultPublicAPIs
{
    self.isShowRefreshDetail        = NO ;
    self.isAutomaticallyLoadMore    = NO ;
}

#pragma mark --
#pragma mark - Public Properties
- (void)setIsShowRefreshDetail:(BOOL)isShowRefreshDetail
{
    _isShowRefreshDetail = isShowRefreshDetail ;
    
    ((RootRefreshHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = !self.isShowRefreshDetail;
    ((RootRefreshHeader *)self.mj_header).stateLabel.hidden = !self.isShowRefreshDetail ;
    ((RootRefreshFooter *)self.mj_footer).stateLabel.hidden = !self.isShowRefreshDetail ;
}

- (void)setIsAutomaticallyLoadMore:(BOOL)isAutomaticallyLoadMore
{
    _isAutomaticallyLoadMore = isAutomaticallyLoadMore ;
    
    if (isAutomaticallyLoadMore)
    {
        self.mj_footer = nil ;
        MJRefreshAutoFooter *autofooter = [MJRefreshAutoFooter footerWithRefreshingTarget:self
                                                                         refreshingAction:@selector(loadMoreDataSelector)] ;
        autofooter.triggerAutomaticallyRefreshPercent = 0.55 ;
        self.mj_footer = autofooter;
    }
}


#pragma mark --
#pragma mark - loading methods

- (void)loadNewDataSelector
{
    if (!self.xt_Delegate || ![self.xt_Delegate respondsToSelector:@selector(loadNew:)])
    {
        [self.mj_header endRefreshing] ;
        return ;
    }
    
    // do request
    __weak RootTableView *weakSelf = self ;
    [weakSelf.xt_Delegate loadNew:^{
        [weakSelf reloadTableInMainThread] ;
        [weakSelf.mj_header endRefreshing] ;
    }] ;
}

- (void)loadMoreDataSelector
{
    if (!self.xt_Delegate || ![self.xt_Delegate respondsToSelector:@selector(loadMore:)])
    {
        [self.mj_footer endRefreshing] ;
        return ;
    }
    
    // do request
    __weak RootTableView *weakSelf = self ;
    if (self.isAutomaticallyLoadMore)
    {
        dispatch_async(dispatch_queue_create("refreshAutoFooter", NULL), ^
        {
            [weakSelf.xt_Delegate loadMore:^{
                [weakSelf reloadTableInMainThread] ;
                [weakSelf.mj_footer endRefreshing] ;
            }] ;
        }) ;
    }
    else
    {
        [weakSelf.xt_Delegate loadMore:^{
            [weakSelf reloadTableInMainThread] ;
            [weakSelf.mj_footer endRefreshing] ;
        }] ;
    }
}

- (void)reloadTableInMainThread
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData] ;
    }) ;
}

- (void)endRefresh {
    [self reloadTableInMainThread] ;
    if (self.mj_header.isRefreshing) [self.mj_header endRefreshing] ;
    if (self.mj_footer.isRefreshing) [self.mj_footer endRefreshing] ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
