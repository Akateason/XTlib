//
//  Zample5Controller.m
//  XTkit
//
//  Created by teason23 on 2017/4/28.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample5Controller.h"

#import <objc/runtime.h>
#import "XTFMDB.h"
#import "Model1.h"
#import "XTTickConvert.h"


@interface Zample5Controller ()

@property (strong, nonatomic) UIButton *btCreate ;
@property (strong, nonatomic) UIButton *btSelect ;
@property (strong, nonatomic) UIButton *btSelectWhere ;
@property (strong, nonatomic) UIButton *btInsert ;
@property (strong, nonatomic) UIButton *btUpdate ;
@property (strong, nonatomic) UIButton *btDelete ;
@property (strong, nonatomic) UIButton *btDrop ;
@property (strong, nonatomic) UIButton *btInsertList ;
@property (strong, nonatomic) UIButton *btUpdateList ;
@property (strong, nonatomic) UIButton *btFindFirst ;
@end

@implementation Zample5Controller




static float const kBtFlex = 5 ;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone ;
    self.title = @"XTFMDB" ;
        
    
    [self layoutUI] ;
}

- (void)layoutUI
{
    self.btCreate = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"create" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.mas_equalTo(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    self.btSelect = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"select" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.btCreate.mas_bottom).offset(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    self.btSelectWhere = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"selectWhere" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.btSelect.mas_bottom).offset(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    self.btInsert = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"insert" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.btSelectWhere.mas_bottom).offset(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    self.btUpdate = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"update" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.btInsert.mas_bottom).offset(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    self.btDelete = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"delete" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.btUpdate.mas_bottom).offset(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    self.btDrop = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"drop" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.btDelete.mas_bottom).offset(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    self.btInsertList = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"insertList" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.btDrop.mas_bottom).offset(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    self.btUpdateList = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"updateList" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.btInsertList.mas_bottom).offset(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    self.btFindFirst = ({
        UIButton *bt = [UIButton new] ;
        [bt setTitle:@"findFirst" forState:0] ;
        bt.backgroundColor = [UIColor grayColor] ;
        bt.titleLabel.textColor = [UIColor whiteColor] ;
        [bt addTarget:self action:@selector(btOnClick:) forControlEvents:UIControlEventTouchUpInside] ;
        [self.view addSubview:bt] ;
        [bt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.btUpdateList.mas_bottom).offset(kBtFlex) ;
        }] ;
        bt ;
    }) ;
    
    
}

- (void)btOnClick:(UIButton *)sender
{
    NSString *strButtonName = [sender.titleLabel.text stringByAppendingString:@"Action"] ;
    SEL methodSel = NSSelectorFromString(strButtonName) ;
    ((void (*)(id, SEL, id))objc_msgSend)(self, methodSel, nil) ;
}



#pragma mark --
#pragma mark - actions
- (void)createAction
{
    NSLog(@"%s",__func__) ;
    [[XTFMDB sharedInstance] createTable:[Model1 class]
                              primarykey:@"idModel"]    ;
}

- (void)selectAction
{
    NSLog(@"%s",__func__) ;
    NSArray *list = [[XTFMDB sharedInstance] selectAllFrom:[Model1 class]] ;
    for (Model1 *model in list) {
        NSLog(@"%d",model.idModel) ;
    }
}

- (void)selectWhereAction
{
    NSLog(@"%s",__func__) ;
    NSArray *list = [[XTFMDB sharedInstance] selectFrom:[Model1 class] where:@" WHERE title = 'jk4j3j43' "] ;
    NSLog(@"list : %@ \ncount:%@",list,@(list.count)) ;
}

- (void)insertAction
{
    NSLog(@"%s",__func__) ;
    Model1 *m1 = [Model1 new] ; // 不需设置主键
    m1.age = arc4random() % 100 ;
    m1.floatVal = 3232.89f ;
    m1.tick = [XTTickConvert getTickFromNow] ;
    m1.title = @"jk4j3j43" ;
    
    bool bInsetSuccess = [[XTFMDB sharedInstance] insert:m1] ;
}

- (void)updateAction
{
    Model1 *m1 = [Model1 new] ; // 不需设置主键
    m1.idModel = 1 ;
    m1.age = 4444444 ;
    m1.floatVal = 44.4444 ;
    m1.tick = [XTTickConvert getTickFromNow] ;
    m1.title = @"我就改你" ;
    
    BOOL bSuccess = [[XTFMDB sharedInstance] update:m1] ;
}

- (void)deleteAction
{
    BOOL b = [[XTFMDB sharedInstance] deleteFrom:@"Model1"
                                           where:@"WHERE title = '我就改你' "] ;
}

- (void)dropAction
{
    BOOL b = [[XTFMDB sharedInstance] dropTable:[Model1 class]] ;
}

- (void)insertListAction
{
    NSMutableArray *list = [@[] mutableCopy] ;
    for (int i = 0 ; i < 10; i++)
    {
        Model1 *m1 = [Model1 new] ; // 插入不需设置主键
        m1.age = i + 1 ;
        m1.floatVal = i + 0.3 ;
        m1.tick = [XTTickConvert getTickFromNow] ;
        m1.title = [NSString stringWithFormat:@"title%d",i] ;
        
        [list addObject:m1] ;
    }
    
    BOOL b = [[XTFMDB sharedInstance] insertList:list] ;
}

- (void)updateListAction
{
    NSArray *getlist = [[XTFMDB sharedInstance] selectFrom:[Model1 class] where:@"WHERE idModel >= 1 AND idModel <= 10"] ;
    NSMutableArray *tmplist = [@[] mutableCopy] ;
    for (int i = 0 ; i < 10 ; i++)
    {
        Model1 *model = getlist[i] ;
        model.title = [model.title stringByAppendingString:[NSString stringWithFormat:@"%d",model.age]] ;
        [tmplist addObject:model] ;
    }
    
    BOOL b = [[XTFMDB sharedInstance] updateList:tmplist] ;
}

- (void)findFirstAction
{
    Model1 *model = [[XTFMDB sharedInstance] findFirst:[Model1 class] where:@"WHERE idModel == 2"] ;
    NSLog(@"m : %@",[XTJson getJsonWithModel:model]) ;
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
