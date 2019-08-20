//
//  Zample4Controller.m
//  XTkit
//
//  Created by teason23 on 2017/4/28.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample4Controller.h"
#import <XTBase/XTBase.h>
#import <XTColor/UIColor+XTColors.h>

#import "XTColorCell.h"
#import "XTlib.h"


@interface Zample4Controller () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) RootTableView *table;
@property (nonatomic, strong) NSArray *list_datasource;
@end


@implementation Zample4Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"XTColorFetcher";

    self.list_datasource = @[
        [UIColor xt_red],
        [UIColor xt_sugarRed],
        [UIColor xt_facePink],
        [UIColor xt_champagne],
        [UIColor xt_bg_lightGray],
        [UIColor xt_bg_beachStorm],
        [UIColor xt_yellow]
    ];

    self.table = ({
        RootTableView *view = [[RootTableView alloc] initWithFrame:APPFRAME
                                                             style:0];
        view.delegate            = self;
        view.dataSource          = self;
        view.isShowRefreshDetail = TRUE;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        view;
    });

    [self.table registerClass:[XTColorCell class] forCellReuseIdentifier:@"XTColorCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 99;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XTColorCell *cell = [XTColorCell cellWithTable:tableView];
    [cell configure:self.list_datasource[indexPath.row % self.list_datasource.count]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [XTColorCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
