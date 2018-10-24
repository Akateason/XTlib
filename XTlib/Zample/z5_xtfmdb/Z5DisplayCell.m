//
//  Z5DisplayCell.m
//  XTkit
//
//  Created by teason23 on 2017/5/10.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "Z5DisplayCell.h"
#import "Model1.h"
#import "XTFMDB.h"

@implementation Z5DisplayCell

// set model
- (void)configure:(id)model
{
    if (!model) return ;
        
    Model1 *m1 = model ;
    self.lb1.text = [@"pkid" stringByAppendingString:[NSString stringWithFormat:@": %d",m1.pkid]] ;
    self.lb2.text = [@"age" stringByAppendingString:[NSString stringWithFormat:@": %d",m1.age]] ;
    self.lb3.text = [@"floatVal" stringByAppendingString:[NSString stringWithFormat:@": %f",m1.floatVal]] ;
    self.lb4.text = [@"title" stringByAppendingString:[NSString stringWithFormat:@": %@",m1.title]] ;
    
    NSData *data = m1.cover ;   // 你从select中取到的data类型的数据
    self.imgView.image = [UIImage imageWithData:data] ;
//    NSString *str = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength] ;
//    self.imgView.image = [UIImage imageWithData:[[NSData alloc] initWithBase64EncodedString:str
//                                                                                    options:NSDataBase64DecodingIgnoreUnknownCharacters]];
    
    
}

// height
+ (CGFloat)cellHeight
{
    return 122. ;
}

@end
