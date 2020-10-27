//
//  SHMLargeImgScroll+ScrollView.h
//  owl
//
//  Created by teason23 on 2020/7/7.
//  Copyright © 2020 shimo.im. All rights reserved.
//

#import "SHMLargeImgScroll.h"



@interface SHMLargeImgScroll (ScrollView)

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

- (void)doBeforeTheProgress;

- (void)doAfterTheProgress;

@end


