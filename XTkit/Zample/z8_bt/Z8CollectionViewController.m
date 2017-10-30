//
//  Z8CollectionViewController.m
//  XTkit
//
//  Created by teason23 on 2017/7/24.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Z8CollectionViewController.h"
#import "Z8CollectionViewCell.h"

@interface Z8CollectionViewController () <UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView ;
@end

@implementation Z8CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SVProgressHUD showInfoWithStatus:@"点到了"] ;

    self.view.backgroundColor = [UIColor whiteColor] ;
    
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init] ;
        UICollectionView *view = [[UICollectionView alloc] initWithFrame:APPFRAME
                                                    collectionViewLayout:layout] ;
        [self.view addSubview:view] ;
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view) ;
        }] ;
        view.backgroundColor = [UIColor brownColor] ;
        view.dataSource = self ;
        view.delegate = self ;
        view ;
    }) ;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"Z8CollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"Z8CollectionViewCell"] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10 ;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Z8CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Z8CollectionViewCell" forIndexPath:indexPath] ;
    return cell ;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
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
