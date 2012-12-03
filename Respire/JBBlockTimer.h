//
//  JBBlockTimer.h
//  Respire
//
//  Created by Jason Brennan on 2012-12-02.
//  Copyright (c) 2012 Jason Brennan. All rights reserved.
//
//
//  Basically a reimplementation of RNTimer just because I wanted to see how it worked.


#import <Foundation/Foundation.h>

typedef void(^JBBlockTimerBlock)(void);

@interface JBBlockTimer : NSObject

+ (instancetype)repeatingTimerWithTimeInterval:(NSTimeInterval)time block:(JBBlockTimerBlock)block;

@end
