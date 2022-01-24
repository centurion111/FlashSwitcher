//
//  TransparentView.m
//  FlashSwitcher
//
//  Created by centurion on 8/30/16.
//  Copyright © 2016 Pilowar.com. All rights reserved.
//

#import "TransparentView.h"

@implementation TransparentView
@synthesize bgImage = _bgImage;

- (void)drawRect:(NSRect)dirtyRect
{
   [super drawRect:dirtyRect];
   [[[NSColor  clearColor] colorWithAlphaComponent:1 ] setFill];
   NSRectFill(dirtyRect);
   //drawing the border
   NSBezierPath * path;
   path = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:5 yRadius:5];
   //setting the border color as white
   [[NSColor whiteColor] set];
   [path stroke];
  // [[NSImage imageNamed:_bgImage] drawInRect:dirtyRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1]; // Passing NSZeroRect causes the entire image to draw.
   NSDictionary *hintz = @{NSImageHintInterpolation:
                             [NSNumber numberWithInt:NSImageInterpolationLow]};
   [[NSImage imageNamed:_bgImage] drawInRect:dirtyRect fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1 respectFlipped:YES hints:hintz]; // Passing NSZeroRect causes the entire image to draw.

}



@end
