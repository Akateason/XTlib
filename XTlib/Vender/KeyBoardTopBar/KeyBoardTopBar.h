//
//  KeyBoardTopBar.h
//  testkeyboard
//
//  Created by JGBMACMINI01 on 14-9-16.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol KeyBoardTopBarDelegate <NSObject>

- (void)shutDownKeyBoard ;

@end

@interface KeyBoardTopBar : NSObject
{
    UIToolbar       *view;                       //工具条
    NSArray         *textFields;                 //输入框数组
    BOOL            allowShowPreAndNext;         //是否显示上一项、下一项
    BOOL            isInNavigationController;    //是否在导航视图中
    UIBarButtonItem *prevButtonItem;             //上一项按钮
    UIBarButtonItem *nextButtonItem;             //下一项按钮
    UIBarButtonItem *hiddenButtonItem;           //隐藏按钮
    UIBarButtonItem *spaceButtonItem;            //空白按钮
    UITextField     *currentTextField;           //当前输入框
}



@property(nonatomic,retain) UIToolbar *view;

@property(nonatomic,retain) id <KeyBoardTopBarDelegate> delegate ;

-(id)init;
-(void)setAllowShowPreAndNext:(BOOL)isShow;
-(void)setIsInNavigationController:(BOOL)isbool;
-(void)setTextFieldsArray:(NSArray *)array;
-(void)showPrevious;
-(void)showNext;
-(void)showBar:(UITextField *)textField;
-(void)HiddenKeyBoard;

@end
