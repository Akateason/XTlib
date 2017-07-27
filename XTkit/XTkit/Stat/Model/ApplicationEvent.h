//
//  ApplicationEvent.h
//  PatchBoard
//
//  Created by teason23 on 2017/7/6.
//  Copyright © 2017年 teason. All rights reserved.
//
#import "XTDBModel.h"
@class UIEvent ;

@interface ApplicationEvent : XTDBModel
@property (nonatomic,copy)      NSString     *UUID          ;    
@property (nonatomic,copy)      NSString     *kindOfKey     ;

@property (nonatomic,copy)      NSString     *action        ; // SEL
@property (nonatomic,copy)      NSString     *target        ; // to
@property (nonatomic,copy)      NSString     *sender        ; // from
@property (nonatomic,copy)      NSString     *event         ; // event

@property (nonatomic)           long long    time           ; // occur time
@property (nonatomic,copy)      NSString     *dateStr       ; // occur time str
@property (nonatomic,copy)      NSString     *tree          ; // view tree
@property (nonatomic)           int          uploaded       ; // default 0 not upload

- (instancetype)initWithSEL:(SEL)sel
                         to:(id)target
                       from:(id)sender
                   forEvent:(UIEvent *)event ;

@end
