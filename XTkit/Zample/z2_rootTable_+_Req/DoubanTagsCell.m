//
//  DoubanTagsCell.m
//  XTkit
//
//  Created by teason on 2017/4/21.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "DoubanTagsCell.h"
#import "DoubanTags.h"


@interface DoubanTagsCell ()
@property (nonatomic,strong) UILabel *labelCount    ;
@property (nonatomic,strong) UILabel *labelName     ;
@property (nonatomic,strong) UILabel *labelTitle    ;
@property (nonatomic,strong) UIView  *baseLine      ;
@end

@implementation DoubanTagsCell

#pragma mark - rewrite in sub cls
// UI and Layout
- (void)prepareUI
{
    [super prepareUI] ;
    
    self.labelTitle = ({
        UILabel *label = [UILabel new] ;
        label.text = @"title" ;
        label.font = [UIFont systemFontOfSize:18] ;
        label.textColor = [UIColor blackColor] ;
        [self addSubview:label] ;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self).offset(5) ;
        }] ;
        label ;
    }) ;
    
    self.labelName = ({
        UILabel *label = [UILabel new] ;
        label.text = @"name" ;
        label.font = [UIFont systemFontOfSize:16] ;
        label.textColor = [UIColor redColor] ;
        [self addSubview:label] ;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self) ;
            make.left.equalTo(self.labelTitle.mas_right).offset(10) ;
        }] ;
        label ;
    }) ;
    
    self.labelCount = ({
        UILabel *label = [UILabel new] ;
        label.text = @"0" ;
        label.font = [UIFont systemFontOfSize:12] ;
        label.textColor = [UIColor yellowColor] ;
        [self addSubview:label] ;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self) ;
            make.right.equalTo(self).offset(-10) ;
        }] ;
        label ;
    }) ;
    
    self.baseLine = ({
        UIView *v = [UIView new] ;
        v.backgroundColor = [UIColor orangeColor] ;
        [self addSubview:v] ;
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self) ;
            make.height.mas_equalTo(5) ;
        }] ;
        v ;
    }) ;
    
}

// set model
- (void)configure:(DoubanTags *)model
{
    self.labelTitle.text    = model.title ;
    self.labelName.text     = model.name ;
    self.labelCount.text    = [NSString stringWithFormat:@"%ld",model.count] ;
}



// height
+ (CGFloat)cellHeight
{
    return 55.f ;
}



@end
