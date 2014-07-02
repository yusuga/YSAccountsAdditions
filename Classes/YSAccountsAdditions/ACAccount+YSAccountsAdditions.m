//
//  ACAccount+YSAccountsAdditions.m
//  YSAccountsAdditionsExample
//
//  Created by Yu Sugawara on 2014/05/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "ACAccount+YSAccountsAdditions.h"

@implementation ACAccount (YSAccountsAdditions)

- (NSString*)ys_twitterUserID
{
    if ([self.accountType.identifier isEqualToString:ACAccountTypeIdentifierTwitter]) {
        return [self valueForKeyPath:@"properties.user_id"];
    } else {
        return nil;
    }
}

+ (NSArray *)ys_userIDsForAccounts:(NSArray *)accounts
{
    NSMutableArray *ids = [NSMutableArray arrayWithCapacity:[accounts count]];
    for (ACAccount *account in accounts) {
        if ([account isKindOfClass:[ACAccount class]]) {
            [ids addObject:[account ys_twitterUserID]];
        }
    }
    return [NSArray arrayWithArray:ids];
}

@end
