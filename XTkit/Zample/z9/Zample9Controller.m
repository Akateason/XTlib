//
//  Zample9Controller.m
//  XTkit
//
//  Created by teason23 on 2017/7/27.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample9Controller.h"
#import "TCase1.h"

@interface Zample9Controller ()
@property (strong,nonatomic) TCase1 *tcase1 ;
@end

@implementation Zample9Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tcase1 = [[TCase1 alloc] init] ;
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
