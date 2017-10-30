//
//  Zample7Controller.m
//  XTkit
//
//  Created by teason23 on 2017/5/12.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Zample7Controller.h"
#import "ReactiveObjC.h"

@interface Zample7Controller ()
@property (nonatomic,strong) UITextField *textfield1 ;
@property (nonatomic,strong) UITextField *textfield2 ;
@property (nonatomic,strong) UITextField *textfield3 ;
@property (nonatomic,strong) UIButton    *button1 ;
@end

@implementation Zample7Controller


- (void)viewDidLoad
{
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone ;
//    self.title = @"rac 1" ;
    
    [self setupUIsLayout] ;
    
    
    
    // Signal subscribeNext
    [self.textfield1.rac_textSignal subscribeNext:^(id x){
        NSLog(@"%@", x) ;
    }] ;
    
    // Signal Filter subscribeNext
    [[self.textfield2.rac_textSignal filter:^BOOL(NSString * text) {
        //NSString *text = value ;
        return text.length > 3 ;
    }] subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@",x) ;
    }] ;
    
//    RACSignal *tf2_signal = self.textfield2.rac_textSignal ;
//    RACSignal *tf2_filterSignal = [tf2_signal filter:^BOOL(id  _Nullable value) {
//
//    }] ;
//    [tf2_filterSignal subscribeNext:^(id  _Nullable x) {
//
//    }] ;
    
    // Signal map
    [[[self.textfield3.rac_textSignal map:^id _Nullable(NSString * text) {
//        NSString *text = value ;
        return @(text.length) ;
    }] filter:^BOOL(NSNumber *length) {
//        NSNumber *length = value ;
        return [length integerValue] > 3 ;
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x) ;
    }] ;
    
    // KVO
    [RACObserve(self.textfield1, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"kvo : %@",x) ;
    }] ;
    

    //
    [[self.button1 rac_signalForControlEvents:UIControlEventTouchUpInside]
                                subscribeNext:^(__kindof UIControl * _Nullable x) {
                                    NSLog(@"click") ;
     }] ;
    
}


- (void)setupUIsLayout
{
    self.textfield1 = ({
        UITextField *textfield = [[UITextField alloc] init] ;
        textfield.borderStyle = UITextBorderStyleRoundedRect ;
        textfield.placeholder = @"tf1 subscribedNext" ;
        [self.view addSubview:textfield] ;
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.view).offset(5) ;
        }] ;
        textfield ;
    }) ;

    self.textfield2 = ({
        UITextField *textfield = [[UITextField alloc] init] ;
        textfield.borderStyle = UITextBorderStyleRoundedRect ;
        textfield.placeholder = @"tf2 filter" ;
        [self.view addSubview:textfield] ;
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.textfield1.mas_bottom).offset(5) ;
        }] ;
        textfield ;
    }) ;
    
    self.textfield3 = ({
        UITextField *textfield = [[UITextField alloc] init] ;
        textfield.borderStyle = UITextBorderStyleRoundedRect ;
        textfield.placeholder = @"tf3 map" ;
        [self.view addSubview:textfield] ;
        [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.textfield2.mas_bottom).offset(5) ;
        }] ;
        textfield ;
    }) ;
    
    self.button1 = ({
        UIButton *button = [UIButton new] ;
        button.backgroundColor = [UIColor brownColor] ;
        [button setTitle:@"bt" forState:0] ;
        [self.view addSubview:button] ;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(200, 40)) ;
            make.centerX.equalTo(self.view) ;
            make.top.equalTo(self.textfield3.mas_bottom).offset(5) ;
        }] ;
        button ;
    }) ;
    
    
}





- (void)didReceiveMemoryWarning
{
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
