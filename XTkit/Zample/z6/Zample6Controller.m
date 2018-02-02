//
//  Zample6Controller.m
//  XTkit
//
//  Created by teason23 on 2017/5/3.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample6Controller.h"
#import "Movie.h"
#import "Rating.h"
#import "Images.h"
#import "MovieCell.h"

@interface Zample6Controller () <UITableViewDelegate,UITableViewDataSource,RootTableViewDelegate>

@property (nonatomic,strong) RootTableView *table ;
@property (nonatomic,strong) NSArray *list_datasource ;

@end

@implementation Zample6Controller

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    
    self.title = @"cache request response" ;
    
    self.list_datasource = @[] ;
    
    self.table = ({
        RootTableView *view = [[RootTableView alloc] initWithFrame:APPFRAME
                                                             style:0] ;
        view.delegate           = self  ;
        view.dataSource         = self  ;
        view.xt_Delegate        = self  ;
        view.isShowRefreshDetail  = TRUE  ;
        [self.view addSubview:view] ;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view) ;
        }] ;
        view ;
    }) ;
    
    [self.table registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil]
     forCellReuseIdentifier:@"MovieCell"] ;
    [self.table loadNewInfoInBackGround:TRUE] ;
}


static const NSInteger kEveryCount = 10 ;

#pragma mark - RootTableViewDelegate

- (void)tableView:(RootTableView *)table loadNew:(void (^)(void))endRefresh
{
    [ServerRequest zample6_GetMovieListWithStart:0
                                           count:kEveryCount
                                      completion:^XTReqSaveJudgment(id json) {
                                          NSArray *tmplist = [NSArray yy_modelArrayWithClass:[Movie class] json:json[@"subjects"]] ;
                                          if (!tmplist) return XTReqSaveJudgment_NotSave ;
                                          self.list_datasource = tmplist ;
                                          endRefresh() ;
                                          return XTReqSaveJudgment_willSave ;
                                      }] ;
}

- (void)tableView:(RootTableView *)table loadMore:(void (^)(void))endRefresh
{
    [ServerRequest zample6_GetMovieListWithStart:self.list_datasource.count
                                           count:kEveryCount
                                      completion:^XTReqSaveJudgment(id json) {
                                          NSArray *tmplist = [NSArray yy_modelArrayWithClass:[Movie class] json:json[@"subjects"]] ;
                                          if (!tmplist) return XTReqSaveJudgment_NotSave ;
                                          NSMutableArray *list = [self.list_datasource mutableCopy] ;
                                          self.list_datasource = [list arrayByAddingObjectsFromArray:tmplist] ;
                                          endRefresh() ;
                                          return XTReqSaveJudgment_willSave ;
                                      }] ;
}


#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list_datasource.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"] ;
    [cell configure:self.list_datasource[indexPath.row]] ;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MovieCell cellHeight] ;
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
