//
//  ACAccount+YSAccountsAdditions.m
//  YSAccountsAdditionsExample
//
//  Created by Yu Sugawara on 2014/05/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "ACAccount+YSAccountsAdditions.h"

@implementation ACAccount (YSAccountsAdditions)

/* ID */

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

#pragma mark - Comparing

- (BOOL)ys_isEqualToAccount:(ACAccount*)account
{
    return [[self ys_twitterUserID] isEqualToString:[account ys_twitterUserID]];
}

+ (BOOL)ys_isEqualAccounts:(NSArray*)accounts1
                toAccounts:(NSArray*)accounts2
{
    if ([accounts1 count] != [accounts2 count]) {
        return NO;
    }
    
    for (ACAccount *acnt1 in accounts1) {
        BOOL isContains = NO;
        for (ACAccount *acnt2 in accounts2) {
            if ([acnt1 ys_isEqualToAccount:acnt2]) {
                isContains = YES;
                break;
            }
        }
        if (!isContains) {
            return NO;
        }
    }
    return YES;
}

@end
