//
//  DisplayWindow.m
//  FlashSwitcher
//
//  Created by centurion on 8/30/16.
//  Copyright © 2016 Pilowar.com. All rights reserved.
//

#import "DisplayWindow.h"

@implementation DisplayWindow
@synthesize showUpTime = _showUpTime;

//--------(nonatomic) ----------------------------------
- (id)initWithContentRect:(NSRect)contentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)bufferingType
                    defer:(BOOL)flag
//------------------------------------------
{   
   self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:bufferingType defer:flag];
   if ( self ) {
      [self setOpaque:NO]; // Needed so we can see through it when we have clear stuff on top
      [self setHasShadow:NO];
      winColor = [NSColor clearColor];
      [self setBackgroundColor:winColor];
      [self setLevel: NSStatusWindowLevel]; // Let's make it sit on top of everything else
      [self setAlphaValue:0.1];
      [self setIgnoresMouseEvents:YES];

   }
   return self;
}

//------------------------------------------
-(void)setIsVisible:(BOOL)flag
//------------------------------------------
{
   [self orderFrontRegardless];
   [self setAccessibilityModal:YES];
   [super setIsVisible:flag];
}

//------------------------------------------
- (BOOL)canBecomeKeyWindow
//------------------------------------------
{
   return YES;
}

- (BOOL)animationShouldStart:(NSAnimation*) _anim
{
   return YES;
}

@end
