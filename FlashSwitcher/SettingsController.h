//
//  SettingsController.h
//  FlashSwitcher
//
//  Created by centurion on 8/29/16.
//  Copyright © 2016 Pilowar.com. All rights reserved.
//
 #import <Cocoa/Cocoa.h>

@interface SettingsController : NSWindowController
@property (strong) NSDictionary * languages;
@property (atomic, assign) BOOL StartOnLogin;
@property BOOL flashOnly;
@property int displayinterval;
@property float showUpInterwal;
@property float transparency;
@property float disappearInterval;
@property float winWidth;

@property (assign) IBOutlet NSButton *cbStartOnLogin;
@property (assign) IBOutlet NSButton *cbFlashOnly;

-(IBAction) toggleFlashOnly:(id)sender;
-(IBAction) toggleStartOnLogin:(id)sender;
- (void)processLaunchOnLogin:(bool)state;
-(void) saveDefaults;
-(void) loadDefaults;

@end
