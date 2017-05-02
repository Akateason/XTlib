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
    [self.mj_header beginRefreshing] ;
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
    [self prepareStyle]         ;
    [self setDefaultPublicAPIs] ;
}

- (void)prepareStyle
{
    self.separatorStyle = UITableViewCellSeparatorStyleNone ;
    [self MJRefreshConfigure] ;
}

- (void)MJRefreshConfigure
{
    RootRefreshHeader *header = [RootRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataSelector)];
    self.mj_header = header;
    
    RootRefreshFooter *footer = [RootRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataSelector)];
    self.mj_footer = footer;
}

- (void)setDefaultPublicAPIs
{
    self.showRefreshDetail = NO ;
    self.automaticallyLoadMore = NO ;
    self.automaticallyLoadNew = YES ;
}

#pragma mark --
#pragma mark - Public Properties
- (void)setShowRefreshDetail:(BOOL)showRefreshDetail
{
    _showRefreshDetail = showRefreshDetail ;
    
    ((RootRefreshHeader *)self.mj_header).lastUpdatedTimeLabel.hidden = !self.showRefreshDetail;
    ((RootRefreshHeader *)self.mj_header).stateLabel.hidden = !self.showRefreshDetail ;
    ((RootRefreshFooter *)self.mj_footer).stateLabel.hidden = !self.showRefreshDetail ;
}

- (void)setAutomaticallyLoadMore:(BOOL)automaticallyLoadMore
{
    _automaticallyLoadMore = automaticallyLoadMore ;
    
    if (_automaticallyLoadMore)
    {
        self.mj_footer = nil ;
        MJRefreshAutoFooter *autofooter = [MJRefreshAutoFooter footerWithRefreshingTarget:self
                                                                         refreshingAction:@selector(loadMoreDataSelector)] ;
        autofooter.triggerAutomaticallyRefreshPercent = 0.55 ;
        self.mj_footer = autofooter;
    }
}

- (void)setAutomaticallyLoadNew:(BOOL)automaticallyLoadNew
{
    _automaticallyLoadNew = automaticallyLoadNew ;
    
    if (_automaticallyLoadNew) {
        [self.mj_header beginRefreshing] ;
    } else {
        [self.mj_header endRefreshing] ;
    }
}


#pragma mark --
#pragma mark - loading methods

- (void)loadNewDataSelector
{
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(loadNew:)]) {
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
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(loadMore:)])
    {
        [self.mj_footer endRefreshing] ;
        return ;
    }
    
    // do request
    __weak RootTableView *weakSelf = self ;
    if (_automaticallyLoadMore)
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
