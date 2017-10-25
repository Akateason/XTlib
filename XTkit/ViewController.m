//
//  ViewController.m
//  XTkit
//
//  Created by teason on 2017/4/6.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "ViewController.h"
#import "RootTableView.h"
#import "RootTableCell.h"
#import "PlistUtil.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table ;
@property (strong,nonatomic) NSArray *names ;
@end

@implementation ViewController

#pragma mark -
- (void)viewDidLoad
{
    [super viewDidLoad] ;
    // Do any additional setup after loading the view, typically from a nib.
    self.table.dataSource   = self ;
    self.table.delegate     = self ;
    self.names = ({
        NSArray *list = [PlistUtil arrayWithPlist:@"viewControllers"] ;
        list ;
    }) ;
}



#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.names.count ; //
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootTableCell *cell = [RootTableCell cellWithTable:tableView] ;
    cell.textLabel.text = self.names[indexPath.row] ;
    // [NSString stringWithFormat:@"Zample%ld",indexPath.row + 1] ;
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *clsName = [NSString stringWithFormat:@"Zample%dController",(int)indexPath.row + 1] ;
    Class ctrllerCls = objc_getRequiredClass([clsName UTF8String]) ;
    UIViewController *ctrller = [[ctrllerCls alloc] init] ;
    ctrller.title = clsName ;
    [self.navigationController pushViewController:ctrller animated:YES] ;
}













- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
