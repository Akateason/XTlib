//
//  TestAlbumVC.m
//  XTlib
//
//  Created by teason23 on 2019/2/27.
//  Copyright © 2019 teason23. All rights reserved.
//

#import "TestAlbumVC.h"

#import "XTPhotoAlbumVC.h"
#import "XTCameraHandler.h"
#import "XTPACropImageVC.h"
#import <XTBase/XTBase.h>
#import <SDWebImage/SDWebImage.h>



@interface TestAlbumVC ()
@property (strong, nonatomic) XTCameraHandler *handler;
@end


@implementation TestAlbumVC

- (IBAction)albumOnClick:(id)sender {
    XTPAConfig *config           = [[XTPAConfig alloc] init];
    config.albumSelectedMaxCount = 3;

    [XTPhotoAlbumVC openAlbumWithConfig:config
                            fromCtrller:self
                              getResult:^(NSArray<XTImageItem *> *_Nonnull imageList, NSArray<PHAsset *> *_Nonnull assetList, XTPhotoAlbumVC *vc){


                              }];
}

- (IBAction)cameraOnClick:(id)sender {
    XTCameraHandler *handler = [[XTCameraHandler alloc] init];
    [handler openCameraFromController:self takePhoto:^(XTImageItem *imageResult){


    }];
    self.handler = handler;
}

- (IBAction)sheetOnClick:(id)sender {
    [UIAlertController xt_showAlertCntrollerWithAlertControllerStyle:(UIAlertControllerStyleActionSheet) title:nil message:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[ @"照相", @"相册" ] callBackBlock:^(NSInteger btnIndex) {

        if (btnIndex == 1) {
            [self cameraOnClick:nil];
        }
        else if (btnIndex == 2) {
            [self albumOnClick:nil];
        }
    }];
}

- (IBAction)cropOnClick:(id)sender {
    UIImage *image = [UIImage imageNamed:@"test2"];
    [XTPACropImageVC showFromCtrller:self imageOrigin:image croppedImageCallback:^(UIImage *_Nonnull image){

    }];
}

- (IBAction)groupOperate:(id)sender {
    [UIAlertController xt_showAlertCntrollerWithAlertControllerStyle:(UIAlertControllerStyleActionSheet) title:nil message:nil cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@[ @"album+crop", @"camera+crop" ] callBackBlock:^(NSInteger btnIndex) {

        switch (btnIndex) {
            case 1: [self albumAddCrop]; break;
            case 2: [self cameraAddCrop]; break;
            default:
                break;
        }

    }];
}


- (void)albumAddCrop {
    XTPAConfig *config           = [[XTPAConfig alloc] init];
    config.albumSelectedMaxCount = 1;

    
    [XTPhotoAlbumVC openAlbumWithConfig:config fromCtrller:self willDismiss:NO getResult:^(NSArray<XTImageItem *> *_Nonnull imageList, NSArray<PHAsset *> *_Nonnull assetList, XTPhotoAlbumVC *vc) {

        
        if (!imageList) return;

        @weakify(vc)
            [XTPACropImageVC showFromCtrller:vc imageOrigin:imageList.firstObject.image croppedImageCallback:^(UIImage *_Nonnull image) {
                @strongify(vc)
                    [vc dismissViewControllerAnimated:YES completion:nil];


            }];
    }];
}

- (void)cameraAddCrop {
    @weakify(self)
        XTCameraHandler *handler = [[XTCameraHandler alloc] init];
    [handler openCameraFromController:self takePhoto:^(XTImageItem *imageResult) {
        if (!imageResult) return;

        @strongify(self)
            [XTPACropImageVC showFromCtrller:self imageOrigin:imageResult croppedImageCallback:^(UIImage *_Nonnull image){

            }];
    }];
    self.handler = handler;
}

// image previewer
- (IBAction)previewLocal:(id)sender {
    UIImage *image = [UIImage imageNamed:@"WechatIMG125"];
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    [self.view.window addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    @weakify(imgView)
    [imgView xt_whenTapped:^{
        @strongify(imgView)
        [imgView removeFromSuperview];
    }];
}

- (IBAction)previewOnline:(id)sender {
    UIImageView *imgView = [[UIImageView alloc] init];
    [self.view.window addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    @weakify(imgView)
    [imgView xt_whenTapped:^{
        @strongify(imgView)
        [imgView removeFromSuperview];
    }];
    
    [imgView sd_setImageWithURL:[NSURL URLWithString:@"https://i.loli.net/2019/03/04/5c7c9d9a12d67.gif"]];
}

- (IBAction)previewList:(id)sender {
    // TODO:
    
    
}


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
