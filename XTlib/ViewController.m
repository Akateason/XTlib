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
#import "ScreenHeader.h"
#import "UIViewController+XTAddition.h"
#import "XTSIAlertView.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet RootTableView *table ;
@property (strong,nonatomic) NSArray *dataSource ;
@property (strong,nonatomic) NSArray *sectionKeys ;
@end

@implementation ViewController

#pragma mark -

- (void)actionSheet {
    XTSIAlertView *alert = [[XTSIAlertView alloc] initWithTitle:@"title" andMessage:@"subTitle"] ;
    [alert addButtonWithTitle:@"this is normal"
                         type:XTSIAlertViewButtonTypeDefault
                      handler:nil] ;
    [alert addButtonWithTitle:@"Destructive"
                         type:XTSIAlertViewButtonTypeDestructive
                      handler:nil] ;
    [alert addButtonWithTitle:@"cancel"
                         type:XTSIAlertViewButtonTypeCancel
                      handler:nil] ;
    [alert show] ;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad] ;
    // Do any additional setup after loading the view, typically from a nib.
    self.table.dataSource   = self ;
    self.table.delegate     = self ;
    self.dataSource = ({
        NSArray *list = [PlistUtil arrayWithPlist:@"viewControllers"] ;
        list ;
    }) ;
    self.sectionKeys = ({
        NSMutableArray *tmplist = [@[] mutableCopy] ;
        [_dataSource enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL * _Nonnull stop) {
            [tmplist addObject:[[dic allKeys] firstObject]] ;
        }] ;
        tmplist ;
    }) ;
        
    
}



#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return (int)((NSArray *)(self.dataSource[section])[self.sectionKeys[section]]).count ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RootTableCell *cell = [RootTableCell cellWithTable:tableView] ;
    NSDictionary *dic = [((NSArray *)(self.dataSource[indexPath.section])[self.sectionKeys[indexPath.section]]) objectAtIndex:indexPath.row] ;
    cell.textLabel.text = dic[@"title"] ;
    return cell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [(NSArray *)(self.dataSource[indexPath.section])[self.sectionKeys[indexPath.section]] objectAtIndex:indexPath.row] ;
    NSString *clsName = dic[@"cname"] ;
    Class ctrllerCls = objc_getRequiredClass([clsName UTF8String]) ;
    UIViewController *ctrller ;
    if ([dic[@"isStory"] boolValue] == YES) {
        ctrller = [self.class getCtrllerFromStory:@"Main" controllerIdentifier:clsName] ;
    }
    else {
        ctrller = [[ctrllerCls alloc] init] ;
    }
    ctrller.title = dic[@"title"] ;
    [self.navigationController pushViewController:ctrller animated:YES] ;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *head = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"head"] ;
    if (!head) {
        head = [[UITableViewHeaderFooterView alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, 44)] ;
    }
    head.textLabel.text = self.sectionKeys[section] ;
    return head ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44 ;
}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
