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
#import "NSDate+XTTick.h"
#import "NSObject+Reflection.h"
#import "UIImage+AddFunction.h"

#import "Z5DisplayController.h"

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
    
    UIImage *testImage = [UIImage imageNamed:@"kobe"] ;
    NSData *dataImage = UIImagePNGRepresentation(testImage) ;
    UIImage *imgDis = [UIImage imageWithData:dataImage] ;
    
    NSString *str = [dataImage base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] ;
    UIImage *imgDis2 = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:str
                                                                                    options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    
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
    [Model1 xt_createTable] ;
}

- (void)selectAction
{
    NSLog(@"%s",__func__) ;
    NSArray *list = [Model1 xt_selectAll] ;
    for (Model1 *model in list) {
        NSLog(@"%d",model.pkid) ;
    }
    
    [self display] ;

}

- (void)selectWhereAction
{
    NSLog(@"%s",__func__) ;
    NSArray *list = [Model1 xt_selectWhere:@"title = 'jk4j3j43' "] ;
    NSLog(@"list : %@ \ncount:%@",list,@(list.count)) ;
}

- (void)insertAction
{
    NSLog(@"%s",__func__) ;
    Model1 *m1 = [Model1 new] ; // 不需设置主键
    m1.age = arc4random() % 100 ;
    m1.floatVal = 3232.89f ;
    m1.tick = [NSDate xt_getTickFromNow] ;
    m1.title = @"jk4j3j43" ;
    UIImage *image = [UIImage imageNamed:@"kobe"] ;
    image = [UIImage thumbnailWithImage:image size:CGSizeMake(100, 100)] ;
    m1.cover = UIImagePNGRepresentation(image) ;
    [m1 xt_insert] ;
    
    
    [self display] ;
}

- (void)updateAction
{
    Model1 *m1 = [Model1 new] ; // 不需设置主键
    m1.pkid = ((Model1 *)[[Model1 xt_selectAll] lastObject]).pkid ;
    m1.age = 4444444 ;
    m1.floatVal = 44.4444 ;
    m1.tick = [NSDate xt_getTickFromNow] ;
    m1.title = [NSString stringWithFormat:@"我就改你 r%d",arc4random()%99] ;
    
    [m1 xt_update] ;
    
    [self display] ;
}

- (void)deleteAction
{
    Model1 *lastModel = [[Model1 xt_selectAll] lastObject] ;
    [Model1 xt_deleteModelWhere:[NSString stringWithFormat:@"title = '%@'",lastModel.title]] ;
    
    [self display] ;
}

- (void)dropAction
{
    [Model1 xt_dropTable] ;
    
    [self display] ;
}

- (void)insertListAction
{
    NSMutableArray *list = [@[] mutableCopy] ;
    for (int i = 0 ; i < 10; i++)
    {
        Model1 *m1 = [Model1 new] ; // 插入不需设置主键
        m1.age = i + 1 ;
        m1.floatVal = i + 0.3 ;
        m1.tick = [NSDate xt_getTickFromNow] ;
        m1.title = [NSString stringWithFormat:@"title%d",i] ;
        
        [list addObject:m1] ;
    }
    
    [Model1 xt_insertList:list] ;
    
    
    [self display] ;
}

- (void)updateListAction
{
    NSArray *getlist = [Model1 xt_selectWhere:@"age > 5"] ;
    NSMutableArray *tmplist = [@[] mutableCopy] ;
    for (int i = 0 ; i < getlist.count ; i++)
    {
        Model1 *model = getlist[i] ;
        model.title = [model.title stringByAppendingString:[NSString stringWithFormat:@"+%d",model.age]] ;
        [tmplist addObject:model] ;
    }
    
    [Model1 xt_updateList:tmplist] ;
    
    [self display] ;
}

- (void)findFirstAction
{
    Model1 *model = [Model1 xt_findFirstWhere:@"pkid == 2"] ;
    NSLog(@"m : %@",[XTJson getJsonWithModel:model]) ;
}




#pragma mark --
- (void)display
{
    [self.navigationController pushViewController:[Z5DisplayController new]
                                         animated:YES] ;
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
