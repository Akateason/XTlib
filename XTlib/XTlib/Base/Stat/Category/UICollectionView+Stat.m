//
//  UICollectionView+Stat.m
//  XTkit
//
//  Created by teason23 on 2017/7/24.
//  Copyright © 2017年 teason. All rights reserved.
//

#import "UICollectionView+Stat.h"
#import <objc/runtime.h>
#import "NSObject+Runtime.h"
#import "ListEvent.h"
#import "XTStatConst.h"

#define GET_CLASS_CUSTOM_SEL(sel,class)  NSSelectorFromString([NSString stringWithFormat:@"%@_%@",NSStringFromClass(class),NSStringFromSelector(sel)])


@implementation UICollectionView (Stat)

+ (void)load {
    [super load] ;
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(setDelegate:) ;
        SEL swizzledSelector = @selector(xt_setDelegate:) ;
        [self swizzledOrigin:originalSelector
                         new:swizzledSelector
                        from:[UICollectionView class]] ;
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

- (void)xt_setDelegate:(id)delegate {
    [self xt_setDelegate:delegate] ;
    
    if (!xt_Run_Stat) return ;
    
    if (![self isContainSEL:GET_CLASS_CUSTOM_SEL(@selector(collectionView:didSelectItemAtIndexPath:), [delegate class])
                    inClass:[delegate class]]) {
        [(UICollectionView *)self swizzling_collectionViewDidSelectRowAtIndexPathInClass:delegate] ;
    }
}

- (void)swizzling_collectionViewDidSelectRowAtIndexPathInClass:(id)object {
    SEL sel = @selector(collectionView:didSelectItemAtIndexPath:) ;
    [self addMethodWithClass:[object class]
                    selector:GET_CLASS_CUSTOM_SEL(sel, [object class])
                         imp:method_getImplementation(class_getInstanceMethod([self class],@selector(xt_imp_collectionView:didSelectItemAtIndexPath:)))
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

- (void)xt_imp_collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XTSTATLog(@"%@ didSelectRowAtIndexPath: %ld :%ld",NSStringFromClass([self class]),(long)indexPath.section,(long)indexPath.row) ;
    
    ListEvent *lEvent = [[ListEvent alloc] initWithRow:(int)(indexPath.row)
                                               section:(int)(indexPath.section)
                                                  from:NSStringFromClass([self class])
                                              listType:@"collection"] ;
    [lEvent insert] ;
    SEL sel = GET_CLASS_CUSTOM_SEL(@selector(collectionView:didSelectItemAtIndexPath:) , [self class]) ;
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel] ;
        void (*func)(id,SEL,id,id) = (void *)imp ;
        func(self,sel,collectionView,indexPath) ;
    }
}

@end
