//
//  JBBreathingView.m
//  Respire
//
//  Created by Jason Brennan on 2012-12-02.
//  Copyright (c) 2012 Jason Brennan. All rights reserved.
//

#import "JBBreathingView.h"
#import <QuartzCore/QuartzCore.h>
#import "JBNoiseImageGenerator.h"

#define kNumPoints 100
#define kMultiplier 300

#define kTotoroLightGrey [NSColor colorWithCalibratedRed:0.334 green:0.349 blue:0.337 alpha:1.000]
#define kTotoroDarkGrey [NSColor colorWithCalibratedRed:0.216 green:0.254 blue:0.253 alpha:1.000]

@implementation JBBreathingView {
	NSMutableArray *noise;
	CGPoint points[kNumPoints];
	CGFloat frameCount;
}

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
		noise = [NSMutableArray new];
		const NSUInteger framesOfNoise = 48;
		for (NSUInteger index = 0; index < framesOfNoise; index++) {
			CGImageRef noisy = generateNoiseImage(128, 128, 0.020f);

			[noise addObject:(__bridge id)(noisy)];
		}
		
		for (NSUInteger i = 0; i < kNumPoints; i++) {
			// fill up the points
//			CGFloat x = ((CGFloat)i)/(CGFloat)kMultiplier; // gives a value between 0..1
//			CGFloat y = sinf(x);
//			points[i] = CGPointMake(x * (CGFloat)kMultiplier * 10.0f, y * (CGFloat)kMultiplier * 10.0f);
//			NSLog(@"Point (%f, %f) added: %@", x, y, NSStringFromPoint(points[i]));
			
			CGFloat y = ((200.0f/4.0f) * sin(((i * 4) % 360) * (M_PI)/180.0f)) + 200/2;
			points[i] = CGPointMake(i, y);
		}
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	CGRect bounds = [self bounds];
    [kTotoroDarkGrey set];
	NSBezierPath *darkPath = [NSBezierPath bezierPathWithRect:[self bounds]];
	[darkPath fill];
	
	
	// Render the lighter circle
	NSBezierPath *lightPath = [NSBezierPath bezierPathWithOvalInRect:bounds];
	NSAffineTransform *transform = [NSAffineTransform transform];
	[transform translateXBy:CGRectGetMidX(bounds) - 50 yBy:CGRectGetMidY(bounds) - 50];
	
	//CGFloat scale = 0.15 * sinf(frameCount/2) + 1;
	CGFloat scale = 0.5 * powf(cosf(frameCount * 0.5), 4) + 1;
	[transform scaleBy:(scale)];
	[lightPath transformUsingAffineTransform:transform];
	[kTotoroLightGrey set];
	[lightPath fill];
	
	// Pick a random noise image to render
	CGImageRef image = (__bridge CGImageRef)([noise objectAtIndex:(arc4random() % [noise count])]);
	[NSGraphicsContext saveGraphicsState];
    [[NSGraphicsContext currentContext] setCompositingOperation:NSCompositePlusLighter];
    CGRect noisePatternRect = CGRectZero;
    noisePatternRect.size = CGSizeMake(CGImageGetWidth(image), CGImageGetHeight(image));
    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextDrawTiledImage(context, noisePatternRect, image);
    [NSGraphicsContext restoreGraphicsState];
	
	[[NSColor whiteColor] set];
	// Draw a mutable path of our points
//	CGMutablePathRef path = CGPathCreateMutable();
//	
//	CGPathAddLines(path, NULL, points, kNumPoints);
//	CGContextAddPath(context, path);
//	CGContextSetLineWidth(context, 2.0f);
//	CGContextStrokePath(context);
//	
//	CGPathRelease(path);
	
}


- (void)update {
	frameCount += 1.0f/24.0f;
	[self setNeedsDisplay:YES];
}

@end
