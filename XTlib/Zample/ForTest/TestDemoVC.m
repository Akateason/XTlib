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



@interface TestDemoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@end


@implementation TestDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
@weakify(self)
    [self.view xt_whenTapped:^{
        @strongify(self)

        
        
        
    }];
    

    


    
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
