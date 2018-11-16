//
//  Zample3Controller.m
//  XTkit
//
//  Created by teason on 2017/4/21.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample3Controller.h"
#import "Movie.h"
#import "Rating.h"
#import "Images.h"
#import "MovieCell.h"
#import "MyWebController.h"
#import "XTlib.h"
#import "ServerRequest.h"
#import <XTBase/MyWebController.h>

static const NSInteger kEveryCount = 10;


@interface Zample3Controller () <UITableViewDelegate, UITableViewDataSource, UITableViewXTReloaderDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSArray *list_datasource;
@end


@implementation Zample3Controller

#pragma mark -
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"cell from NIB";

    self.list_datasource = @[];

    self.table = ({
        UITableView *view = [[RootTableView alloc] initWithFrame:self.view.bounds
                                                           style:0];
        view.delegate               = self;
        view.dataSource             = self;
        view.xt_Delegate            = self;
        view.xt_isShowRefreshDetail = TRUE;
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        view;
    });

    [MovieCell registerNibFromTable:self.table];
    [self.table xt_loadNewInfoInBackGround:TRUE];
}


#pragma mark - RootTableViewDelegate
- (void)tableView:(RootTableView *)table loadNew:(void (^)(void))endRefresh {
    [ServerRequest zample3_GetMovieListWithStart:0
        count:kEveryCount
        success:^(id json) {

            NSArray *tmplist     = [NSArray yy_modelArrayWithClass:[Movie class] json:json[@"subjects"]];
            self.list_datasource = tmplist;

            endRefresh();
        }
        fail:^{
            endRefresh();
        }];
}

- (void)tableView:(RootTableView *)table loadMore:(void (^)(void))endRefresh {
    [ServerRequest zample3_GetMovieListWithStart:self.list_datasource.count
        count:kEveryCount
        success:^(id json) {

            NSArray *tmplist     = [NSArray yy_modelArrayWithClass:[Movie class] json:json[@"subjects"]];
            NSMutableArray *list = [self.list_datasource mutableCopy];
            self.list_datasource = [list arrayByAddingObjectsFromArray:tmplist];

            if (endRefresh) endRefresh();

        }
        fail:^{
            if (endRefresh) endRefresh();
        }];
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.list_datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [MovieCell fetchFromTable:tableView indexPath:indexPath];
    [cell configure:self.list_datasource[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [MovieCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Movie *movie             = self.list_datasource[indexPath.row];
    MyWebController *ctrller = [[MyWebController alloc] init];
    ctrller.url              = [NSURL URLWithString:movie.alt];
    ctrller.title            = movie.title;
    [self.navigationController pushViewController:ctrller animated:YES];
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
