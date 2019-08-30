//
//  SegmentVC.m
//  XTlib
//
//  Created by teason23 on 2019/8/20.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "SegmentVC.h"
#import "XTStretchSegment.h"


@interface SegmentVC () <XTStretchSegmentDelegate, XTStretchSegmentDataSource>
@property (strong, nonatomic) XTStretchSegment *aSegment;

@property (copy, nonatomic) NSArray *datalist;

@end


@implementation SegmentVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.datalist = @[ @"1aaaaaa", @"123", @"1234132", @"change", @"爱的色放", @"撒但是上手所双射手啊啊啊", @"欧尼", @"324阿斯蒂芬路口监控了" ];

    [self.aSegment setupTitleColor:nil selectedColor:nil bigFontSize:20 normalFontSize:15 hasUserLine:YES cellSpace:20 sideMarginLeft:20 sideMarginRight:90];
    [self.aSegment setupCollections];

    self.aSegment.backgroundColor = [UIColor brownColor];
    self.aSegment.xtSSDelegate    = self;
    self.aSegment.xtSSDataSource  = self;
    [self.view addSubview:self.aSegment];
    [self.aSegment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@70);
        make.left.right.equalTo(self.view);
    }];


    UIButton *bt = [UIButton new];
    [bt setTitle:@"change" forState:0];
    [bt setTitleColor:[UIColor redColor] forState:0];
    bt.backgroundColor = [UIColor grayColor];
    [self.view addSubview:bt];
    [bt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@50);
    }];
    WEAK_SELF
        [[bt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *_Nullable x) {

            [weakSelf.aSegment moveToIndex:3];
        }];
}

- (XTStretchSegment *)aSegment {
    if (!_aSegment) {
        _aSegment = ({
            XTStretchSegment *object = [XTStretchSegment getNew];
            object;
        });
    }
    return _aSegment;
}

// @protocol XTStretchSegmentDelegate <NSObject>

- (NSInteger)stretchSegment_CountsOfDatasource {
    return self.datalist.count;
}

- (NSString *)stretchSegment:(XTStretchSegment *)segment titleOfDataAtIndex:(NSInteger)index {
    return self.datalist[index];
}

- (UIView *)overlayView {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btBase"]];
    imageView.frame        = CGRectMake(0, 0, 30, 70);
    return imageView;
}

- (void)stretchSegment:(XTStretchSegment *)segment didSelectedIdx:(NSInteger)idx {
    NSLog(@"did select : %@", @(idx));
}


@end
