//
//  CenterTableView.m
//  pro
//
//  Created by TuTu on 16/8/18.
//  Copyright © 2016年 teason. All rights reserved.
//

#import "CenterTableView.h"


@interface CenterTableView ()

@end


@implementation CenterTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.separatorStyle = 0;
        //        self.backgroundColor = [UIColor clearColor] ;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.separatorStyle = 0;
        //        self.backgroundColor = [UIColor clearColor] ;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
