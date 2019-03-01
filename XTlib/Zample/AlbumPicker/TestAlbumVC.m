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


@interface TestAlbumVC () <RSKImageCropViewControllerDelegate, RSKImageCropViewControllerDataSource>
@property (strong, nonatomic) XTCameraHandler *handler;
@end


@implementation TestAlbumVC

- (IBAction)albumOnClick:(id)sender {
    XTPAConfig *config           = [[XTPAConfig alloc] init];
    config.albumSelectedMaxCount = 10;

    [XTPhotoAlbumVC openAlbumWithConfig:config
                            fromCtrller:self
                              getResult:^(NSArray<UIImage *> *_Nonnull imageList, NSArray<PHAsset *> *_Nonnull assetList){


                              }];
}

- (IBAction)cameraOnClick:(id)sender {
    XTCameraHandler *handler = [[XTCameraHandler alloc] init];
    [handler openCameraFromController:self takePhoto:^(UIImage *imageResult){


    }];
    self.handler = handler;
}

- (IBAction)sheetOnClick:(id)sender {
}

- (IBAction)cropOnClick:(id)sender {
    UIImage *image = [UIImage imageNamed:@"test2"];

    [XTPACropImageVC showFromCtrller:self imageOrigin:image croppedImageCallback:^(UIImage *_Nonnull image){

    }];
}


#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
