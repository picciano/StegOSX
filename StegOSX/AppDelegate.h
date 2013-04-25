//
//  AppDelegate.h
//  StegOSX
//
//  Created by Anthony Picciano on 4/24/13.
//  Copyright (c) 2013 Anthony Picciano. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTabView *tabView;

// encode panel
@property (assign) IBOutlet NSTextField *passcode;
@property (assign) IBOutlet NSTextView *message;
@property (assign) IBOutlet NSImageView *sourceImageView;

// decode panel
@property (assign) IBOutlet NSTextField *decodePasscode;
@property (assign) IBOutlet NSTextView *decodedMessage;

- (IBAction)encodeClick:(id)sender;
- (IBAction)generatePasscode:(id)sender;

- (IBAction)decodeClick:(id)sender;

- (IBAction)viewEncodePanel:(id)sender;
- (IBAction)viewDecodePanel:(id)sender;

@end
