//
//  KeyBoardTopBar.m
//  testkeyboard
//
//  Created by JGBMACMINI01 on 14-9-16.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import "KeyBoardTopBar.h"


#define APPFM                   [UIScreen mainScreen].bounds
#define HEIGHT_NUMBERPAD        216.0f
#define HEIGHT_TOOLBAR          44.0f
#define HEIGHT_NAVBAR           40.0f

#define WD_LAST     @"上一项"
#define WD_NEXT     @"下一项"
#define SHUTDOWN    @"完成"

@implementation KeyBoardTopBar


@synthesize view;

- (id)init
{
    if((self = [super init]))
    {
        prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:WD_LAST style:UIBarButtonItemStyleBordered target:self action:@selector(showPrevious)];
        nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:WD_NEXT style:UIBarButtonItemStyleBordered target:self action:@selector(showNext)];
        
        UIButton *correctButton = [UIButton buttonWithType:UIButtonTypeCustom]  ;
        [correctButton setTitle:SHUTDOWN forState:UIControlStateNormal]         ;
//        [correctButton setTitleColor:COLOR_MAIN forState:UIControlStateNormal]  ;
        [correctButton setFont:[UIFont systemFontOfSize:14.0f]]                 ;
//        correctButton.layer.borderColor = COLOR_MAIN.CGColor    ;
        correctButton.layer.borderWidth = 1.0f                  ;
        correctButton.layer.cornerRadius = 5.0f                 ;
        [correctButton setFrame:CGRectMake(0, 0, 60, 35)]       ;
        [correctButton addTarget:self action:@selector(HiddenKeyBoard) forControlEvents:UIControlEventTouchUpInside] ;
        hiddenButtonItem = [[UIBarButtonItem alloc] initWithCustomView:correctButton] ;
        
//        hiddenButtonItem = [[UIBarButtonItem alloc] initWithTitle:SHUTDOWN style:UIBarButtonItemStyleBordered target:self action:@selector(HiddenKeyBoard)];
        
        
        
        spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        view = [[UIToolbar alloc] initWithFrame:CGRectMake(0,APPFM.size.height,APPFM.size.width,HEIGHT_TOOLBAR)];
        [view setTintColor:[UIColor blackColor]] ;
        view.barStyle = UIBarStyleDefault ;                         //UIBarStyleBlackTranslucent;
        view.items = [NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem,nil];
        allowShowPreAndNext = YES;
        textFields = nil;
        isInNavigationController = YES;
        currentTextField = nil;
    }
    
    return self;
}

//设置是否在导航视图中
- (void)setIsInNavigationController:(BOOL)isbool
{
    isInNavigationController = isbool;
}

//显示上一项
- (void)showPrevious
{
    if (textFields==nil) {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i=0; i<[textFields count]; i++) {
        if ([textFields objectAtIndex:i]==currentTextField) {
            num = i;
            break;
        }
    }
    if (num>0){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num-1 ] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num-1]];
    }
}

//显示下一项
- (void)showNext
{
    if (textFields==nil) {
        return;
    }
    NSInteger num = -1;
    for (NSInteger i = 0; i<[textFields count]; i++) {
        if ([textFields objectAtIndex:i]==currentTextField) {
            num = i;
            break;
        }
    }
    if (num<[textFields count]-1){
        [[textFields objectAtIndex:num] resignFirstResponder];
        [[textFields objectAtIndex:num+1] becomeFirstResponder];
        [self showBar:[textFields objectAtIndex:num+1]];
    }
}

//显示工具条
- (void)showBar:(UITextField *)textField
{
    currentTextField = textField;
    if (allowShowPreAndNext) {
        [view setItems:[NSArray arrayWithObjects:prevButtonItem,nextButtonItem,spaceButtonItem,hiddenButtonItem,nil]];
    }
    else {
        [view setItems:[NSArray arrayWithObjects:spaceButtonItem,hiddenButtonItem,nil]];
    }
    if (textFields==nil) {
        prevButtonItem.enabled = NO;
        nextButtonItem.enabled = NO;
    }
    else {
        NSInteger num = -1;
        for (NSInteger i = 0; i < [textFields count]; i++) {
            if ([textFields objectAtIndex:i] == currentTextField) {
                num = i;
                break;
            }
        }
        if (num > 0) {
            prevButtonItem.enabled = YES;
        }
        else {
            prevButtonItem.enabled = NO;
        }
        if (num < [textFields count] - 1) {
            nextButtonItem.enabled = YES;
        }
        else {
            nextButtonItem.enabled = NO;
        }
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    
    int h = APPFM.size.height - HEIGHT_NUMBERPAD - HEIGHT_TOOLBAR;
    
    if (isInNavigationController)
    {
        view.frame = CGRectMake(0, h - HEIGHT_NAVBAR, APPFM.size.width, HEIGHT_TOOLBAR) ;
    }
    else {
        view.frame = CGRectMake(0, h , APPFM.size.width, HEIGHT_TOOLBAR) ;
    }
    [UIView commitAnimations];
}

//设置输入框数组
-(void)setTextFieldsArray:(NSArray *)array{
    textFields = array;
}
//设置是否显示上一项和下一项按钮
- (void)setAllowShowPreAndNext:(BOOL)isShow{
    allowShowPreAndNext = isShow;
}

//隐藏键盘和工具条
- (void)HiddenKeyBoard{
    if (currentTextField!=nil) {
        [currentTextField  resignFirstResponder];
    }
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    view.frame = CGRectMake(0, APPFM.size.height, APPFM.size.width, HEIGHT_TOOLBAR);
    
    [UIView commitAnimations];
    
    
    
    [self.delegate shutDownKeyBoard] ;
    
    
//    NSLog(@"HiddenKeyBoard") ;
}




@end
