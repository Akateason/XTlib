//
//  XTStretchSegment.m
//  XTMultipleTables
//
//  Created by teason on 15/12/11.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTStretchSegment.h"
#import "XTStretchSegCell.h"


static const float kOverlayAnimationDuration = 0.25f;


@interface XTStretchSegment () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, strong) UIView *overlayView;
@end


@implementation XTStretchSegment

#pragma mark - Funcs
+ (instancetype)getNew {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset                = UIEdgeInsetsMake(0, 20, 0, 20);

    XTStretchSegment *seg = [[XTStretchSegment alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

    return seg;
}

- (void)moveToIndex:(NSInteger)idx {
    self.currentIndex = idx;
}
- (NSInteger)getCurrentIdx {
    return self.currentIndex;
}

- (void)setupTitleColor:(UIColor *)titleColor
          selectedColor:(UIColor *)selectedColor
            bigFontSize:(float)bigFontSize
         normalFontSize:(float)normalFontSize
            hasUserLine:(BOOL)hasUnderLine
              lineSpace:(float)linespace
             sideMargin:(float)sideMargin {
    self.titleColor         = titleColor;
    self.titleSelectedColor = selectedColor;
    self.bigFontSize        = bigFontSize;
    self.normalFontSize     = normalFontSize;
    self.hasUnderLine       = hasUnderLine;
    self.lineSpace          = linespace;
    self.sideMargin         = sideMargin;
}

- (void)setupCollections {
    [XTStretchSegCell xt_registerNibFromCollection:self];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing          = self.lineSpace;
    layout.sectionInset                = UIEdgeInsetsMake(0, self.sideMargin, 0, self.sideMargin);
    self.collectionViewLayout          = layout;
    self.dataSource                    = self;
    self.delegate                      = self;

    _currentIndex                       = 0;
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor                = [UIColor clearColor];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSIndexPath *indexPath    = [NSIndexPath indexPathForRow:0 inSection:0];
        XTStretchSegCell *fstCell = (XTStretchSegCell *)[self cellForItemAtIndexPath:indexPath];

        if (self.hasUnderLine) {
            CGPoint centerCell = [self convertPoint:fstCell.center toView:self];
            //            NSLog(@"center : %@", @(centerCell)) ;

            self.overlayView.center = centerCell;
            [self addSubview:self.overlayView];
        }
    });
}

- (void)moveOverlayUI {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.currentIndex inSection:0];
    XTStretchSegCell *cell = (XTStretchSegCell *)[self cellForItemAtIndexPath:indexPath];
    CGPoint centerCell     = [self convertPoint:cell.center toView:self];
    [UIView animateWithDuration:kOverlayAnimationDuration animations:^{
        self.overlayView.center = centerCell;
    } completion:^(BOOL finished){

    }];
}


#pragma mark - props

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor colorWithWhite:0 alpha:.8];
    }
    return _titleColor;
}

- (UIColor *)titleSelectedColor {
    if (!_titleSelectedColor) {
        _titleSelectedColor = [UIColor blackColor];
    }
    return _titleSelectedColor;
}

- (float)bigFontSize {
    if (!_bigFontSize) {
        _bigFontSize = 17.;
    }
    return _bigFontSize;
}

- (float)normalFontSize {
    if (!_normalFontSize) {
        _normalFontSize = 14.;
    }
    return _normalFontSize;
}

- (float)lineSpace {
    if (!_lineSpace) {
        _lineSpace = 5.;
    }
    return _lineSpace;
}

- (float)sideMargin {
    if (!_sideMargin) {
        _sideMargin = 20.;
    }
    return _sideMargin;
}

- (UIView *)overlayView {
    if (!_overlayView) {
        _overlayView = [self.xtSSDelegate overlayView];
    }
    return _overlayView;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;

    // todo animation . move overlay .
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:YES];
        [self reloadData];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            if (self.hasUnderLine) {
                XTStretchSegCell *cell = (XTStretchSegCell *)[self cellForItemAtIndexPath:indexPath];
                CGPoint centerCell     = [self convertPoint:cell.center toView:self];
                //                NSLog(@"center : %@", @(centerCell)) ;
                [UIView animateWithDuration:kOverlayAnimationDuration animations:^{
                    self.overlayView.center = centerCell;
                } completion:^(BOOL finished){

                }];
            }

        });

    });

    [self.xtSSDelegate stretchSegment:self didSelectedIdx:currentIndex];
}


#pragma mark - UICollectionViewDataSource <NSObject>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.xtSSDataSource stretchSegment_CountsOfDatasource];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XTStretchSegCell *cell = [XTStretchSegCell xt_fetchFromCollection:collectionView indexPath:indexPath];
    cell.lbTitle.text      = [self.xtSSDataSource stretchSegment:self titleOfDataAtIndex:indexPath.row];
    cell.lbTitle.font      = self.currentIndex == indexPath.row ? [UIFont systemFontOfSize:self.bigFontSize] : [UIFont systemFontOfSize:self.normalFontSize];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndex = indexPath.row;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([self getButtonWidth:[self.xtSSDataSource stretchSegment:self titleOfDataAtIndex:indexPath.row] font:(self.currentIndex == indexPath.row) ?
                                                                                                                          [UIFont systemFontOfSize:self.bigFontSize] :
                                                                                                                          [UIFont systemFontOfSize:self.normalFontSize]],
                      self.bounds.size.height);
}

- (CGSize)topButtonMaxSize {
    return CGSizeMake(1000, 60);
}
- (CGFloat)getButtonWidth:(NSString *)nameString font:(UIFont *)font {
    CGFloat wid = [nameString boundingRectWithSize:[self topButtonMaxSize]
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{ NSFontAttributeName : font }
                                           context:nil]
                      .size.width;
    return wid;
}

@end
