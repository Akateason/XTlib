//
//  XTSegment.m
//  XTSegment
//
//  Created by apple on 15/7/6.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#define TAGS_TEASEGMENT_BT 987520
#import "XTSegment.h"
#import <XTBase/XTBase.h>


@interface XTSegment ()
@property (nonatomic) int sumIndex;
@property (nonatomic) CGFloat btWidth;
@property (nonatomic, strong) UIImageView *imgSelectView;
@property (nonatomic) CGFloat wholeWid;
@end


@implementation XTSegment

#pragma mark - Initialization

- (instancetype)initWithDataList:(NSArray *)datalist
                           imgBg:(UIImage *)imgBg
                        imgColor:(UIColor *)imgColor
                          height:(CGFloat)height
                     normalColor:(UIColor *)normalColor
                     selectColor:(UIColor *)selectColor
                            font:(UIFont *)font {
    return [self initWithDataList:datalist imgBg:imgBg imgColor:imgColor size:CGSizeMake(APP_WIDTH, height) normalColor:normalColor selectColor:selectColor font:font];
}

- (instancetype)initWithDataList:(NSArray *)datalist
                           imgBg:(UIImage *)imgBg
                        imgColor:(UIColor *)imgColor
                            size:(CGSize)size
                     normalColor:(UIColor *)normalColor
                     selectColor:(UIColor *)selectColor
                            font:(UIFont *)font {
    self = [super init];
    if (self) {
        [self setupWithDataList:datalist imgBg:imgBg imgColor:imgColor size:size normalColor:normalColor selectColor:selectColor font:font];
    }
    return self;
}

- (void)setupWithDataList:(NSArray *)datalist
                    imgBg:(UIImage *)imgBg
                 imgColor:(UIColor *)imgColor
                     size:(CGSize)size
              normalColor:(UIColor *)normalColor
              selectColor:(UIColor *)selectColor
                     font:(UIFont *)font {
    self.heightForSeg = size.height;
    self.wholeWid     = size.width;

    self.dataList     = datalist;
    imgBg             = imgBg ?: [UIImage imageNamed:@"btBase" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
    imgBg             = [imgBg imageWithTintColor:imgColor ?: selectColor];
    self.imgBG_sel    = imgBg;
    self.normalColor  = normalColor;
    self.selectColor  = selectColor;
    self.currentIndex = 0;
    self.font         = font;

    [self setup];
}

#pragma mark - Properties

- (void)setDataList:(NSArray *)dataList {
    _dataList = dataList;

    self.sumIndex = (int)[dataList count];
}

- (void)setSumIndex:(int)sumIndex {
    _sumIndex = sumIndex;

    self.btWidth = self.wholeWid / sumIndex;
}

- (void)setImgBG_sel:(UIImage *)imgBG_sel {
    _imgBG_sel = imgBG_sel;

    self.imgSelectView.image = imgBG_sel;
}

- (UIImageView *)imgSelectView {
    if (!_imgSelectView) {
        CGRect imgFrame = CGRectZero;
        imgFrame.size   = CGSizeMake(self.btWidth, self.heightForSeg);
        _imgSelectView  = [[UIImageView alloc] initWithFrame:imgFrame];
        if (![_imgSelectView superview]) {
            [self addSubview:_imgSelectView];
        }
    }

    return _imgSelectView;
}

- (CGFloat)wholeWid {
    if (!_wholeWid) {
        _wholeWid = APP_WIDTH;
    }
    return _wholeWid;
}

#pragma mark - Setup

- (void)setup {
    // h
    CGRect myFrame      = self.frame;
    myFrame.size.height = self.heightForSeg;
    // bt
    for (int i = 0; i < self.sumIndex; i++) {
        UIButton *bt = [[UIButton alloc] init];
        bt.tag       = TAGS_TEASEGMENT_BT + i;
        [bt setTitle:self.dataList[i] forState:UIControlStateNormal];
        [bt setTitle:self.dataList[i] forState:UIControlStateSelected];
        [bt setTitleColor:self.normalColor forState:UIControlStateNormal];
        [bt setTitleColor:self.selectColor forState:UIControlStateSelected];
        bt.titleLabel.font = self.font;
        [bt addTarget:self action:@selector(btSelectedAction:) forControlEvents:UIControlEventTouchUpInside];

        CGRect btFrame = CGRectZero;
        btFrame.size   = CGSizeMake(self.btWidth, self.heightForSeg);
        btFrame.origin = CGPointMake(self.btWidth * (i), 0);
        bt.frame       = btFrame;

        [self addSubview:bt];
    }
    // bg img
    [self imgSelectView];
    // select
    [self changeButtonSelectInfo];
}

- (void)changeButtonSelectInfo {
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *bt              = (UIButton *)subview;
            bt.selected               = NO;
            bt.userInteractionEnabled = YES;
            if (bt.tag - TAGS_TEASEGMENT_BT == self.currentIndex) {
                bt.selected               = YES;
                bt.userInteractionEnabled = NO;
            }
        }
    }
}

#pragma mark - Action

- (void)btSelectedAction:(id)sender {
    UIButton *bt      = sender;
    int indexSelected = (int)(bt.tag - TAGS_TEASEGMENT_BT);

    [self moveToIndex:indexSelected callBack:YES];
}

#pragma mark - Public

- (void)moveToIndex:(int)index
           callBack:(BOOL)callback {
    self.currentIndex = index;

    if (callback) {
        if ([self.delegate respondsToSelector:@selector(clickSegmentWith:)]) {
            [self.delegate clickSegmentWith:index];
        }
    }

    [self changeButtonSelectInfo];

    [UIView animateWithDuration:0.35 animations:^{
        CGRect rect          = _imgSelectView.frame;
        rect.origin.x        = self.btWidth * index;
        _imgSelectView.frame = rect;
    }];
}

@end
