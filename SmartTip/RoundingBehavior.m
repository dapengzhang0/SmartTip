//
//  RoundingBehavior.m
//  SmartTip
//
//  Created by DP on 10/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RoundingBehavior.h"

@implementation RoundingBehavior{
    short _scale;
    NSRoundingMode _mode;
}


-(short)scale
{
    return _scale;
}
-(NSRoundingMode)roundingMode{
    return _mode;
}

-(RoundingBehavior*)initWithScale:(short) scale andMode:(NSRoundingMode) mode
{
    self=[super init];
    _scale = scale;
    _mode = mode;
    return self;
}

- (NSDecimalNumber *)exceptionDuringOperation:(SEL)operation error:(NSCalculationError)error leftOperand:(NSDecimalNumber *)leftOperand rightOperand:(NSDecimalNumber *)rightOperand{
    return nil;
}
@end
