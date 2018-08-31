//
//  UITableView+Stat.m
//  PatchBoard
//
//  Created by teason23 on 2017/7/7.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UITableView+Stat.h"
#import <objc/runtime.h>
#import "NSObject+Runtime.h"
#import "ListEvent.h"
#import "XTStatConst.h"

#define GET_CLASS_CUSTOM_SEL(sel,class)  NSSelectorFromString([NSString stringWithFormat:@"%@_%@",NSStringFromClass(class),NSStringFromSelector(sel)])

@implementation UITableView (Stat)

+ (void)load {
    [super load] ;
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{                
        SEL originalSelector = @selector(setDelegate:) ;
        SEL swizzledSelector = @selector(xt_setDelegate:) ;
        [self swizzledOrigin:originalSelector
                         new:swizzledSelector
                        from:[UITableView class]] ;
    }) ;
}

+ (void)swizzledOrigin:(SEL)originalSelector
                   new:(SEL)swizzledSelector
                  from:(Class)from
{
    Method originalMethod = class_getInstanceMethod(from, originalSelector) ;
    Method swizzledMethod = class_getInstanceMethod(from, swizzledSelector) ;
    method_exchangeImplementations(originalMethod, swizzledMethod) ;
}

- (void)xt_setDelegate:(id)delegate
{
    [self xt_setDelegate:delegate] ;
    
    if (!xt_Run_Stat) return ;
    
    if (![self isContainSEL:GET_CLASS_CUSTOM_SEL(@selector(tableView:didSelectRowAtIndexPath:), [delegate class])
                    inClass:[delegate class]])
    {
        [(UITableView *)self swizzling_tableViewDidSelectRowAtIndexPathInClass:delegate] ;
    }
}

- (void)swizzling_tableViewDidSelectRowAtIndexPathInClass:(id)object
{
    SEL sel = @selector(tableView:didSelectRowAtIndexPath:) ;
    
    [self addMethodWithClass:[object class]
                    selector:GET_CLASS_CUSTOM_SEL(sel,[object class])
                         imp:method_getImplementation(class_getInstanceMethod([self class],@selector(xt_imp_tableView:didSelectRowAtIndexPath:)))
                       types:"v@:@@"] ;
    
    if (![self isContainSEL:sel
                    inClass:[object class]])
    {
        [self addMethodWithClass:[object class]
                        selector:sel
                             imp:nil
                           types:"v@:@@"] ;
    }
    
    [self exchangeSEL1:sel
                  SEL2:GET_CLASS_CUSTOM_SEL(sel, [object class])
             withClass:[object class]] ;
}

/**
 swizzle method IMP
 */
- (void)xt_imp_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XTSTATLog(@"%@ didSelectRowAtIndexPath:%ld:%ld",NSStringFromClass([self class]),(long)indexPath.section,(long)indexPath.row) ;
    ListEvent *lEvent = [[ListEvent alloc] initWithRow:(int)(indexPath.row)
                                               section:(int)(indexPath.section)
                                                  from:NSStringFromClass([self class])
                                              listType:@"table"] ;
    [lEvent insert] ;
    
    SEL sel = GET_CLASS_CUSTOM_SEL(@selector(tableView:didSelectRowAtIndexPath:) , [self class]) ;
    if ([self respondsToSelector:sel])
    {
        IMP imp = [self methodForSelector:sel] ;
        void (*func)(id,SEL,id,id) = (void *)imp ;
        func(self,sel,tableView,indexPath) ;
    }
}

@end


