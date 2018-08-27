//
//  Model1.h
//  XTkit
//
//  Created by teason23 on 2017/5/2.
//  Copyright © 2017年 teason. All rights reserved.


#import "XTDBModel.h"
//#import <Foundation/Foundation.h>
@class UIImage ;

@interface Model1 : XTDBModel

@property (nonatomic)       int             age         ;
@property (nonatomic)       float           floatVal    ;
@property (nonatomic)       long long       tick        ;
@property (nonatomic,copy)  NSString        *title      ;
@property (nonatomic,copy)  NSString        *abcabc     ;
@property (nonatomic,strong)NSData          *cover      ;

// add in db v 2 .
@property (nonatomic)       int             a1 ;
@property (nonatomic,strong)NSData          *a2 ;
@property (nonatomic,strong)UIImage         *a3 ;

// add in db v 3 .
@property (nonatomic)       double          b1 ;
@property (nonatomic,strong)NSString        *b2 ;
@property (nonatomic,strong)NSArray         *b3 ;

@end
