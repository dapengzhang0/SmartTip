//
//  MyModel.m
//  SmartTip
//
//  Created by DP on 10/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyModel.h"
#import "RoundingBehavior.h"

@implementation MyModel
@synthesize preTaxMoney = _preTaxMoney;
@synthesize afterTaxMoney = _afterTaxMoney;
@synthesize defaultTaxRate = _defaultTaxRate;
@synthesize tipRate = _tipRate;
@synthesize tip = _tip;
@synthesize totalMoney = _totalMoney;
@synthesize guysNum;
@synthesize eachBodyMoney = _eachBodyMoney;
@synthesize adjustDegree;
-(MyModel *)init
{
    self = [super init];
    [self setDefaultTaxRate : [NSDecimalNumber decimalNumberWithMantissa: 825 exponent:-4 isNegative:NO]];
    [self clear];
    return self;
}
-(void)clear
{
    _tipRate = [NSDecimalNumber decimalNumberWithMantissa: 15 exponent: -2 isNegative: NO];
    _preTaxMoney = nil;
    _afterTaxMoney = nil;
    _tip = nil;
    _totalMoney = nil;
    guysNum = 0;
    _eachBodyMoney = nil;
    adjustDegree =0;
}
-(void)adjust:(int)adjustedDegree{
    
}
-(void)go{
    RoundingBehavior * round2 = [[RoundingBehavior alloc] initWithScale:2 andMode:NSRoundBankers];
    RoundingBehavior * round3 = [[RoundingBehavior alloc] initWithScale:3 andMode:NSRoundBankers];
    if (!_totalMoney)
    {
        if (_preTaxMoney && _afterTaxMoney)
        {
            _tip = [_preTaxMoney decimalNumberByMultiplyingBy: _tipRate];
            _tip = [_tip decimalNumberByRoundingAccordingToBehavior:round2];
            _totalMoney = [_afterTaxMoney decimalNumberByAdding: _tip];
        }
        else if (!_preTaxMoney && _afterTaxMoney)
        {
            _preTaxMoney = [_afterTaxMoney decimalNumberByDividingBy: [_defaultTaxRate decimalNumberByAdding:[NSDecimalNumber one]]];
            _preTaxMoney= [_preTaxMoney decimalNumberByRoundingAccordingToBehavior:round2];
            _tip = [_preTaxMoney decimalNumberByMultiplyingBy: _tipRate];
            _tip = [_tip decimalNumberByRoundingAccordingToBehavior:round2];
            _totalMoney = [_afterTaxMoney decimalNumberByAdding: _tip];
        }
        else if (_preTaxMoney && !_afterTaxMoney )
        {
            _afterTaxMoney = [_preTaxMoney decimalNumberByMultiplyingBy:[_defaultTaxRate decimalNumberByAdding:[NSDecimalNumber one]]];
            _afterTaxMoney = [_afterTaxMoney decimalNumberByRoundingAccordingToBehavior:round2];
            _tip = [_preTaxMoney decimalNumberByMultiplyingBy: _tipRate];
            _tip = [_tip decimalNumberByRoundingAccordingToBehavior:round2];
            _totalMoney = [_afterTaxMoney decimalNumberByAdding: _tip];
        }
    }
    if (_totalMoney)
    {
        [self adjust:adjustDegree];
        if (guysNum>0) {
            _eachBodyMoney = [_totalMoney decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithMantissa:guysNum exponent:0 isNegative:NO]];
            _eachBodyMoney = [_eachBodyMoney decimalNumberByRoundingAccordingToBehavior:round3];
        }
    }
    
}
-(void)adjustTotal:(BOOL)up{
    
}

-(void)adjustTip:(int)ajustDegree{
    
}
@end
