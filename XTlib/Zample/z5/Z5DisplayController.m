//
//  Z5DisplayController.m
//  XTkit
//
//  Created by teason23 on 2017/5/10.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Z5DisplayController.h"
#import "Z5DisplayCell.h"
#import "Model1.h"
#import "XTFMDB.h"

@interface Z5DisplayController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table ;
@property (nonatomic,strong) NSArray *list ;
@end

@implementation Z5DisplayController

- (void)viewDidLoad
{
    [super viewDidLoad] ;
    
    self.list = ({
        NSArray *list = [Model1 xt_selectAll] ;
        list ;
    }) ;
    
    self.table = ({
        UITableView *table = [UITableView new] ;
        [self.view addSubview:table] ;
        [table mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view) ;
        }] ;
        table ;
    }) ;
    
    [self.table registerNib:[UINib nibWithNibName:@"Z5DisplayCell" bundle:nil]
     forCellReuseIdentifier:@"Z5DisplayCell"] ;
    self.table.dataSource = self ;
    self.table.delegate = self ;
}



#pragma mark - UITableViewDataSource UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Z5DisplayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Z5DisplayCell"] ;
    [cell configure:self.list[indexPath.row]] ;
    return cell ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125. ;
}



@end
