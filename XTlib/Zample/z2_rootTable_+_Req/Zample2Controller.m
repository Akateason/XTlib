//
//  Zample2Controller.m
//  XTkit
//
//  Created by teason on 2017/4/20.
//  Copyright © 2017年 teason. All rights reserved.
//


#import "Zample2Controller.h"
#import "RootTableCell.h"
#import "DoubanTags.h"
#import "DoubanTagsCell.h"

#import "ServerRequest.h"
#import "XTlib.h"


@interface Zample2Controller () <UITableViewDelegate, UITableViewDataSource, RootTableViewDelegate>
@property (nonatomic, strong) RootTableView *table;
@property (nonatomic, strong) NSArray *list_datasource;
@end


@implementation Zample2Controller

#pragma mark -


#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"RootTableView and Request";

    self.list_datasource = @[];

    self.table = ({
        RootTableView *view = [[RootTableView alloc] initWithFrame:APPFRAME
                                                             style:0];
        view.delegate            = self;
        view.dataSource          = self;
        view.xt_Delegate         = self;
        view.isShowRefreshDetail = TRUE;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        view;
    });

    [self.table loadNewInfoInBackGround:TRUE];
}

#pragma mark - RootTableViewDelegate
- (void)tableView:(RootTableView *)table loadNew:(void (^)(void))endRefresh {
    [ServerRequest zample2WithSuccess:^(id json) {

        NSArray *list_response = [NSArray yy_modelArrayWithClass:[DoubanTags class] json:json[@"tags"]];
        // 获取tags属性, 有的obj可能为空
        if (!list_response || !list_response.count) {
            [SVProgressHUD showErrorWithStatus:@"这次没有tags!"];
        }
        else {
            self.list_datasource = list_response;
        }

        if (endRefresh) endRefresh();

    } fail:^{
        if (endRefresh) endRefresh();
    }];
}

- (void)tableView:(RootTableView *)table loadMore:(void (^)(void))endRefresh {
    [ServerRequest zample2WithSuccess:^(id json) {

        NSArray *list_response = [NSArray yy_modelArrayWithClass:[DoubanTags class] json:json[@"tags"]];
        if (!list_response || !list_response.count) {
            [SVProgressHUD showErrorWithStatus:@"这次没有tags!"];
        }
        else {
            NSMutableArray *list = [self.list_datasource mutableCopy];
            self.list_datasource = [list arrayByAddingObjectsFromArray:list_response];
        }

        if (endRefresh) endRefresh();

    } fail:^{
        if (endRefresh) endRefresh();
    }];
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list_datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DoubanTagsCell *cell = [DoubanTagsCell cellWithTable:tableView];
    [cell configure:self.list_datasource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [DoubanTagsCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"...");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
