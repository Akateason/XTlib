//
//  XTDrawerFlowLayout.m
//  xtcPwd
//
//  Created by xtc on 2018/2/2.
//  Copyright © 2018年 teason. All rights reserved.
//

#import "XTDrawerFlowLayout.h"


@implementation XTDrawerFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *oldItems        = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allItems = [[NSMutableArray alloc] initWithArray:oldItems copyItems:YES];

    __block UICollectionViewLayoutAttributes *headerAttributes = nil;

    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;

        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            headerAttributes = attributes;
        }
        else {
            [self updateCellAttributes:attributes withSectionHeader:headerAttributes];
        }
    }];

    return allItems;
}

- (void)updateCellAttributes:(UICollectionViewLayoutAttributes *)attributes
           withSectionHeader:(UICollectionViewLayoutAttributes *)headerAttributes {
    CGFloat minY   = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
    CGFloat maxY   = attributes.frame.origin.y - CGRectGetHeight(headerAttributes.bounds);
    CGFloat finalY = MAX(minY, maxY);

    CGPoint origin = attributes.frame.origin;
    CGFloat deltaY = (finalY - origin.y) / CGRectGetHeight(attributes.frame);

    if (self.firstItemTransform) {
        attributes.transform = CGAffineTransformMakeScale((1 - deltaY * self.firstItemTransform),
                                                          (1 - deltaY * self.firstItemTransform));
    }

    origin.y          = finalY;
    attributes.frame  = (CGRect){origin, attributes.frame.size};
    attributes.center = CGPointMake(self.collectionView.frame.size.width / 2., attributes.center.y);
    attributes.zIndex = attributes.indexPath.row;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

/**
 * 这个方法的返回值，就决定了collectionView停止滚动时的偏移量
 
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size     = self.collectionView.frame.size;

    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];

    // 计算collectionView最中心点的x值
    CGFloat centerY = proposedContentOffset.y + self.collectionView.frame.size.height * 0.5;

    // 存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.y - centerY)) {
            minDelta = attrs.center.y - centerY;
        }
    }

    // 修改原有的偏移量
    proposedContentOffset.y += minDelta;
    return proposedContentOffset;
}

@end
