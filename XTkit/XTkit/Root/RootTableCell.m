//
//  RootTableCell.m
//  XTkit
//
//  Created by teason on 2017/4/20.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "RootTableCell.h"
#import <objc/runtime.h>

@implementation RootTableCell

#pragma mark --
#pragma mark - initialization
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier] ;
    if (self)
    {
        [self prepare] ;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib] ;
    
    [self prepare] ;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)dealloc
{
    
}

#pragma mark --
#pragma mark - get cell
+ (instancetype)cellWithTable:(UITableView *)tableView
{
    @autoreleasepool
    {
        const char *charClsName = object_getClassName(self) ;
        NSString *strClsName = [NSString stringWithUTF8String:charClsName] ;
        Class cellCls = objc_getRequiredClass(charClsName) ;
        //  polymorphic
        RootTableCell *cell = [tableView dequeueReusableCellWithIdentifier:strClsName] ;
        if (!cell)
        {
            cell = [[cellCls alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:strClsName] ; // use cls name as reuseIdentifier
        }
        return cell ;
    }
}

#pragma mark --
#pragma mark - prepare UI
- (void)prepare
{
    self.selectionStyle = UITableViewCellSelectionStyleNone ;
}



#pragma mark --
#pragma mark - configure
- (void)configure:(id)model
{
    // rewrite in subclass
}


#pragma mark --
#pragma mark - height
+ (CGFloat)cellHeight
{
    return 44. ;
}


@end
