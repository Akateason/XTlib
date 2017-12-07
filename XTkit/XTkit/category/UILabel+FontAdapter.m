

#import "UILabel+FontAdapter.h"
#import <objc/runtime.h>
#import "UIFont+FontAdapter.h"

static void ExchangedMethod(SEL originalSelector, SEL swizzledSelector, Class class) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation UILabel (FontAdapter)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        ExchangedMethod(@selector(initWithCoder:), @selector(myInitWithCoder:), class) ;
    });
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode] ;
    if (self) {
        // 部分不像改变字体的 把tag值设置成333跳过
        if (self.tag != 333){
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont adjustFont:fontSize];
        }
    }
    return self;
}

@end

@implementation UIButton (FontAdapter)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        ExchangedMethod(@selector(initWithCoder:), @selector(myInitWithCoder:), class);
    });
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不想改变字体的 把tag值设置成333跳过
        if(self.tag != 333){
            CGFloat fontSize = self.titleLabel.font.pointSize;
            self.titleLabel.font = [UIFont adjustFont:fontSize];
        }
    }
    return self;
}

@end

@implementation UITextField (FontAdapter)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        ExchangedMethod(@selector(initWithCoder:), @selector(myInitWithCoder:), class);
    });
}

- (id)myInitWithCoder:(NSCoder*)aDecode {
    [self myInitWithCoder:aDecode];
    if (self) {
        //部分不想改变字体的 把tag值设置成333跳过
        if(self.tag != 333){
            CGFloat fontSize = self.font.pointSize;
            self.font = [UIFont adjustFont:fontSize];
        }
    }
    return self;
}

@end
