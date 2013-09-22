//
//  myBackgroundView.h
//  SmartTip
//
//  Created by DP on 9/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBackgroundView : UIScrollView<UIPickerViewDelegate, UIPickerViewDataSource>
@property (strong) NSString *tipRate;
- (void) layoutSubviewsOnce;
- (void) clear;
- (NSString*) getTipRateTextBySlider;
-(void)showMessage:(NSString*) message;
typedef enum {
    PretaxField = 1001,
    PretaxLabel = 2001,
    AftertaxField = 1003,
    AftertaxLabel=2003,
    TotalField =1004,
    TotalLabel = 2004,
    NumOfGuysField =1005,
    NumOfGuysLabel=2005,
    NumOfGuysPickerView=3005,
    TipField = 1006,
    TipLabel = 2006,
    TipSlider =3006,
    EachBodyField =1007,
    EachBodyLabel = 2007,
    MessageLabel =2008,
    GoButton = 5000,
} TagName;

@end
