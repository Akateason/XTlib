//
//  HashDataVC.m
//  XTlib
//
//  Created by teason23 on 2020/10/27.
//  Copyright © 2020 teason23. All rights reserved.
//

#import "HashDataVC.h"
#import "Human.h"

@interface HashDataVC ()

@end

@implementation HashDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Human *human_1 = [Human humanWithName:@"lilei"];
    Human *human_2 = [Human humanWithName:@"hanmeimei"];
    Human *human_3 = [Human humanWithName:@"lewis"];
    Human *human_4 = [Human humanWithName:@"xiaohao"];
    Human *human_5 = [Human humanWithName:@"beijing"];

    id list = @[human_1,human_2,human_3,human_4,human_5];
    NSLog(@"%@",list);

    

    
    
}


@end
