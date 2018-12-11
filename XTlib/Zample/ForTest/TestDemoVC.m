//
//  TestDemoVC.m
//  XTlib
//
//  Created by teason23 on 2018/9/12.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "TestDemoVC.h"
#import "XTlib.h"
#import "TestSon.h"


@interface TestDemoVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;

@end


@implementation TestDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    //    TestSon *son = [TestSon new] ;

    XTMutableArray *ary = [[XTMutableArray alloc] init];

    NSOperationQueue *queue           = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 10;
    for (int i = 0; i < 200; i++) {
        NSNumber *number = [NSNumber numberWithInt:i];
        [queue addOperationWithBlock:^{
            [ary addObject:number];
        }];
    }
    [queue waitUntilAllOperationsAreFinished];

    NSLog(@"%ld", (long)ary.count);
    NSLog(@"%@", ary);
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
