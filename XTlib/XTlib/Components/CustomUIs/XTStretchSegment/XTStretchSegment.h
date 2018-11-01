//
//  XTStretchSegment.h
//  XTMultipleTables
//
//  Created by TuTu on 15/12/11.
//  Copyright © 2015年 teason. All rights reserved.
//
#define APPFRAME [UIScreen mainScreen].bounds

#import <UIKit/UIKit.h>

@protocol XTStretchSegmentDelegate <NSObject>

- (void)xtStretchSegmentMoveToTheIndex:(NSInteger)index dataItem:(id)item;

@end

typedef enum : NSUInteger {
    TypeBaseLine, //  default .
    TypeZoomTitle,
} DisplayType_XTStretchSegment;


@interface XTStretchSegment : UIScrollView

@property (nonatomic, weak) id<XTStretchSegmentDelegate> xtDelegate;
@property (nonatomic) NSInteger currentIndex;
//数据源头, 传一个以字典为单位的数组 ,形如 @[dic1 , dic2] ; dic1 {@key:name, @value:object}
@property (nonatomic, strong) NSArray *dataList;               // @[dic1 , dic2] ; dic1 {@key:name, @value:object}
@property (nonatomic, strong, readonly) NSArray *dataNameList; // dataList -> allKeys ; namelist ;

- (instancetype)initWithFrame:(CGRect)frame
                     dataList:(NSArray *)dataList;

- (instancetype)initWithFrame:(CGRect)frame
                     dataList:(NSArray *)dataList
                 overlayImage:(UIImage *)imgOverlay
                hasSpliteLine:(bool)hasSplite
                         type:(DisplayType_XTStretchSegment)type;
@end
