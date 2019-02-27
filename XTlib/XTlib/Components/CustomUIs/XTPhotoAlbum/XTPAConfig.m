//
//  XTPAConfig.m
//  XTlib
//
//  Created by teason23 on 2019/2/26.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTPAConfig.h"


@implementation XTPAConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _albumColumnCount      = 4;
        _albumSelectedMaxCount = 5;
        _albumItemFlex         = 4.f;
        _tintColor             = [UIColor darkGrayColor];
    }
    return self;
}

- (BOOL)isSingleChoosenMode {
    return self.albumSelectedMaxCount == 1;
}


@end
