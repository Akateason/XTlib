

//计算程序运行时间
#import <Foundation/Foundation.h>

@interface NSObject (MKBlockTimer)

- (unsigned int) logTimeTakenToRunBlock:(void (^)(void)) block withPrefix:(NSString*) prefixString;

@end
