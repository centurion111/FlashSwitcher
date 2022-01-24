//
//  AppDelegate.h
//  FlashSwitcher
//
//  Created by centurion on 8/29/16.
//  Copyright © 2016 Pilowar.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@interface AppDelegate : NSObject <NSApplicationDelegate>
- (IBAction)ShowSettings:(id)pId;
-(void)updateControl:(NSTextField*)control withHyperlink:(NSString*)strURL;
-(NSString*)flagImgToDisplay;
@end

