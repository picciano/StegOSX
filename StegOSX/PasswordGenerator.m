//
//  PasswordGenerator.m
//  StegOSX
//
//  Created by Anthony Picciano on 4/24/13.
//  Copyright (c) 2013 Anthony Picciano. All rights reserved.
//

#import "PasswordGenerator.h"

@implementation PasswordGenerator

#define NUMERICS @"0123456789"
#define SYMBOLS @" !@#$%^&*()_-,.<>/?+="
#define LETTERS_VOWELS @"aeiouy"
#define LETTERS_CONSONANTS @"bdfghjklmnprstvwz"

+ (NSString *)generatePasswordWithMinimumLength:(int)min
{
    NSMutableString *password = [NSMutableString stringWithFormat:@"%@%@%@%@",
            [PasswordGenerator makePhoneme],
            [PasswordGenerator makePhoneme],
            [PasswordGenerator someItemFromString:SYMBOLS],
            [PasswordGenerator someItemFromString:NUMERICS]];
    
    while ([password length] < min) {
        [password appendString:[PasswordGenerator someItemFromString:NUMERICS]];
    }
    
    return [NSString stringWithString:password];
}

+ (NSString *)makePhoneme
{
    return [NSString stringWithFormat:@"%@%@%@",
            [PasswordGenerator someItemFromString:LETTERS_CONSONANTS],
            [PasswordGenerator someItemFromString:LETTERS_VOWELS],
            [PasswordGenerator someItemFromString:LETTERS_CONSONANTS]];
}

+ (NSString *)someItemFromString:(NSString *)source
{
    return [source substringWithRange:NSMakeRange(arc4random() % [source length], 1)];
}

@end
