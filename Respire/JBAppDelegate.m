//
//  JBAppDelegate.m
//  Respire
//
//  Created by Jason Brennan on 2012-12-02.
//  Copyright (c) 2012 Jason Brennan. All rights reserved.
//

#import "JBAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "JBBreathingView.h"
#import "JBBlockTimer.h"

@implementation JBAppDelegate {
	JBBlockTimer *_timer;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	JBBreathingView *view = [[JBBreathingView alloc] initWithFrame:[[self.window contentView] bounds]];
	[self.window setContentView:view];
	
	NSTimeInterval fps = 1.0/24.0;
	_timer = [JBBlockTimer repeatingTimerWithTimeInterval:fps block:^{
		[view update];
	}];
}

@end
