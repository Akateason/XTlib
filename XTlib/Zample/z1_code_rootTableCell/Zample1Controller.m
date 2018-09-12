//
//  Zample1Controller.m
//  XTkit
//
//  Created by teason on 2017/4/20.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample1Controller.h"
#import "Z1CustomCell.h"
#import "XTlib.h"

@interface Zample1Controller () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table ;
@end

@implementation Zample1Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"inherit 'RootTableCell'" ;
    
    self.table = ({
        UITableView *view = [[UITableView alloc] initWithFrame:APPFRAME style:0] ;
        view.delegate   = self ;
        view.dataSource = self ;
        [self.view addSubview:view] ;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0)) ;
        }] ;
        view ;
    }) ;
}


#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Z1CustomCell *cell = [Z1CustomCell cellWithTable:tableView] ;
    [cell configure:[NSString stringWithFormat:@"Z1 : %ld",indexPath.row + 1]] ;
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
