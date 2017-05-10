//
//  Z5DisplayCell.m
//  XTkit
//
//  Created by teason23 on 2017/5/10.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Z5DisplayCell.h"
#import "Model1.h"

@implementation Z5DisplayCell
// UI and Layout
//- (void)prepare
//{
//    
//}

// set model
- (void)configure:(id)model
{
    if (!model) return ;
        
    Model1 *m1 = model ;
    self.lb1.text = [@"pkid" stringByAppendingString:[NSString stringWithFormat:@": %d",m1.pkid]] ;
    self.lb2.text = [@"age" stringByAppendingString:[NSString stringWithFormat:@": %d",m1.age]] ;
    self.lb3.text = [@"floatVal" stringByAppendingString:[NSString stringWithFormat:@": %f",m1.floatVal]] ;
    self.lb4.text = [@"title" stringByAppendingString:[NSString stringWithFormat:@": %@",m1.title]] ;
}

// height
+ (CGFloat)cellHeight
{
    return 122. ;
}

@end
