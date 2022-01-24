//
//  SettingsController.m
//  FlashSwitcher
//
//  Created by centurion on 8/29/16.
//  Copyright © 2016 Pilowar.com. All rights reserved.
//

#import "SettingsController.h"
#import <ServiceManagement/ServiceManagement.h>

@interface SettingsController ()
{
   NSMutableDictionary * prefs;
   
}
@end

@implementation SettingsController
@synthesize flashOnly;
@synthesize languages;
@synthesize showUpInterwal = _showUpInterwal;
@synthesize disappearInterval = _disappearInterval;
@synthesize displayinterval = _displayinterval;
@synthesize transparency = _transparency;
@synthesize winWidth = _winWidth;
@synthesize StartOnLogin;

- (void)windowDidLoad {
   [super windowDidLoad];
   [self loadDefaults];
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
   [self processLaunchOnLogin:[self StartOnLogin]];
}

- (IBAction)showWindow:(id)sender
{
   [[self cbStartOnLogin]setState:[self StartOnLogin]];
   [super showWindow: sender];
}

- (void) loadDefaults
{
   NSString *langPlistPath = [[NSBundle mainBundle] pathForResource: @"Langs" ofType: @"plist"];
   languages = [NSDictionary dictionaryWithContentsOfFile: langPlistPath];
   NSString *configPlistPath = [[NSBundle mainBundle] pathForResource: @"Config" ofType: @"plist"];
   prefs = [NSMutableDictionary dictionaryWithContentsOfFile:configPlistPath];   
   if (nil != [prefs objectForKey:@"FlashOnly"]) {
      flashOnly = [[prefs objectForKey:@"FlashOnly"]boolValue];
      [[self cbFlashOnly]setState:flashOnly];
   }
   if (nil != [prefs objectForKey:@"StartOnLogin"]) {
      flashOnly = [[prefs objectForKey:@"StartOnLogin"]boolValue];
      [[self cbStartOnLogin]setState:[self StartOnLogin]];
   }
   if (nil != [prefs objectForKey:@"TimeToShowUp"]) {
      _showUpInterwal = [[prefs objectForKey:@"TimeToShowUp"]floatValue];
   }
   if (nil != [prefs objectForKey:@"TimeToDisappear"]) {
      _disappearInterval = [[prefs objectForKey:@"TimeToDisappear"]floatValue];
   }
   if (nil != [prefs objectForKey:@"Transparency"]) {
      _transparency = [[prefs objectForKey:@"Transparency"]floatValue];
   }
   if (nil != [prefs objectForKey:@"TimeToDisplay"]) {
      _displayinterval = (int)[[prefs objectForKey:@"TimeToDisplay"]integerValue];
   }
   if (nil != [prefs objectForKey:@"PictureWidth"]) {
      _winWidth = [[prefs objectForKey:@"PictureWidth"]floatValue];
   }

}

-(void)saveDefaults
{
   NSString *configPlistPath = [[NSBundle mainBundle] pathForResource: @"Config" ofType: @"plist"];
   [prefs setValue:[NSNumber numberWithBool:[self flashOnly]] forKey:@"FlashOnly"];
   [prefs setValue:[NSNumber numberWithBool:[self StartOnLogin]] forKey:@"StartOnLogin"];

   [prefs writeToFile:configPlistPath atomically:YES];
}


-(IBAction)toggleFlashOnly:(id)sender
{
   [self setFlashOnly:[[self cbFlashOnly] state]];
   [self saveDefaults];
}

-(IBAction)toggleStartOnLogin:(id)sender
{
   [self setStartOnLogin:[[self cbStartOnLogin ] state]];
   [self processLaunchOnLogin:[[self cbStartOnLogin ] state]];
}

- (void)processLaunchOnLogin:(bool)state
{
   if (!SMLoginItemSetEnabled((__bridge CFStringRef)@"Pilowar.com.FlashSwitcherAutoLauncher", state)) {
      NSLog(@"Login Item Was Not Successful");
      [self setStartOnLogin:false];
   }
}


@end
