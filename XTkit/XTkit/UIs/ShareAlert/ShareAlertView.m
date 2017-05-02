//
//  ShareAlertView.m
//  SuBaoJiang
//
//  Created by apple on 15/7/13.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "ShareAlertView.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "ShareCollectionCell.h"
#import "ScreenHeader.h"


#define COLUMN_NUMBER   3
#define COLUMN_FLEX     0.0

@interface ShareAlertView () <CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,weak) IBOutlet UICollectionView *collectionView ;
@property (nonatomic,weak) IBOutlet UIButton *btCancel ;
@property (nonatomic,weak) IBOutlet UILabel *titleLabel ;
@end

@implementation ShareAlertView

- (IBAction)cancelAction:(id)sender
{
    [self.delegate cancel] ;
}

- (void)awakeFromNib
{
    [self setupCollection] ;
    [self setupUIs] ;
}

- (void)setupUIs
{
//    _btCancel.backgroundColor = [UIColor xt_mainColor] ;
    _btCancel.layer.cornerRadius = 4.0f ;
}

- (void)setupCollection
{
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = COLUMN_NUMBER ;
    layout.sectionInset = UIEdgeInsetsMake(COLUMN_FLEX, COLUMN_FLEX , COLUMN_FLEX, COLUMN_FLEX ) ;
    layout.headerHeight = COLUMN_FLEX ;
    layout.footerHeight = COLUMN_FLEX ;
    layout.minimumColumnSpacing = COLUMN_FLEX ;
    layout.minimumInteritemSpacing = COLUMN_FLEX ;
    
    
    UINib *nib = [UINib nibWithNibName:@"ShareCollectionCell" bundle: [NSBundle mainBundle]];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"ShareCollectionCell"];
    
    _collectionView.delegate = self ;
    _collectionView.dataSource = self ;
    _collectionView.scrollEnabled = YES ;
    _collectionView.backgroundColor = [UIColor whiteColor] ;

}


#pragma mark --
#pragma mark - collection dataSourse
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1 ;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3 ;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Set up the reuse identifier
    ShareCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"ShareCollectionCell" forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
        {
            cell.lb.text = @"新浪微博" ;
            cell.img.image = [UIImage imageNamed:@"share_weibo"] ;
        }
            break;
        case 1:
        {
            cell.lb.text = @"微信" ;
            cell.img.image = [UIImage imageNamed:@"share_weixin"] ;
        }
            break;
        case 2:
        {
            cell.lb.text = @"朋友圈" ;
            cell.img.image = [UIImage imageNamed:@"share_friend"] ;
        }
            break;
        default:
            break;
    }
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = ( APPFRAME.size.width - 16 - COLUMN_FLEX * (COLUMN_NUMBER + 1) ) / COLUMN_NUMBER ;
    return CGSizeMake(width, 105) ;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"row : %d",indexPath.row) ;
    [self.delegate clickCollectionIndex:indexPath.row] ;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
