//
//  AppDelegate.m
//  FlashSwitcherAutoLauncher
//
//  Created by centurion on 9/1/16.
//  Copyright © 2016 Pilowar.com. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
   // Check if main app is already running; if yes, do nothing and terminate helper app
   BOOL alreadyRunning = NO;
   NSArray *running = [[NSWorkspace sharedWorkspace] runningApplications];
   for (NSRunningApplication *app in running) {
      if ([[app bundleIdentifier] isEqualToString:@"Pilowar.com.FlashSwitcher"]) {
         alreadyRunning = YES;
      }
   }
   
   if (!alreadyRunning) {
      NSString *path = [[NSBundle mainBundle] bundlePath];
      NSArray *p = [path pathComponents];
      NSMutableArray *pathComponents = [NSMutableArray arrayWithArray:p];
      [pathComponents removeLastObject];
      [pathComponents removeLastObject];
      [pathComponents removeLastObject];
      [pathComponents addObject:@"MacOS"];
      [pathComponents addObject:@"FlashSwitcher"];
      NSString *newPath = [NSString pathWithComponents:pathComponents];
      [[NSWorkspace sharedWorkspace] launchApplication:newPath];
   }
   [NSApp terminate:nil];

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
   // Insert code here to tear down your application
}

@end
