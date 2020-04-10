//
//  TestDemoVC.m
//  XTlib
//
//  Created by teason23 on 2018/9/12.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "TestDemoVC.h"
#import <XTBase/XTBase.h>
#import <SDWebImage/SDWebImage.h>
#import "XTLargeImgScroll.h"
#import "XTZoomPicture.h"

@interface TestDemoVC ()

@end


@implementation TestDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    XTZoomPicture *zp = [XTZoomPicture new];
    UIImage *image = [UIImage imageNamed:@"test2"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    zp.imageView = imageView;
    zp.maximumZoomScale = 4.0;
    
    self.view = zp;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
