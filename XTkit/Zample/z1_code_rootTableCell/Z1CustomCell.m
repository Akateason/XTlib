//
//  Z1CustomCell.m
//  XTkit
//
//  Created by teason on 2017/4/20.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Z1CustomCell.h"

@interface Z1CustomCell ()
@property (nonatomic,strong) UIView *v1 ;
@property (nonatomic,strong) UIView *v2 ;
@end


@implementation Z1CustomCell

- (void)prepareUI
{
    self.v1 = ({
        UIView *view = [UIView new] ;
        view.backgroundColor = [UIColor yellowColor] ;
        [self addSubview:view] ;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20)) ;
            make.top.right.equalTo(self) ;
        }] ;
        view ;
    }) ;
    
    self.v2 = ({
        UIView *view = [UIView new] ;
        view.backgroundColor = [UIColor blueColor] ;
        [self addSubview:view] ;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@3) ;
            make.left.right.bottom.equalTo(self) ;
        }] ;
        view ;
    }) ;
}

- (void)configure:(id)model
{
    NSString *str = model ;
    
    self.textLabel.text = str ;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
