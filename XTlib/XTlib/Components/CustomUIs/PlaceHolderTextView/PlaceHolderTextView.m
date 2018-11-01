//
//  PlaceHolderTextView.m
//  subao
//
//  Created by apple on 15/8/20.
//  Copyright (c) 2015年 teason. All rights reserved.
//

#import "PlaceHolderTextView.h"

#define flex 5.0f


@interface PlaceHolderTextView () <UITextViewDelegate>
@property (nonatomic, strong) UILabel *lb_placeholder;
@end


@implementation PlaceHolderTextView

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.delegate     = self;
        self.contentInset = UIEdgeInsetsMake(-3, 0, flex, 0);
    }
    return self;
}

- (void)setStrPlaceHolder:(NSString *)strPlaceHolder {
    _strPlaceHolder = strPlaceHolder;

    [self lb_placeholder];
}

- (UILabel *)lb_placeholder {
    if (!_lb_placeholder) {
        CGRect rect      = CGRectZero;
        rect.size.width  = 150.0;
        rect.size.height = 20.0;
        rect.origin.x    = 5.0;
        rect.origin.y    = 10.0;

        _lb_placeholder      = [[UILabel alloc] initWithFrame:rect];
        _lb_placeholder.font = self.font;
        _lb_placeholder.text = self.strPlaceHolder;
        [_lb_placeholder sizeToFit];
        _lb_placeholder.textColor = [UIColor lightGrayColor];

        if (![_lb_placeholder superview]) {
            [self addSubview:_lb_placeholder];
        }
    }

    return _lb_placeholder;
}

- (void)setText:(NSString *)text {
    [super setText:text];

    [self textviewEmpty:!text.length];
}

#pragma mark--
#pragma mark - textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (!self.myDelegate) return YES;

    BOOL bResult = [self.myDelegate returnTVShouldBeginEditing:textView];

    if (bResult) [self textviewEmpty:NO];

    return bResult;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self textviewEmpty:!textView.text.length];

    [self.myDelegate didEndEditing:textView];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [self textviewEmpty:!textView.text.length];

    return [self.myDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
}

- (void)textviewEmpty:(BOOL)bEmpty {
    _lb_placeholder.hidden = !bEmpty;

    if (!self.isWhiteBG) {
        self.backgroundColor = bEmpty ? [UIColor lightGrayColor] : [UIColor whiteColor];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    [self.myDelegate textViewDidChange:textView];

    [self textviewEmpty:!textView.text.length];

    if (textView.text.length > self.maxWordsRange) {
        NSLog(@"超过字数, %d", self.maxWordsRange);
        textView.text = [textView.text substringToIndex:self.maxWordsRange];

        dispatch_async(dispatch_get_main_queue(), ^{

                           //            [XTHudManager showWordHudWithTitle:[NSString stringWithFormat:@"最多不能超过%d个字哟",self.maxWordsRange]] ;
                       });
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
