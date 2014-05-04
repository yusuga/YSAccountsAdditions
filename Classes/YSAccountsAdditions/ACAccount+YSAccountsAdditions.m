//
//  ACAccount+YSAccountsAdditions.m
//  YSAccountsAdditionsExample
//
//  Created by Yu Sugawara on 2014/05/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "ACAccount+YSAccountsAdditions.h"

@implementation ACAccount (YSAccountsAdditions)

- (NSString*)ys_twitterUserId
{
    if ([self.accountType.identifier isEqualToString:ACAccountTypeIdentifierTwitter]) {
        return [self valueForKeyPath:@"properties.user_id"];
    } else {
        return nil;
    }
}

@end
