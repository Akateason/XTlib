//
//  XTPhotoAlbumVC.m
//  XTlib
//
//  Created by teason23 on 2019/2/26.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "XTPhotoAlbumVC.h"
#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>
#import "XTPACameraGroupVC.h"
#import "XTPAlbumCell.h"
#import <XTBase/XTBase.h>
#import "XTPATitleView.h"


@interface XTPhotoAlbumVC () <CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, XTPACameraGroupVCDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) XTPACameraGroupVC *groupCtrller;
@property (strong, nonatomic) XTPATitleView *btTitleView;

@property (strong, nonatomic) PHImageManager *manager;
@property (strong, nonatomic) PHFetchResult *allPhotos;
@property (nonatomic, strong) NSMutableArray *choosenImageList;
@property (nonatomic) BOOL willDismiss;

@property (strong, nonatomic) XTPAConfig *configuration;
@property (copy, nonatomic) albumPickerGetImageListBlock blkGetResult;
@property (strong, nonatomic) UIBarButtonItem *commitItem;
@end


@implementation XTPhotoAlbumVC

- (instancetype)initWithConfig:(XTPAConfig *)config {
    self = [super init];
    if (self) {
        _configuration = config;
    }
    return self;
}

+ (instancetype)openAlbumWithConfig:(XTPAConfig *)configuration
                        fromCtrller:(UIViewController *)fromVC
                          getResult:(albumPickerGetImageListBlock)resultBlk {
    return [self openAlbumWithConfig:configuration fromCtrller:fromVC willDismiss:YES getResult:resultBlk];
}

+ (instancetype)openAlbumWithConfig:(XTPAConfig *)configuration
                        fromCtrller:(UIViewController *)fromVC
                        willDismiss:(BOOL)willDismiss
                          getResult:(albumPickerGetImageListBlock)resultBlk {
    XTPhotoAlbumVC *albumVC       = [[XTPhotoAlbumVC alloc] initWithConfig:configuration];
    albumVC.willDismiss           = willDismiss;
    albumVC.blkGetResult          = resultBlk;
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:albumVC];
    [fromVC presentViewController:navVC animated:YES completion:nil];
    return albumVC;
}

- (void)exportResult {
    if (self.configuration.albumSelectedMaxCount > 20) [SVProgressHUD show];

    // result assets
    NSMutableArray *resultAssets = [@[] mutableCopy];
    for (NSNumber *number in self.choosenImageList) {
        PHAsset *photoAsset = self.allPhotos[[number intValue]];
        [resultAssets addObject:photoAsset];
    }

    // result images
    NSMutableArray *images         = [NSMutableArray arrayWithCapacity:[resultAssets count]];
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode             = PHImageRequestOptionsResizeModeFast;
    options.synchronous            = YES;
    for (PHAsset *asset in resultAssets) {
        [self.manager requestImageForAsset:asset
                                targetSize:PHImageManagerMaximumSize
                               contentMode:PHImageContentModeDefault
                                   options:options
                             resultHandler:^void(UIImage *image, NSDictionary *info) {
                                 [images addObject:image];
                             }];
    }

    if (self.configuration.albumSelectedMaxCount > 20) [SVProgressHUD dismiss];

    if (self.willDismiss) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    self.blkGetResult(images, resultAssets, self);
}


#pragma mark - props

- (PHImageManager *)manager {
    if (!_manager) {
        _manager = [PHImageManager defaultManager];
    }
    return _manager;
}

- (XTPACameraGroupVC *)groupCtrller {
    if (!_groupCtrller) {
        _groupCtrller          = [[XTPACameraGroupVC alloc] initWithFrame:CGRectMake(0, 0, APP_WIDTH, APP_HEIGHT - APP_NAVIGATIONBAR_HEIGHT - APP_STATUSBAR_HEIGHT)];
        _groupCtrller.delegate = self;
    }
    return _groupCtrller;
}

- (NSMutableArray *)choosenImageList {
    if (!_choosenImageList) {
        _choosenImageList = [@[] mutableCopy];
    }
    return _choosenImageList;
}

- (XTPATitleView *)btTitleView {
    if (!_btTitleView) {
        _btTitleView = ({
            XTPATitleView *object = [[XTPATitleView alloc] init];
            [object setTitleColor:self.configuration.tintColor forState:0];
            [object addTarget:self action:@selector(btTitleOnClick) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.titleView = object;
            object;
        });
    }
    return _btTitleView;
}

- (void)btTitleOnClick {
    [self.groupCtrller cameraGroupAnimation:!self.groupCtrller.view.superview onView:self.view];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        int kCOLUMN_NUMBER = self.configuration.albumColumnCount;
        float kCOLUMN_FLEX = self.configuration.albumItemFlex;

        CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
        layout.columnCount                       = kCOLUMN_NUMBER;
        layout.sectionInset                      = UIEdgeInsetsMake(kCOLUMN_FLEX, kCOLUMN_FLEX, kCOLUMN_FLEX, kCOLUMN_FLEX);
        layout.minimumColumnSpacing              = kCOLUMN_FLEX;
        layout.minimumInteritemSpacing           = kCOLUMN_FLEX;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        UINib *nib      = [UINib nibWithNibName:identifierAlbumnCell bundle:[NSBundle bundleForClass:XTPAlbumCell.class]];
        [_collectionView registerNib:nib
            forCellWithReuseIdentifier:identifierAlbumnCell];

        _collectionView.delegate        = self;
        _collectionView.dataSource      = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        if (![_collectionView superview]) {
            [self.view addSubview:_collectionView];
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(self.view);
                make.bottom.equalTo(self.view);
            }];
        }
    }

    return _collectionView;
}

