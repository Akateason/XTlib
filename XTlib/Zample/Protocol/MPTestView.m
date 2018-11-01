//
//  MPTestView.m
//
//
//  Created by teason23 on 2018/5/15.
//

#import "MPTestView.h"
#import "XTlib.h"


@implementation MPTestView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        self.backgroundColor = [UIColor whiteColor];

        UILabel *label = [UILabel new];
        [self addSubview:label];
        _label = label;
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(20);
        }];

        UIButton *button       = [UIButton new];
        button.backgroundColor = [UIColor yellowColor];
        [self addSubview:button];
        _button = button;
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerX.equalTo(self);
            make.top.equalTo(_label.mas_bottom).offset(20);
        }];

        UITableView *tableView = [UITableView new];
        [self addSubview:tableView];
        _tableView = tableView;

        //如果您用的是AutoLayout那么您可以在这里添加布局约束的代码。如果您是通过frame来进行布局那么请在layoutSubviews中进行子视图的布局处理。
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    //如果你是通过frame来设置布局那么就可以在这里进行布局的刷新。。
}

@end
