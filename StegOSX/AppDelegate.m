//
//  AppDelegate.m
//  StegOSX
//
//  Created by Anthony Picciano on 4/24/13.
//  Copyright (c) 2013 Anthony Picciano. All rights reserved.
//

#import "AppDelegate.h"
#import "PasswordGenerator.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    system("pwd");
    system("ls -la");
}

- (IBAction)generatePasscode:(id)sender
{
    [self.passcode setStringValue:[PasswordGenerator generatePasswordWithMinimumLength:12]];
}

- (IBAction)encodeClick:(id)sender
{
    if ([self.passcode.stringValue isEqualToString:@""]) {
        [self missingDataAlert:@"a passcode"];
        return;
    }
    
    if ([self.message.string isEqualToString:@""]) {
        [self missingDataAlert:@"a message"];
        return;
    }
    
    if (self.sourceImageView.image == nil) {
        [self missingDataAlert:@"a source image"];
        return;
    }
    
    /*system("StegOSX.app/Contents/Resources/outguess");
    
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:YES];
    [panel setCanChooseDirectories:NO];
    [panel setAllowsMultipleSelection:NO];
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        for (NSURL *url in [panel URLs]) {
            NSLog(@"URL: %@", [url absoluteString]);
        }
    }*/
}

- (IBAction)decodeClick:(id)sender
{
    if ([self.decodePasscode.stringValue isEqualToString:@""]) {
        [self missingDataAlert:@"a passcode"];
        return;
    }
    
    if (self.encodedImageView.image == nil) {
        [self missingDataAlert:@"an encoded image"];
        return;
    }
}

- (IBAction)viewEncodePanel:(id)sender
{
    [self.tabView selectTabViewItemAtIndex:0];
}

- (IBAction)viewDecodePanel:(id)sender
{
    [self.tabView selectTabViewItemAtIndex:1];
}

- (void)missingDataAlert:(NSString *)dataElement
{
    NSAlert *alert = [[NSAlert alloc] init];
    //[alert setAlertStyle:NSCriticalAlertStyle];
    [alert setMessageText:@"Missing Data"];
    [alert setInformativeText:[NSString stringWithFormat:@"You must include %@.", dataElement]];
    [alert runModal];
}

@end
