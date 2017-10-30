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
    NSMutableArray *arr1 = [NSMutableArray arrayWithArray:arr] ;
    [self bubbleSort:arr1
             andSort:^BOOL(int x, int y) {
        return x > y ;
    }] ;
    NSLog(@"bubble : %@",arr1) ;

}

typedef BOOL (^Sort)(int x, int y) ;

- (void)bubbleSort:(NSMutableArray *)arr andSort:(Sort)sort {
    //外面的循环是控制一共循环多少次
    for (int i = 0; i < arr.count - 1; i++) {
        //每一次循环 依次把大值放到后面
        for (int j = 0; j < arr.count - i - 1; j++) {
            NSNumber *num1 = arr[j] ;
            NSNumber *num2 = arr[j+1] ;
            //因为是对象类型，所以要转为int进行比较
            if (sort(num1.intValue, num2.intValue)) {
//                NSNumber *temp = arr[j+1] ;
//                arr[j+1] = arr[j] ;
//                arr[j] = temp ;
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1] ;
            }
        }
    }
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
