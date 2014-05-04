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

- (void)testTwitterUserId
{
    [[YSAccountStore shardStore] requestAccessToTwitterAccountsWithCompletion:^(NSArray *accounts, NSError *error) {
        if (error) {
            XCTAssert(0, @"error: %@", error);
            return ;
        }
        for (ACAccount *account in accounts) {
            NSLog(@"account user id: %@", [account ys_twitterUserId]);
            XCTAssertNotNil([account ys_twitterUserId]);
        }
        RESUME;
    }];
    WAIT;
}

@end
