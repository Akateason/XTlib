//
//  XTStretchSegCell.m
//  XTlib
//
//  Created by teason23 on 2019/8/20.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTStretchSegCell.h"
#import <XTBase/XTBase.h>
#import "XTStretchSegment.h"
#import <XTTable/XTCollection.h>

@implementation XTStretchSegCell

- (void)awakeFromNib {
    [super awakeFromNib];

    UIView *ph = [[XTStretchSegmentHandler sharedInstance].xtSSDelegate overlayView];
    ph.alpha   = 0;
    [self addSubview:ph];
    [ph mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    self.phView = ph;
}

- (void)xt_configure:(id)model indexPath:(NSIndexPath *)indexPath {
    [super xt_configure:model indexPath:indexPath];
}


@end
