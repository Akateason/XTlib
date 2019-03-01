//
//  AlertTestVC.m
//  XTlib
//
//  Created by teason23 on 2018/7/2.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "AlertTestVC.h"
#import "XTSIAlertView.h"
#import <XTBase/XTBase.h>


@interface AlertTestVC ()

@end


@implementation AlertTestVC

- (IBAction)n_alert:(id)sender {
    [UIAlertController xt_showAlertCntrollerWithAlertControllerStyle:UIAlertControllerStyleAlert title:@"alert" message:@"aa" cancelButtonTitle:@"cancel" destructiveButtonTitle:nil otherButtonTitles:@[ @"ok" ] callBackBlock:^(NSInteger btnIndex){

    }];
}

- (IBAction)n_sheet:(id)sender {
    [UIAlertController xt_showAlertCntrollerWithAlertControllerStyle:UIAlertControllerStyleAlert title:@"sheet" message:@"aa12313" cancelButtonTitle:@"cancel" destructiveButtonTitle:@"des" otherButtonTitles:@[ @"ok", @"41" ] callBackBlock:^(NSInteger btnIndex){

    }];
}

- (IBAction)c_alert:(id)sender {
    [XTSIAlertView alertWithTitle:@"alert"
        subTitle:@"custom it"
        normalBtTitle:@"OK"
        normal:^(XTSIAlertView *alertView) {
        }
        cancelBtTitle:@"Cancel"
        cancel:^(XTSIAlertView *alertView){

        }];
}

- (IBAction)c_sheet:(id)sender {
    XTSIAlertView *alert = [[XTSIAlertView alloc] initWithTitle:@"title" andMessage:@"subTitle"];
    [alert addButtonWithTitle:@"this is normal"
                         type:XTSIAlertViewButtonTypeDefault
                      handler:nil];
    [alert addButtonWithTitle:@"Destructive"
                         type:XTSIAlertViewButtonTypeDestructive
                      handler:nil];
    [alert addButtonWithTitle:@"cancel"
                         type:XTSIAlertViewButtonTypeCancel
                      handler:nil];
    [alert show];
}

- (IBAction)textfieldAlert:(id)sender {
    [UIAlertController xt_showTextFieldAlertWithTitle:@"title" subtitle:@"subtitle" cancel:@"cancel" commit:@"ok" placeHolder:@"please input ..." callback:^(NSString *text) {

        NSLog(@"%@", text);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
