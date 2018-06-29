//
//  DesignableInspectableVC.m
//  XTlib
//
//  Created by teason23 on 2018/6/6.
//  Copyright © 2018年 teason23. All rights reserved.
//

#import "DesignableInspectableVC.h"

@interface DesignableInspectableVC ()

@end

@implementation DesignableInspectableVC

- (IBAction)click:(id)sender {
    
//    [XTAnimation shakeRandomDirectionWithDuration:.5 AndWithView:_img1] ;
//    [XTAnimation animationRevealFromBottom:_cView1 duration:1] ;
    
//    [XTAnimation animationFlipFromLeft:_img1 duration:1] ;
//    [XTAnimation animationCurlUp:_cView1 duration:1] ;
    
//    [XTAnimation animationPushUp:_img1 duration:1] ;
//    [XTAnimation animationMoveUp:_cView1 duration:1] ;
    
    [XTAnimation rotateForever:_img1 once:.3] ;
    
//    [XTAnimation cradle:_img1] ;
//    [XTAnimation rotateAndEnlarge:_cView1] ;
    
//    [XTAnimation animationFlipFromTop:_img1 duration:1] ;
//    [XTAnimation animationCubeFromLeft:_cView1 duration:1] ;

//    [XTAnimation animationSuckEffect:_img1 duration:1] ;
//    [XTAnimation animationRippleEffect:_cView1 duration:1] ;

//    [XTAnimation animationCameraOpen:_img1 duration:1] ;
//    [XTAnimation animationCameraClose:_cView1 duration:1] ;
    
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
