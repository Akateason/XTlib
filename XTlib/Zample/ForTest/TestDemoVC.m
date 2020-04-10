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


@interface TestDemoVC ()

@end


@implementation TestDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    XTLargeImgScroll *imgScroll = [[XTLargeImgScroll alloc] initWithFrame:self.view.bounds];
    [imgScroll setupLargeImage:[UIImage imageNamed:@"test"]];
    self.view = imgScroll;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
