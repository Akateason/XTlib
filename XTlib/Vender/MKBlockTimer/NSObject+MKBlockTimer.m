


#import "NSObject+MKBlockTimer.h"


@implementation NSObject (MKBlockTimer)

- (unsigned int) logTimeTakenToRunBlock:(void (^)(void)) block withPrefix:(NSString*) prefixString {
	
	double a = CFAbsoluteTimeGetCurrent();
	block();
	double b = CFAbsoluteTimeGetCurrent();
	
	unsigned int m = ((b-a) * 1000.0f); // convert from seconds to milliseconds
	
	NSLog(@"%@: %d ms", prefixString ? prefixString : @"Time taken", m);
    
    return m ;
}
@end
