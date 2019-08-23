//
//  XTStretchSegment.m
//  XTMultipleTables
//
//  Created by teason on 15/12/11.
//  Copyright © 2015年 teason. All rights reserved.
//

#import "XTStretchSegment.h"
#import "XTStretchSegCell.h"


static const float kOverlayAnimationDuration = .4f;


@interface XTStretchSegment () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic) NSInteger currentIndex;
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
         sideMarginLeft:(float)sideMarginLeft
        sideMarginRight:(float)sideMarginRight {
    self.titleColor         = titleColor;
    self.titleSelectedColor = selectedColor;
    self.bigFontSize        = bigFontSize;
    self.normalFontSize     = normalFontSize;
    self.hasUnderLine       = hasUnderLine;
    self.lineSpace          = linespace;
    self.sideMargin_left    = sideMarginLeft;
    self.sideMargin_right   = sideMarginRight;
}

- (void)setupCollections {
    [XTStretchSegCell xt_registerNibFromCollection:self];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing          = self.lineSpace;
    layout.sectionInset                = UIEdgeInsetsMake(0, self.sideMargin_left, 0, self.sideMargin_right);
    self.collectionViewLayout          = layout;
    self.dataSource                    = self;
    self.delegate                      = self;

    _currentIndex                       = 0;
    self.showsHorizontalScrollIndicator = NO;
    self.backgroundColor                = [UIColor clearColor];
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

- (float)sideMargin_left {
    if (!_sideMargin_left) {
        _sideMargin_left = 20.;
    }
    return _sideMargin_left;
}

- (float)sideMargin_right {
    if (!_sideMargin_right) {
        _sideMargin_right = 20.;
    }
    return _sideMargin_right;
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;

    // todo animation . move overlay .
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionCenteredHorizontally) animated:NO];
        [self reloadData];
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

    if (self.hasUnderLine) {
        if (!cell.phView) {
            UIView *ph = [self.xtSSDelegate overlayView];
            [cell addSubview:ph];
            [ph mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell);
            }];
            cell.phView = ph;
        }

        if (self.currentIndex == indexPath.row) {
            cell.phView.transform = CGAffineTransformMakeScale(1.3, 1.3);
            [UIView animateWithDuration:kOverlayAnimationDuration animations:^{
                cell.phView.alpha     = 1;
                cell.phView.transform = CGAffineTransformIdentity;
            }];
        }
        else {
            cell.phView.alpha = 0;
        }
    }

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
