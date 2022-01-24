
//
//  DisplayWindowController.m
//  FlashSwitcher
//
//  Created by centurion on 8/30/16.
//  Copyright © 2016 Pilowar.com. All rights reserved.
//

#import "DisplayWindowController.h"
#import <Quartz/Quartz.h>
@interface DisplayWindowController ()
{
   NSTimer *timer;
   IBOutlet DisplayWindow * window;
}

@end

@implementation DisplayWindowController
@synthesize displayView = _displayView;
@synthesize bgImage = _bgImage;
@synthesize settingsCtrl = _settingsCtrl;
 
- (void)windowDidLoad {
    [super windowDidLoad];
   if ([_bgImage length] != 0 && ![_bgImage isEqualToString:@"noimg.png"])
   {
      [_displayView setBgImage :_bgImage];
      [_displayView setNeedsDisplay:YES];
   }
}

- (void)displayFlag : (NSString*)imgName
{
   [timer invalidate];
   NSLog(@"DisplayFla, %@",imgName);
   if ([imgName length] != 0 && ![imgName isEqualToString:@"noimg.png"])
   {
      [self setBgImage:imgName];
      NSSize bgSize =[[NSImage imageNamed:_bgImage] size];
      float k = [_settingsCtrl winWidth]/bgSize.width;
      int winHeight = (int)(bgSize.height*k);
      [self adjustWindow:[_settingsCtrl winWidth]:winHeight];
      [_displayView setBgImage :imgName];
      [_displayView display];
      [self.window setIsVisible:YES];
      [[self.window animator] setAlphaValue:[_settingsCtrl transparency]];
      [self fadeInWindow];
      timer = [NSTimer scheduledTimerWithTimeInterval:[_settingsCtrl displayinterval] target:self selector:@selector(closeWindow:) userInfo:nil repeats:NO];
   }
   else
   {
      [self closeWindow:timer];
   }

}

- (void)blinkFlash
{
   float flashTransparency = 0.3;
   float fadeDuration = 0.19;
   CGDisplayFadeReservationToken fadeToken;
   NSColor *colorToUse = [[NSColor colorWithWhite:1.0 alpha:0.9] colorUsingColorSpaceName: NSCalibratedRGBColorSpace];
   CGError error = CGAcquireDisplayFadeReservation (fadeDuration, &fadeToken);
   if (error != kCGErrorSuccess){
      NSLog(@"Error aquiring fade reservation. Will do nothing.");
      return;
   }
   CGDisplayFade (fadeToken, fadeDuration, kCGDisplayBlendNormal, flashTransparency, colorToUse.redComponent, colorToUse.greenComponent, colorToUse.blueComponent, true);
   CGDisplayFade (fadeToken, fadeDuration, flashTransparency, kCGDisplayBlendNormal,colorToUse.redComponent, colorToUse.greenComponent, colorToUse.blueComponent, false);
}

- (void) closeWindow:(NSTimer *)pTimer
{
   [self fadeOutWindow];
   [timer invalidate];
}

- (void)fadeInWindow
{
   [self.window setAlphaValue:0.f];
   [self.window makeKeyAndOrderFront:nil];
   [NSAnimationContext beginGrouping];
   [[NSAnimationContext currentContext] setDuration:[_settingsCtrl showUpInterwal]];
   [[self.window animator] setAlphaValue:[_settingsCtrl transparency]];
   [NSAnimationContext endGrouping];
}

- (void)fadeOutWindow
{
   [NSAnimationContext beginGrouping];
   __block __unsafe_unretained NSWindow *bself = self.window;
   [[NSAnimationContext currentContext] setDuration:[_settingsCtrl disappearInterval]];
   [[NSAnimationContext currentContext] setCompletionHandler:^{ 
      [bself orderOut:nil];
      [bself setAlphaValue:[_settingsCtrl transparency]];
   }];
   [[self.window animator] setAlphaValue:0.f];
   [NSAnimationContext endGrouping];
}

-(void)adjustWindow :(int) w :(int)h
{
   NSRect frame = [self.window frame];
   NSSize size = NSMakeSize(w,h);
   frame.origin.y -= frame.size.height; // remove the old height
   frame.origin.y += size.height; // add the new height
   frame.size = size;
   NSRect screen = [[self.window screen] frame];
   frame.origin.x = (screen.size.width - frame.size. width) / 2;
   frame.origin.y = (screen.size.height - frame.size.height) / 2;
   [self.window setFrameOrigin:frame.origin];
   [self.window setFrame: frame display: YES animate: NO];

}
@end
