//
//  TIPViewController.m
//  SmartTip
//
//  Created by DP on 9/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TIPViewController.h"
@interface TIPViewController()
- (NSString*)readTaxRateFromFile;
-(void)showMessage:(NSString*) message;
@end

@implementation TIPViewController
@synthesize model = __model;
@synthesize myView= __view;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    __model = [[MyModel alloc] init];

    [__view layoutSubviewsOnce];
    [self readTaxRateFromFile];
  
}

- (void)viewDidUnload
{
    [self setMyView:nil];
    __view = nil;
    __model = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
  
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return NO;
}

-(void)showMessage:(NSString*) message
{
    [__view showMessage:message];
}



- (void)saveTaxRateToFile:(NSString*) value {
    NSString *err = @"error! saveDataToFilewithKey: Value:";
    if ([value length]==0){
        [self showMessage: err];
        return;
    }
    NSDictionary *propertyList =[NSDictionary dictionaryWithObjectsAndKeys: value, @"taxRate", nil];
    NSData *data = [NSPropertyListSerialization dataFromPropertyList:propertyList format:NSPropertyListXMLFormat_v1_0 errorDescription: &err];
    if (!data) {
        [self showMessage: err];
        return;
    }
    NSString* path = @"taxrate.plist";
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager createFileAtPath:path contents:data attributes:propertyList]){
        [self showMessage: err];
    }
}

- (NSString*)readTaxRateFromFile{
    NSString *retVal=nil;
    NSFileManager* fileManager = [NSFileManager defaultManager];
    
    NSString* path = @"taxrate.plist";
    if(![fileManager fileExistsAtPath:path]){
        [self saveTaxRateToFile: @"8.25"];
        return @"8.25";
    }
    else {
        
        NSData *data = [fileManager contentsAtPath:path];
        NSString *err=@"error! readDataFromFileWithKey:";
        NSDictionary *propertyList = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:NULL errorDescription: &err];
        if (!propertyList) {
            [self showMessage:err];
        }
        else{
            return [propertyList objectForKey:@"taxRate"];
        }
    }
    return retVal;
}

- (IBAction)go:(id)sender {
    
    NSString *value= [(UITextField *)[__view viewWithTag:PretaxField] text];
    if ([value length]!=0) {
        [__model setPreTaxMoney:[NSDecimalNumber decimalNumberWithString:value]];
    }
    else
    {
        [__model setPreTaxMoney:nil];
    }
    
    value =  [(UITextField *)[__view viewWithTag:AftertaxField] text];
    if ([value length]!=0) {
        [__model setAfterTaxMoney:[NSDecimalNumber decimalNumberWithString:value]];
    }
    else
    {
        [__model setAfterTaxMoney:nil];
    }
    
    [__model setTipRate:[NSDecimalNumber decimalNumberWithString:[__view tipRate]]];
    
    value =  [(UITextField *)[__view viewWithTag:TotalField] text];
    if ([value length]!=0) {
        [__model setTotalMoney:[NSDecimalNumber decimalNumberWithString:value]];
    }
    else
    {
        [__model setTotalMoney:nil];
    }
    
    value =  [(UITextField *)[__view viewWithTag:NumOfGuysField] text];
    if ([value length]!=0) {
        [__model setGuysNum:[value intValue]];
    }
    else
    {
        [__model setGuysNum:0];
    }
    
    [__model go];
    

    
    value= [(UITextField *)[__view viewWithTag:TotalField] text];
    if ([value length]==0) 
    {
        value = [[__model totalMoney] stringValue];
        [(UITextField *)[__view viewWithTag:TotalField] setText: value];
        
        value= [(UITextField *)[__view viewWithTag:PretaxField] text];
        if ([value length]==0) {
            value = [[__model preTaxMoney] stringValue];
            [(UITextField *)[__view viewWithTag:PretaxField] setText: value];
        }
        
        value= [(UITextField *)[__view viewWithTag:AftertaxField] text];
        if ([value length]==0) {
            value = [[__model afterTaxMoney] stringValue];
            [(UITextField *)[__view viewWithTag:AftertaxField] setText: value];
        }
        
        value = [[__model tip] stringValue];
        if ([value length]!=0)
        {
            UITextField* textField =(UITextField*)[__view viewWithTag:TipField];
            [textField setText:[NSString stringWithFormat: @"%@ %@", [__view getTipRateTextBySlider], value]];
        }
    }

    value = [(UITextField *)[__view viewWithTag:NumOfGuysField] text];
    if ([value length]!=0)
    {
        NSDecimalNumber * temp = [__model eachBodyMoney];
        if (temp) {
            [(UILabel*)[__view viewWithTag:EachBodyLabel] setText:[NSString stringWithFormat: @"人均:  %@", [temp stringValue]]];
        }
    }
    
}

- (IBAction)clear:(id)sender {
    [__model clear];
    [__view clear];
}

@end
