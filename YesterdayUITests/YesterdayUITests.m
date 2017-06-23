//
//  YesterdayUITests.m
//  YesterdayUITests
//
//  Created by guiping on 2017/6/23.
//  Copyright © 2017年 pingui. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface YesterdayUITests : XCTestCase

@end

@implementation YesterdayUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void) testUI{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"贝塞尔曲线"] swipeUp];
    [tablesQuery.staticTexts[@"林肯控制界面"] tap];
    [app.pickerWheels[@"23℃, 4 of 20"] swipeLeft];
   
    XCUIElement *i8Button = app.buttons[@"i8 摆头"];
    [i8Button tap];
    [i8Button tap];
    
    XCUIElement *i8Button2 = app.buttons[@"i8 风速"];
    [i8Button2 tap];
    [i8Button2 tap];
    [i8Button2 tap];
    [i8Button2 tap];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

@end
