//
//  DisplayWindowController.h
//  FlashSwitcher
//
//  Created by centurion on 8/30/16.
//  Copyright © 2016 Pilowar.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "DisplayWindow.h"
#import "TransparentView.h"
#import "DisplayWindow.h"
#import "SettingsController.h"

@interface DisplayWindowController : NSWindowController
{
}
@property (strong) IBOutlet TransparentView *displayView;

@property (strong) NSString* bgImage;
@property (strong) SettingsController * settingsCtrl;

- (void)displayFlag : (NSString*)imgName;
- (void)blinkFlash;

- (void)fadeOutWindow;
- (void)fadeInWindow;
- (void)adjustWindow :(int) w :(int)h;
@end
