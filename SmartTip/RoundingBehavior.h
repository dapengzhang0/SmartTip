//
//  RoundingBehavior.h
//  SmartTip
//
//  Created by DP on 10/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RoundingBehavior : NSObject<NSDecimalNumberBehaviors>
-(short)scale;
-(NSRoundingMode)roundingMode;
-(RoundingBehavior*)initWithScale:(short) scale andMode:(NSRoundingMode) mode;
@end
