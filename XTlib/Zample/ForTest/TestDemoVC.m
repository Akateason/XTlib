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
    
    
    XTZoomPicture *zp = [[XTZoomPicture alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:zp];
    [zp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    zp.backgroundColor = [UIColor blueColor];
    
    [zp.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2943767315,2930939798&fm=26&gp=0.jpg"]
                    placeholderImage:nil
                             options:(0)
                            progress:nil
                           completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        
        [zp reset];
        
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
