//
//  UnitMergeSortTests.m
//  New_Relic_ChallengeTests
//
//  Created by Enders, Eric on 10/13/17.
//  Copyright © 2017 Enders, Eric. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"

@interface New_Relic_ChallengeTests : XCTestCase
@property (nonatomic,strong) ViewController *viewController;
@end

@implementation New_Relic_ChallengeTests
@synthesize viewController;
- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        viewController.mergeLength = 1000000;
        [viewController mergeSort]; // Eric Enders - call the merge sort which will load the amount of objects that is defined in the mergeSort
        
    }];
}

@end

