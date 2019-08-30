//
//  XTStretchSegment.h
//  XTMultipleTables
//
//  Created by teason on 15/12/11.
//  Copyright © 2015年 teason. All rights reserved.
// UICollectionView 子类. 今日头条头部segmentBar.

#import <XTBase/XTBase.h>

@class XTStretchSegment;

@protocol XTStretchSegmentDataSource <NSObject>
@required
- (NSInteger)stretchSegment_CountsOfDatasource;
- (NSString *)stretchSegment:(XTStretchSegment *)segment titleOfDataAtIndex:(NSInteger)index;
@end

@protocol XTStretchSegmentDelegate <NSObject>
@required
- (void)stretchSegment:(XTStretchSegment *)segment didSelectedIdx:(NSInteger)idx;
@optional
- (UIView *)overlayView;
@end


@interface XTStretchSegment : UICollectionView

// UI delegate .
@property (nonatomic, weak) id<XTStretchSegmentDelegate> xtSSDelegate;
// UI datasource .
@property (nonatomic, weak) id<XTStretchSegmentDataSource> xtSSDataSource;

@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) UIColor *titleSelectedColor;
@property (nonatomic) float bigFontSize;      // 15
@property (nonatomic) float normalFontSize;   // 10
@property (nonatomic) BOOL hasUnderLine;      // y
@property (nonatomic) float cellSpace;        // 5
@property (nonatomic) float sideMargin_left;  // 20
@property (nonatomic) float sideMargin_right; // 20

// 初始化 务必调用 2,3. 调用方式参考Demo中的SegmentVC.
//1 initialization !!!!!!
+ (instancetype)getNew;
//2 customerization
- (void)setupTitleColor:(UIColor *)titleColor
          selectedColor:(UIColor *)selectedColor
            bigFontSize:(float)bigFontSize
         normalFontSize:(float)normalFontSize
            hasUserLine:(BOOL)hasUnderLine
              cellSpace:(float)cellSpace
         sideMarginLeft:(float)sideMarginLeft
        sideMarginRight:(float)sideMarginRight;
//3 setup
- (void)setupCollections;

// Func
- (void)moveToIndex:(NSInteger)idx;
- (NSInteger)getCurrentIdx;

@end


@interface XTStretchSegmentHandler : NSObject
XT_SINGLETON_H(XTStretchSegmentHandler);
@property (nonatomic, weak) id<XTStretchSegmentDelegate> xtSSDelegate;
@end
