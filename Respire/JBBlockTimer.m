//
//  JBBlockTimer.m
//  Respire
//
//  Created by Jason Brennan on 2012-12-02.
//  Copyright (c) 2012 Jason Brennan. All rights reserved.
//

#import "JBBlockTimer.h"


@interface JBBlockTimer ()
@property (nonatomic, copy) JBBlockTimerBlock block;
@property (nonatomic, strong) dispatch_source_t source;
@end


@implementation JBBlockTimer

+ (instancetype)repeatingTimerWithTimeInterval:(NSTimeInterval)time block:(JBBlockTimerBlock)block {
	JBBlockTimer *timer = [JBBlockTimer new];
	timer.block = block;
	timer.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
	
	uint64_t nsec = (uint64_t)(time * NSEC_PER_SEC);
	dispatch_source_set_timer(timer.source, dispatch_time(DISPATCH_TIME_NOW, nsec), nsec, 0);
	dispatch_source_set_event_handler(timer.source, block);
	dispatch_resume(timer.source);
	
	
	return timer;
}


- (void)dealloc {
	[self invalidate];
}


- (void)invalidate {	
	if (self.source) {
		dispatch_source_cancel(self.source);
		self.source = nil;
	}
	self.block = nil;
}


@end
