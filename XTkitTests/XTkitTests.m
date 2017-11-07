//
//  XTkitTests.m
//  XTkitTests
//
//  Created by teason on 2017/4/6.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <XCTest/XCTest.h>

//#import "StatSender.h"
//#import "XTArchive.h"
//#import "CommonFunc.h"
//#import "XTJson.h"
#import "Algorithm.h"

@interface XTkitTests : XCTestCase

@end

@implementation XTkitTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVaolet {
    
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSArray *arr = @[@(1),@(4),@(3),@(9),@(7)] ;
    [Algorithm bubbleSortWithArray:[arr mutableCopy]
                           andSort:^BOOL(int x, int y) {
                               return x < y ;
                           }] ;
    NSLog(@"bubble : %@",arr) ;

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