- (UIBarButtonItem *)commitItem {
    if (!_commitItem) {
        _commitItem = ({
            UIBarButtonItem *object = [[UIBarButtonItem alloc] initWithTitle:@"确定(0)"
                                                                       style:(UIBarButtonItemStylePlain)
                                                                      target:self
                                                                      action:@selector(commitOnClick)];
            object.tintColor = self.configuration.tintColor;
            object;
        });
    }
    return _commitItem;
}

- (void)commitOnClick {
    [self exportResult];
}

#pragma mark - life

- (void)cancel {
    [self dismissViewControllerAnimated:YES completion:^{
        self.blkGetResult(nil, nil, self);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancel)];

    [self collectionView];

    if (!self.configuration.isSingleChoosenMode) self.navigationItem.rightBarButtonItem = self.commitItem;

    [self.btTitleView setTitle:@"相机胶卷" forState:0];
    [self.btTitleView xt_setImagePosition:XTBtImagePositionRight spacing:6];

    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            // 用户同意授权
            [self firstLoadAllPhotos];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
        else {
            // 用户拒绝授权
        }
    }];

    [self firstLoadAllPhotos];
}

- (void)firstLoadAllPhotos {
    if (self.allPhotos.count) return;

    PHFetchOptions *allPhotosOptions = [[PHFetchOptions alloc] init];
    // 只取图片
    allPhotosOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType == %d", PHAssetMediaTypeImage];
    // 按时间排序
    allPhotosOptions.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO] ];
    // 获取图片
    PHFetchResult *allPhotos = [PHAsset fetchAssetsWithOptions:allPhotosOptions];
    self.allPhotos           = allPhotos;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Function .

- (void)showImgAssetsInGroup:(PHAssetCollection *)group {
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[ [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO] ];

    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:group options:options];
    self.allPhotos             = fetchResult;
}

- (CGSize)getAlbumCellSize {
    float collectionSlider = (APPFRAME.size.width - self.configuration.albumItemFlex * ((float)self.configuration.albumColumnCount + 1)) / (float)self.configuration.albumColumnCount;
    return CGSizeMake(collectionSlider, collectionSlider);
}

#pragma mark - Multy Picture selected

- (BOOL)thisPhotoIsSelectedWithRow:(NSInteger)row {
    __block BOOL bHas = NO;
    [self.choosenImageList enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *_Nonnull stop) {
        int selectedRow = [self.choosenImageList[idx] intValue];
        if (selectedRow == row) {
            bHas  = YES;
            *stop = YES;
        }
    }];
    return bHas;
}

#pragma mark - collection dataSourse

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.allPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row            = indexPath.row;
    XTPAlbumCell *cell       = [collectionView dequeueReusableCellWithReuseIdentifier:identifierAlbumnCell forIndexPath:indexPath];
    cell.picSelected         = [self thisPhotoIsSelectedWithRow:row];
    cell.isSingleChoosenMode = self.configuration.isSingleChoosenMode;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(XTPAlbumCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row  = indexPath.row;
    PHAsset *photo = [self.allPhotos objectAtIndex:row];
    [self.manager requestImageForAsset:photo
                            targetSize:[self getAlbumCellSize]
                           contentMode:PHImageContentModeAspectFill
                               options:nil
                         resultHandler:^(UIImage *result, NSDictionary *info) {
                             if (result) {
                                 cell.img.image = result;
                             }
                         }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self getAlbumCellSize];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (self.configuration.isSingleChoosenMode) {
        NSNumber *numRow = [NSNumber numberWithInteger:row];
        [self.choosenImageList addObject:numRow];
        [self exportResult];
    }
    else {
        [self multyPhotosChoosenWithIndexPath:indexPath];
    }
}

- (void)multyPhotosChoosenWithIndexPath:(NSIndexPath *)indexPath {
    NSInteger row    = indexPath.row;
    NSNumber *numRow = [NSNumber numberWithInteger:row];

    if ([self thisPhotoIsSelectedWithRow:row]) {
        [self.choosenImageList removeObject:numRow];
    }
    else {
        int maxCount = self.configuration.albumSelectedMaxCount;
        if (self.choosenImageList.count >= maxCount) {
            [SVProgressHUD showErrorWithStatus:@"超过最大图片数"];
            NSLog(@"%d 超过最大图片数", maxCount);
            return;
        }
        [self.choosenImageList addObject:numRow];
    }
    [self.collectionView reloadItemsAtIndexPaths:@[ indexPath ]];

    if (!self.configuration.isSingleChoosenMode) {
        self.commitItem.title = STR_FORMAT(@"确定(%lu)", (unsigned long)self.choosenImageList.count);
    }
}

#pragma mark - CameraGroupCtrllerDelegate

- (void)selectAlbumnGroup:(PHAssetCollection *)collection {
    [self.choosenImageList removeAllObjects];

    [self showImgAssetsInGroup:collection];

    if (self.groupCtrller.view.superview) {
        [self.groupCtrller cameraGroupAnimation:!self.groupCtrller.view.superview onView:self.view];
        [self.collectionView reloadData];
        [self.btTitleView setTitle:collection.localizedTitle forState:0];
        [self.btTitleView xt_setImagePosition:XTBtImagePositionRight spacing:6];
    }
}

@end
