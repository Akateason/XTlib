//
//  ListEvent.h
//  PatchBoard
//
//  Created by teason23 on 2017/7/7.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "XTDBModel.h"

@interface ListEvent : XTDBModel
@property (nonatomic,copy)      NSString     *UUID          ;
@property (nonatomic,copy)      NSString     *kindOfKey     ;

@property (nonatomic)           int          row            ; // selected row
@property (nonatomic)           int          section        ; // selected section
@property (nonatomic,copy)      NSString     *fromDelegate  ; // delegate
@property (nonatomic,copy)      NSString     *listType      ; // @"table" or @"collection"

@property (nonatomic)           long long    time           ; // occur time
@property (nonatomic,copy)      NSString     *dateStr       ; // occut time str
@property (nonatomic)           int          uploaded       ; // default 0 not upload

- (instancetype)initWithRow:(int)row
                    section:(int)section
                       from:(NSString *)delegate
                   listType:(NSString *)listType ;

@end




