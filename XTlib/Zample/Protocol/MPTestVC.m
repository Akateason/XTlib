//
//  MPTestVC.m
//  XTlib
//
//  Created by teason23 on 2018/5/15.
//  Copyright © 2018年 teason23. All rights reserved.

// 用protocol和消息转发实现分离

#import "MPTestVC.h"
#import "MPTestView.h"



@interface MPTestVC () <MPTestViewProtocol>

@end

@implementation MPTestVC

//重写loadView来完成视视图的构建。
- (void)loadView {
    self.view = [[MPTestView alloc] initWithFrame:[UIScreen mainScreen].bounds] ;
}

//这个部分是实现的关键，来将控制器对视图属性协议的访问分发到布局视图中去。
- (id)forwardingTargetForSelector:(SEL)aSelector {
    struct objc_method_description omd = protocol_getMethodDescription(@protocol(MPTestViewProtocol), aSelector, NO, YES);
    if (omd.name != NULL) {
        return self.view;
    }
    
    return [super forwardingTargetForSelector:aSelector] ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //这里就可以像平常一样访问视图属性并添加事件的绑定处理。
    [self.button addTarget:self action:@selector(handleClick:) forControlEvents:UIControlEventTouchUpInside] ;
}

- (void)handleClick:(UIButton *)sender {
    NSLog(@"%ld tag",(long)sender.tag) ;
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
