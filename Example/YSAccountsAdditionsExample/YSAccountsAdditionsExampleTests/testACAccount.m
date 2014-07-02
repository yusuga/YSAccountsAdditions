//
//  testACAccount.m
//  YSAccountsAdditionsExample
//
//  Created by Yu Sugawara on 2014/05/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TKRGuard/TKRGuard.h>
#import <YSAccountStore/YSAccountStore.h>
#import "ACAccount+YSAccountsAdditions.h"

@interface testACAccount : XCTestCase

@end

@implementation testACAccount

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTwitterUserID
{
    [[YSAccountStore shardStore] requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
        XCTAssertNotNil(accounts);
        XCTAssertTrue([accounts count] > 0);
        
        for (ACAccount *account in accounts) {
            XCTAssertNotNil([account ys_twitterUserID]);
        }
        RESUME;
    }];
    WAIT;
}

- (void)testUserIDs
{
    [[YSAccountStore shardStore] requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
        XCTAssertNil(error, @"error: %@", error);
        XCTAssertNotNil(accounts);
        XCTAssertTrue([accounts count] > 0);
        
        NSArray *ids = [ACAccount ys_userIDsForAccounts:accounts];
        XCTAssertEqual([ids count], [accounts count], @"ids: %zd, accounts: %zd", [ids count], [accounts count]);
        
        [accounts enumerateObjectsUsingBlock:^(ACAccount *account, NSUInteger idx, BOOL *stop) {
            NSString *userID = ids[idx];
            XCTAssertEqual(userID, [account ys_twitterUserID], @"userID: %@, accountID: %@", userID, [account ys_twitterUserID]);
        }];
        RESUME;
    }];
    WAIT;
}

@end
