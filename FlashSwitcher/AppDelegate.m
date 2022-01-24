//
//  AppDelegate.m
//  FlashSwitcher
//
//  Created by centurion on 8/29/16.
//  Copyright © 2016 Pilowar.com. All rights reserved.
//
#import <ServiceManagement/ServiceManagement.h>

#import "SettingsController.h"
#import "DisplayWindowController.h"
#import "AppDelegate.h"
@import Carbon;

@interface HyperLinkedTextField : NSTextField
@end
@implementation HyperLinkedTextField
- (void)resetCursorRects
{
   [self addCursorRect:[self bounds] cursor:[NSCursor pointingHandCursor]];
}
@end

@interface AppDelegate ()
@property (strong, nonatomic) NSStatusItem *statusBar;
@property (assign) IBOutlet NSMenu * statusMenu;
@property (weak) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSPanel * aboutWindow;
@property (strong) SettingsController * settingsCtrl;
@property (strong) DisplayWindowController * displayCtrl;
@property (weak) IBOutlet NSTextField * verLabel;
@property (weak) IBOutlet HyperLinkedTextField * rateAppLink;
@property (weak) IBOutlet HyperLinkedTextField * feedbackLink;

@end

@implementation AppDelegate
@synthesize statusBar = _statusBar;
@synthesize statusMenu = _statusMenu;
@synthesize settingsCtrl = _settingsCtrl;
@synthesize displayCtrl = _displayCtrl;
@synthesize verLabel = _verLabel;
@synthesize rateAppLink = _rateAppLink;
@synthesize feedbackLink = _feedbackLink;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
   // Insert code here to initialize your application
   [_aboutWindow setIsVisible:NO];
   _settingsCtrl = [[SettingsController alloc]initWithWindowNibName: @"SettingsController"];
   [_settingsCtrl loadDefaults];
   _displayCtrl = [[DisplayWindowController alloc]initWithWindowNibName: @"DisplayWindowController"];
   [[_displayCtrl displayView]setBgImage:[self flagImgToDisplay]];
   [[_displayCtrl displayView]setNeedsDisplay:YES];
   [_displayCtrl setSettingsCtrl:_settingsCtrl];
   [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                       selector:@selector(InputSourceChanged:)
                                                           name:(__bridge NSString*)kTISNotifySelectedKeyboardInputSourceChanged
                                                         object:nil
                                             suspensionBehavior:NSNotificationSuspensionBehaviorDeliverImmediately];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
   // Insert code here to tear down your application
}

- (void) awakeFromNib {
   self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
   self.statusBar.menu = self.statusMenu;
   NSImage *icon;
   icon.template = YES;
   icon = [NSImage imageNamed:@"icon.png"];
   icon.template = YES;
   self.statusBar.highlightMode = YES;
   self.statusBar.button.image = icon;
   [_verLabel setStringValue: [NSString stringWithFormat:@"Version: %@", [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]]];
   [self updateControl:_rateAppLink withHyperlink:@"https://itunes.apple.com/app/id1157313107"];
   [self updateControl:_feedbackLink withHyperlink:@"https://itunes.apple.com/app/id1157313107"];
}

- (IBAction)ShowAbout:(id)pId; {
   NSLog(@"ShowAbout");
   [_aboutWindow setIsVisible:![_aboutWindow isVisible]];
   if ([_aboutWindow isVisible])
   {
      [_aboutWindow makeKeyAndOrderFront:self];
      [NSApp activateIgnoringOtherApps:YES];
   }
   else
   {
      [_aboutWindow orderOut:self];
   }
}

- (IBAction)ShowSettings:(id)pId
{
   NSLog(@"ShowSettings");
   [_settingsCtrl showWindow:[_settingsCtrl window]];
}

- (void) InputSourceChanged:(NSNotification*)notification
{
   //when input source changed, create window and show it in a new thread
   if ([_settingsCtrl flashOnly])
   {
      [_displayCtrl blinkFlash];
   }
   else
   {
      [_displayCtrl displayFlag:[self flagImgToDisplay]];
   }
}

-(NSString*)flagImgToDisplay
{
   TISInputSourceRef inputSource = TISCopyCurrentKeyboardInputSource();
   NSString *langValue = (__bridge NSString *)TISGetInputSourceProperty(inputSource, kTISPropertyInputSourceID);
   NSString* res;
   res = [[_settingsCtrl languages] valueForKey:langValue];
   NSLog(@"Switched to Layout: %@",langValue);
   return res;
}

-(void)updateControl:(NSTextField*)control withHyperlink:(NSString*)strURL
{
   // both are needed, otherwise hyperlink won't accept mousedown
   [control setAllowsEditingTextAttributes: YES];
   [control setSelectable: YES];
   
   NSURL* url = [NSURL URLWithString:strURL];
   
   NSAttributedString* attrString = [control attributedStringValue];
   
   NSMutableAttributedString* attr = [[NSMutableAttributedString alloc] initWithAttributedString:attrString];
   NSRange range = NSMakeRange(0, [attr length]);
   
   [attr addAttribute:NSLinkAttributeName value:url range:range];
   [attr addAttribute:NSForegroundColorAttributeName value:[NSColor blueColor] range:range ];
   [attr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInt:NSUnderlineStyleSingle] range:range];
   
   [control setAttributedStringValue:attr];
}

@end
