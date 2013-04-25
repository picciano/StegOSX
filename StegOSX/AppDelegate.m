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
}

- (IBAction)generatePasscode:(id)sender
{
    [self.passcode setStringValue:[PasswordGenerator generatePasswordWithMinimumLength:12]];
}

- (IBAction)encodeClick:(id)sender
{
    NSError *error;
    
    // validate user input
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
    
    //save message to temporary file
    NSString *messageTempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"message.txt"];
    NSLog(@"messageTempFile: %@", messageTempFile);
    NSData *data = [self.message.string dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:messageTempFile atomically:YES];
    
    //save image to temporary file
    NSString *sourceImageTempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"source.jpg"];
    NSArray *representations = [self.sourceImageView.image representations];
    NSNumber *compressionFactor = [NSNumber numberWithFloat:0.9];
    NSDictionary *imageProps = [NSDictionary dictionaryWithObject:compressionFactor
                                                           forKey:NSImageCompressionFactor];
    NSData *bitmapData = [NSBitmapImageRep representationOfImageRepsInArray:representations
                                                                  usingType:NSJPEGFileType
                                                                 properties:imageProps];
    [bitmapData writeToFile:sourceImageTempFile atomically:YES];
    
    // user selects filename to save
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setTitle:@"Save Encoded JPEG Image"];
    [panel setPrompt:@"Encode"];
    [panel setAllowedFileTypes:[NSArray arrayWithObjects:@"jpg", nil]];
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        NSString *encodedImageFile = [[panel URL] path];
        
        // call outguess to encode image
        NSString *outguess = [NSString stringWithFormat:@"StegOSX.app/Contents/Resources/outguess -k \"%@\" -d \"%@\" -e \"%@\" \"%@\"", self.passcode.stringValue, messageTempFile, sourceImageTempFile, encodedImageFile];
        system([outguess cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    //remove temporary files
    [[NSFileManager defaultManager] removeItemAtPath:messageTempFile error:&error];
    [[NSFileManager defaultManager] removeItemAtPath:sourceImageTempFile error:&error];
}

- (IBAction)decodeClick:(id)sender
{
    NSError *error;
    
    // validate user input
    if ([self.decodePasscode.stringValue isEqualToString:@""]) {
        [self missingDataAlert:@"a passcode"];
        return;
    }
    
    // determine temp message file location
    NSString *messageTempFile = [NSTemporaryDirectory() stringByAppendingPathComponent:@"message.txt"];
    
    // user selects encoded image
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setTitle:@"Choose Encoded Image"];
    [panel setPrompt:@"Decode"];
    [panel setAllowedFileTypes:[NSArray arrayWithObjects:@"jpg", nil]];
    
    NSInteger clicked = [panel runModal];
    
    if (clicked == NSFileHandlingPanelOKButton) {
        NSString *encodedImageFile = [[panel URL] path];
        
        // call outguess to encode image
        NSString *outguess = [NSString stringWithFormat:@"StegOSX.app/Contents/Resources/outguess -k \"%@\" -e -r \"%@\" \"%@\"", self.decodePasscode.stringValue, encodedImageFile, messageTempFile];
        system([outguess cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    // display the message
    [self.decodedMessage setString:[NSString stringWithContentsOfFile:messageTempFile encoding:NSUTF8StringEncoding error:&error]];
    
    //remove temporary files
    [[NSFileManager defaultManager] removeItemAtPath:messageTempFile error:&error];
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
