//
//  PlaceHolderTextView.h
//  subao
//
//  Created by apple on 15/8/20.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaceHolderTextViewDelegate <NSObject>
@optional
- (BOOL)returnTVShouldBeginEditing:(UITextView *)tv ;
- (void)didEndEditing:(UITextView *)tv ;
- (BOOL)textView:(UITextView *)tv shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)textViewDidChange:(UITextView *)tv ;
@end

@interface PlaceHolderTextView : UITextView
@property (nonatomic, weak)   id <PlaceHolderTextViewDelegate> myDelegate ;
@property (nonatomic)           int         maxWordsRange ;
@property (nonatomic, copy)     NSString    *strPlaceHolder ;
@property (nonatomic)           BOOL        isWhiteBG ; // default is NO ;
- (void)textviewEmpty:(BOOL)bEmpty ;
@end
