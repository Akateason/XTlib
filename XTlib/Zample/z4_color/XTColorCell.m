//
//  XTColorCell.m
//  XTkit
//
//  Created by teason23 on 2017/10/24.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTColorCell.h"


@implementation XTColorCell

- (void)configure:(UIColor *)model {
    self.backgroundColor = model;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
