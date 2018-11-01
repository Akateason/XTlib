//
//  MyTextField.m
//  JGB
//
//  Created by JGBMACMINI01 on 14-10-23.
//  Copyright (c) 2014年 JGBMACMINI01. All rights reserved.
//

#import "MyTextField.h"
#import "ScreenHeader.h"


@implementation MyTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.borderStyle = UITextBorderStyleNone;
        //        CGColorRef cgColor      = COLOR_LIGHT_GRAY.CGColor ;
        //        float      width        = 1.0f ;
        //        self.layer.borderColor  = cgColor ;
        //        self.layer.borderWidth  = width ;
        self.layer.cornerRadius        = G_CORNER_RADIUS;
        self.autocorrectionType        = UITextAutocorrectionTypeNo;
        self.adjustsFontSizeToFitWidth = YES;
        self.minimumFontSize           = 12.0f;
        self.font                      = [UIFont systemFontOfSize:12.0f];
    }

    return self;
}

- (void)anyStyle {
    //    self.layer.borderColor = COLOR_BACKGROUND.CGColor ;
    self.layer.borderWidth = 0.5f;
    self.borderStyle       = UITextBorderStyleNone;
    //    self.textColor         = COLOR_MAIN ;   //[UIColor lightGrayColor] ;
    self.font = [UIFont systemFontOfSize:12.0f];
}


- (void)layoutSubviews {
    [super layoutSubviews];
}


#pragma mark--
#pragma mark - re write set text bounds rect

#define FLEX_WIDTHS 12.0f

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect tempRect = CGRectMake(FLEX_WIDTHS, 0, bounds.size.width - FLEX_WIDTHS, bounds.size.height);
    return tempRect;
}


- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect tempRect = CGRectMake(FLEX_WIDTHS, 0, bounds.size.width - FLEX_WIDTHS, bounds.size.height);
    return tempRect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect tempRect = CGRectMake(FLEX_WIDTHS, 0, bounds.size.width - FLEX_WIDTHS, bounds.size.height);
    return tempRect;
}

@end
