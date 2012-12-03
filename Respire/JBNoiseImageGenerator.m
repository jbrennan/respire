//
//  JBNoiseImageGenerator.m
//  Respire
//
//  Created by Jason Brennan on 2012-12-02.
//  Copyright (c) 2012 Jason Brennan. All rights reserved.
//

#import "JBNoiseImageGenerator.h"

// c.f.: http://stackoverflow.com/questions/8766239/mac-app-store-like-toolbar-with-noise
CGImageRef generateNoiseImage(NSUInteger width, NSUInteger height, CGFloat factor) {
	NSUInteger size = width * height;
    char *rgba = (char *)malloc(size);
    
	for(NSUInteger i=0; i < size; ++i){
		rgba[i] = arc4random() % 256 * factor;
	}
	
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapContext =
    CGBitmapContextCreate(rgba, width, height, 8, width, colorSpace, kCGImageAlphaNone);
	
    CFRelease(colorSpace);
    free(rgba);
	
    CGImageRef image = CGBitmapContextCreateImage(bitmapContext);
    CFRelease(bitmapContext);
    return image;
}


@implementation JBNoiseImageGenerator

- (void)usage {
	static CGImageRef noisePattern = nil;
	if (noisePattern == nil) noisePattern = generateNoiseImage(128, 128, 0.015);
	
	[NSGraphicsContext saveGraphicsState];
	[[NSGraphicsContext currentContext] setCompositingOperation:NSCompositePlusLighter];
	CGRect noisePatternRect = CGRectZero;
	noisePatternRect.size = CGSizeMake(CGImageGetWidth(noisePattern), CGImageGetHeight(noisePattern));
	CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
	CGContextDrawTiledImage(context, noisePatternRect, noisePattern);
	[NSGraphicsContext restoreGraphicsState];
}

@end
