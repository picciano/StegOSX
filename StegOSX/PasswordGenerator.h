//
//  PasswordGenerator.h
//  StegOSX
//
//  Created by Anthony Picciano on 4/24/13.
//  Copyright (c) 2013 Anthony Picciano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PasswordGenerator : NSObject

+ (NSString *)generatePasswordWithMinimumLength:(int)min;

@end
