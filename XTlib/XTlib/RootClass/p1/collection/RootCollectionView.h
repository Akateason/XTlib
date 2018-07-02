//
//  RootCollectionView.h
//  XTkit
//
//  Created by xtc on 2018/2/7.
//  Copyright © 2018年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@class RootCollectionView ;

@protocol RootCollectionViewDelegate <NSObject>
@required
- (void)collectionView:(RootCollectionView *)collection loadNew:(void(^)(void))endRefresh   ;
@optional
- (void)collectionView:(RootCollectionView *)collection loadMore:(void(^)(void))endRefresh  ;
@end

typedef enum : NSUInteger {
    XTRefreshType_default ,
    XTRefreshType_gifImages
} XTRefreshType ;


@interface RootCollectionView : UICollectionView
// refresh delegate
@property (nonatomic,weak) id <RootCollectionViewDelegate> xt_Delegate ;
/**
 REFRESH STYLE:
 DEFAULT IS `NO`  -> ONLY GIF IMAGES , SHOW WORDS WHEN IT BECOMES `YES`
 */
@property (nonatomic) IBInspectable BOOL isShowRefreshDetail ;
/**
 is auto LOAD MORE:
 DEFAULT IS `NO`  -> MANUALLY LOADING . AUTOMATICALLY LOAD WHEN IT BECOMES `YES`
 */
@property (nonatomic) IBInspectable BOOL isAutomaticallyLoadMore ;
// MJRefresh type
@property (nonatomic) XTRefreshType refreshType ;
/**
 PULL DOWN HEADER
 */
- (void)loadNewInfo ;
/**
 PULL DOWN HEADER
 @param isBackGround    pull header in backgound or not .
 */
- (void)loadNewInfoInBackGround:(BOOL)isBackGround ;
/**
 prepareStyle
 u can rewrite in subclass if needed
 */
- (void)prepareStyle ;
/**
 endRefresh header and footer if needed .
 */
- (void)endHeaderAndFooterRefresh ;
/**
 get current IndexPath in center .
 */
- (NSIndexPath *)currentIndexPath ;

@end
