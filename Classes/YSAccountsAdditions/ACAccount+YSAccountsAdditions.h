//
//  ACAccount+YSAccountsAdditions.h
//  YSAccountsAdditionsExample
//
//  Created by Yu Sugawara on 2014/05/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Accounts/Accounts.h>

@interface ACAccount (YSAccountsAdditions)

- (NSString*)ys_twitterUserID;
+ (NSArray*)ys_userIDsForAccounts:(NSArray*)accounts;

@end
