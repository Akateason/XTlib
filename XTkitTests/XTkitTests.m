//
//  XTkitTests.m
//  XTkitTests
//
//  Created by teason on 2017/4/6.
//  Copyright © 2017年 teason. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "StatSender.h"
#import "XTArchive.h"
#import "CommonFunc.h"
#import "XTJson.h"

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
    NSArray *list = @[@"231",@"adfadf",@"dsa"] ;
    NSString *jsonStr = [XTJson getStrWithJson:list] ;
    NSString *path = [[CommonFunc getDocumentsPath] stringByAppendingString:@"/o1.txt"] ;
//    [jsonStr writeToFile:path atomically:YES] ;
    [jsonStr writeToFile:path
              atomically:YES
                encoding:NSUTF8StringEncoding
                   error:nil] ;
    
    NSString *resp = [NSString stringWithContentsOfFile:path
                                               encoding:NSUTF8StringEncoding
                                                  error:nil] ;
    
    
    StatSender *sender = [StatSender new] ;
//    NSString *filePath = [sender writeToFile:list] ;
//    NSString *zipPath = [sender archiveZip:[CommonFunc getDocumentsPath]] ;
    BOOL bSuc = [sender archiveZip:[path stringByAppendingString:@".zip"] withDirectory:path] ;
    
//    NSData *data = [sender unarchiveZip:zipPath] ;
    
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
