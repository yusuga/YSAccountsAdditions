//
//  ACAccount+YSAccountsAdditions.h
//  YSAccountsAdditionsExample
//
//  Created by Yu Sugawara on 2014/05/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Accounts/Accounts.h>

@interface ACAccount (YSAccountsAdditions)

/* ID */

- (int64_t)ys_twitterUserID;
- (NSNumber*)ys_twitterUserIDNumber;
- (NSString*)ys_twitterUserIDString;
+ (NSArray*)ys_userIDsForAccounts:(NSArray*)accounts;

/* Comparing */

- (BOOL)ys_isEqualToAccount:(ACAccount*)account;
+ (BOOL)ys_isEqualAccounts:(NSArray*)accounts1
                toAccounts:(NSArray*)accounts2;

@end
