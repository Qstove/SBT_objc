//
//  NSString+QSTNSString.m
//  SearchViaFickr
//
//  Created by Qstove on 17/04/2019.
//  Copyright © 2019 Qstove. All rights reserved.
//

#import "NSString+QSTNSString.h"


@implementation NSString (QSTNSString)

- (BOOL)isStringEmpty:(NSString*)string
{
    if([string length] == 0)
    {
        return YES;
    }
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length])
    {
        return YES;
    }
    return NO;
}

@end
