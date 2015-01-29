//
//  testACAccount.m
//  YSAccountsAdditionsExample
//
//  Created by Yu Sugawara on 2014/05/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <YSAccountStore/YSAccountStore.h>
#import "ACAccount+YSAccountsAdditions.h"

@interface testACAccount : XCTestCase

@end

@implementation testACAccount

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testTwitterUserID
{
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    [[YSAccountStore shardStore] requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
        XCTAssertNil(error);
        XCTAssertGreaterThan([accounts count], 0);
        
        for (ACAccount *account in accounts) {
            int64_t userID = [account ys_twitterUserID];
            XCTAssertGreaterThan(userID, 0);
            
            NSString *userIDStr = [account ys_twitterUserIDString];
            XCTAssertTrue([userIDStr isKindOfClass:[NSString class]]);
            
            NSNumber *userIDNum = [account ys_twitterUserIDNumber];
            XCTAssertTrue([userIDNum isKindOfClass:[NSNumber class]]);
            
            XCTAssertEqual(userID, userIDStr.longLongValue);
            XCTAssertEqual(userID, userIDNum.longLongValue);
        }
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10. handler:^(NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
    }];
}

- (void)testUserIDs
{
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    [[YSAccountStore shardStore] requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
        XCTAssertNil(error);
        XCTAssertGreaterThan([accounts count], 0);
        
        NSArray *ids = [ACAccount ys_userIDsForAccounts:accounts];
        XCTAssertEqual([ids count], [accounts count]);
        
        [accounts enumerateObjectsUsingBlock:^(ACAccount *account, NSUInteger idx, BOOL *stop) {
            NSNumber *userID = ids[idx];
            XCTAssertEqualObjects(userID, [account ys_twitterUserIDNumber]);
        }];
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10. handler:^(NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
    }];
}

- (void)testIsEqual
{
    // isEqual: has not been implemented in ACAccount.
    
    YSAccountStore *store = [YSAccountStore shardStore];
    __block NSArray *accounts1;
    
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    [store requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
        XCTAssertNil(error);
        XCTAssertGreaterThan([accounts count], 0);
        
        [accounts1 enumerateObjectsUsingBlock:^(ACAccount *acnt1, NSUInteger idx, BOOL *stop) {
            XCTAssertEqualObjects(acnt1, acnt1);
        }];
        XCTAssertEqualObjects(accounts, accounts);
        
        accounts1 = accounts;
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10. handler:^(NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
    }];
    
    XCTAssertGreaterThan([accounts1 count], 0);
    
    expectation = [self expectationWithDescription:nil];
    [store requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts2, NSError *error) {
        XCTAssertNil(error);
        XCTAssertGreaterThan([accounts2 count], 0);
        XCTAssertEqual([accounts1 count], [accounts2 count]);
        
        [accounts1 enumerateObjectsUsingBlock:^(ACAccount *acnt1, NSUInteger idx, BOOL *stop) {
            ACAccount *acnt2 = accounts2[idx];
            XCTAssertNotEqualObjects(acnt1, acnt2);
        }];
        
        XCTAssertNotEqualObjects(accounts1, accounts2);
        
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10. handler:^(NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
    }];
}

- (void)testIsEqualToAccount
{
    YSAccountStore *store = [YSAccountStore shardStore];
    __block NSArray *accounts1;
    
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    [store requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
        XCTAssertNil(error);
        XCTAssertGreaterThan([accounts count], 0);
        accounts1 = accounts;
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10. handler:^(NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
    }];
    
    XCTAssertGreaterThan([accounts1 count], 0);
    
    expectation = [self expectationWithDescription:nil];
    [store requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts2, NSError *error) {
        XCTAssertNil(error);
        XCTAssertGreaterThan([accounts2 count], 0);
        XCTAssertEqual([accounts1 count], [accounts2 count]);
        
        [accounts1 enumerateObjectsUsingBlock:^(ACAccount *acnt1, NSUInteger idx, BOOL *stop) {
            ACAccount *acnt2 = accounts2[idx];
            XCTAssertTrue([acnt1 ys_isEqualToAccount:acnt2]);
        }];
        
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10. handler:^(NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
    }];
}

- (void)testIsEqualToAccounts
{
    YSAccountStore *store = [YSAccountStore shardStore];
    __block NSArray *accounts1;
    
    XCTestExpectation *expectation = [self expectationWithDescription:nil];
    [store requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
        XCTAssertNil(error);
        XCTAssertGreaterThan([accounts count], 1);
        accounts1 = accounts;
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10. handler:^(NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
    }];
    
    XCTAssertGreaterThan([accounts1 count], 0);
    
    expectation = [self expectationWithDescription:nil];
    [store requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts2, NSError *error) {
        XCTAssertNil(error);
        XCTAssertGreaterThan([accounts2 count], 1);
        XCTAssertEqual([accounts1 count], [accounts2 count]);
        
        XCTAssertTrue([ACAccount ys_isEqualAccounts:accounts1 toAccounts:accounts2]);
        
        NSMutableArray *accounts3 = @[].mutableCopy;
        for (id obj in accounts2) {
            [accounts3 insertObject:obj atIndex:0];
        }
        
        XCTAssertTrue([ACAccount ys_isEqualAccounts:accounts1 toAccounts:accounts3]);
        
        [expectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10. handler:^(NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
    }];
}

@end
