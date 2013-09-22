//
//  TIPViewController.h
//  SmartTip
//
//  Created by DP on 9/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBackgroundView.h"
#import "MyModel.h"

@interface TIPViewController : UIViewController


@property (strong, nonatomic) MyModel* model;

@property (weak, nonatomic) IBOutlet MyBackgroundView *myView;

- (IBAction)go:(id)sender;
- (IBAction)clear:(id)sender;



@end
