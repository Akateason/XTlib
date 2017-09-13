//
//  Zample9Controller.m
//  XTkit
//
//  Created by teason23 on 2017/7/27.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample9Controller.h"
#import "TCase1.h"
#import "TCase2.h"

@interface Zample9Controller ()
@property (strong,nonatomic) TCase1 *tcase1 ;
@property (strong,nonatomic) TCase2 *tcase2 ;
@end

@implementation Zample9Controller

__weak id reference = nil ;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.tcase1 = [[TCase1 alloc] init] ;
//    self.tcase2 = [[TCase2 alloc] init] ;
    
//    @autoreleasepool {
        NSString *str = [NSString stringWithFormat:@"xtc"] ;
        reference = str ;
//    }
//    NSLog(@"%@",reference) ;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated] ;
    NSLog(@"ref : %@",reference) ;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated] ;
    NSLog(@"ref : %@",reference) ;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated] ;
//    [self.tcase1.timer1 invalidate] ;
//    [self.tcase2.timer invalidate] ;
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
