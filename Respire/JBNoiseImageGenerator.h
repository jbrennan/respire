//
//  JBNoiseImageGenerator.h
//  Respire
//
//  Created by Jason Brennan on 2012-12-02.
//  Copyright (c) 2012 Jason Brennan. All rights reserved.
//

#import <Foundation/Foundation.h>

extern CGImageRef generateNoiseImage(NSUInteger width, NSUInteger height, CGFloat factor);

@interface JBNoiseImageGenerator : NSObject
@end
