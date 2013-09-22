//
//  MyModel.h
//  SmartTip
//
//  Created by DP on 10/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject
@property  (strong) NSDecimalNumber* preTaxMoney;
@property  (strong) NSDecimalNumber* afterTaxMoney;
@property  (strong) NSDecimalNumber* defaultTaxRate;
@property (strong) NSDecimalNumber* tipRate;
@property (strong) NSDecimalNumber* tip;
@property (strong) NSDecimalNumber* totalMoney;
@property int guysNum;
@property (strong) NSDecimalNumber* eachBodyMoney;
@property int adjustDegree;



-(MyModel *)init;
-(void)clear;
-(void)go;
-(void)adjustTotal:(BOOL)up;
-(void)adjustTip:(int)degree;

@end
