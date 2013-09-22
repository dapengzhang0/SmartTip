//
//  myBackgroundView.m
//  SmartTip
//
//  Created by DP on 9/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyBackgroundView.h"
#import "TIPViewController.h"


@interface MyBackgroundView()
+ (BOOL) isTextValidNumber: (NSString*) text;

- (IBAction)dragInside:(id)sender;
- (IBAction)textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction) textChanged:(UITextField *)sender;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)sliderMoved:(UISlider*)sender;

- (void)hideKeyboard;
- (BOOL)isAllInputValid;

@end

@implementation MyBackgroundView

@synthesize tipRate=_tipRate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)hideKeyboard
{
    NSArray *subviews =[self subviews];
    for (UIView * temp in subviews) {
        if ([temp isKindOfClass: [UITextField class]])
        {
            [(UITextField *)temp resignFirstResponder];
        }
    }
    [self setContentOffset:CGPointMake(0,0) animated:YES];
}


//////// actions //////////////////
- (IBAction)dragInside:(id)sender
{
    [self hideKeyboard];
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{
    

    if([textField tag]==NumOfGuysField)
    {
        [self setContentOffset:CGPointMake(0,75) animated:YES];
    }   
    else {
        [self setContentOffset:CGPointMake(0,25) animated:YES];
    }
}
- (IBAction) textChanged:(UITextField *)sender;
{
    if ([MyBackgroundView isTextValidNumber: [sender text]])
    {
    	[sender setTextColor:[UIColor blackColor]];
        if ([self isAllInputValid]) 
        {
            [(UIButton*)[self viewWithTag:GoButton] setEnabled: YES];
        }
    } else 
    {
    	[sender setTextColor:[UIColor redColor]];
        [(UIButton*)[self viewWithTag:GoButton] setEnabled: NO];
    }
}
- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
}
- (IBAction)sliderMoved:(UISlider*)sender
{
    float v= [sender value];
    UITextField* tipField = (UITextField*)[self viewWithTag:TipField];
    if (v<0.01f) 
    {
        [tipField setText:@"(0\%)"]; 
        _tipRate = @"0";
    }
    else if (v>=0.01f && v<0.2f)
    {
        [tipField setText:@"(5\%)"]; 
        _tipRate = @"0.05";
    }
    else if (v>=0.2f && v<0.4f)
    {
        [tipField setText:@"(10\%)"]; 
        _tipRate = @"0.1";
    }
    else if (v>=0.4f && v<0.6f)
    {
        [tipField setText:@"(15\%)"]; 
        _tipRate = @"0.15";
    }
    else if (v>=0.6f && v<0.8f)
    {
        [tipField setText:@"(18\%)"]; 
        _tipRate = @"0.18";
    }
    else if (v>=0.8f && v<0.99f)
    {
        [tipField setText:@"(20\%)"]; 
        _tipRate = @"0.2";
    }
    else if (v>=0.99f)
    {
        [tipField setText:@"(25\%)"]; 
        _tipRate = @"0.25";
    }
    [(UITextField*)[self viewWithTag:TotalField] setText:@""];
    [(UILabel*)[self viewWithTag:EachBodyLabel] setText:@"人均:"];
}
- (NSString*) getTipRateTextBySlider
{
    float v = [(UISlider*)[self viewWithTag:TipSlider] value];
    if (v<0.01f) 
    {
        return @"(0\%)"; 
        
    }
    else if (v>=0.01f && v<0.2f)
    {
        return @"(5\%)";
    }
    else if (v>=0.2f && v<0.4f)
    {
        return @"(10\%)";
    }
    else if (v>=0.4f && v<0.6f)
    {
        return @"(15\%)";
    }
    else if (v>=0.6f && v<0.8f)
    {
        return @"(18\%)";
    }
    else if (v>=0.8f && v<0.99f)
    {
        return @"(20\%)";
    }
    else if (v>=0.99f)
    {
        return @"(25\%)";
    }
    return @"(15\%)";
}

-(void) touchesBegan: (NSSet*) touches withEvent: (UIEvent*) event
{    

    [self hideKeyboard];
    [super touchesBegan: touches withEvent: event];
}

-(BOOL) touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    if ([view isKindOfClass:[UITextField class]])
    {
        return YES;
    }
    [self hideKeyboard];
    return YES;
}



- (void) layoutSubviewsOnce
{
    
    UITextField * textField = (UITextField*)[self viewWithTag: PretaxField];
    [textField setLeftView:[self viewWithTag: PretaxLabel]];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField
        addTarget:self action:@selector(dragInside:) forControlEvents:UIControlEventTouchDragInside];
    [textField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    [textField setKeyboardType:UIKeyboardTypeDecimalPad];
    
    
    textField =(UITextField*)[self viewWithTag: AftertaxField];
    [textField setLeftView:[self viewWithTag: AftertaxLabel]];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField
        addTarget:self action:@selector(dragInside:) forControlEvents:UIControlEventTouchDragInside];
    [textField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    [textField setKeyboardType:UIKeyboardTypeDecimalPad];
    
    
    
    textField =(UITextField*)[self viewWithTag: TipField];
    [textField setLeftView:[self viewWithTag: TipLabel]];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField setEnabled:NO];   
    [textField setText:@"(15\%)"];
    _tipRate = @"0.15";
    
    
    textField =(UITextField*)[self viewWithTag: NumOfGuysField];
    [textField setLeftView:[self viewWithTag: NumOfGuysLabel]];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField
        addTarget:self action:@selector(dragInside:) forControlEvents:UIControlEventTouchDragInside];
    [textField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    UIPickerView* pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 300, 200)];
    [pickerView setTag : NumOfGuysPickerView];
    [pickerView setHidden:NO];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [pickerView reloadAllComponents];
    [textField setInputView:pickerView];

    
    
    textField = (UITextField*)[self viewWithTag: TotalField];
    [textField setLeftView:[self viewWithTag: TotalLabel]];
    [textField setLeftViewMode:UITextFieldViewModeAlways];
    [textField
        addTarget:self action:@selector(dragInside:) forControlEvents:UIControlEventTouchDragInside]; 
    [textField addTarget:self action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [textField addTarget:self action:@selector(textFieldDidEndEditing:) forControlEvents:UIControlEventEditingDidEnd];
    [textField setKeyboardType:UIKeyboardTypeDecimalPad];
    
    UISlider * slider = (UISlider*)[self viewWithTag:TipSlider];
    [slider addTarget:self action:@selector(sliderMoved:) forControlEvents: UIControlEventValueChanged];
    
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager* fileManager =[NSFileManager defaultManager];
    [fileManager changeCurrentDirectoryPath:path];
    
    //[(UITextView*)[self viewWithTag:MessageLabel] setText:[fileManager currentDirectoryPath]];

}


-(void) clear
{
    NSArray *subviews =[self subviews];
    for (UIView * temp in subviews) {
        if ([temp isKindOfClass: [UITextField class]])
        {
            [(UITextField *)temp setText:@""];
        }
    }
    [(UILabel*)[self viewWithTag:TipField] setText:@"(15\%)"];
    [(UISlider*)[self viewWithTag:TipSlider] setValue:0.5f animated:YES];
    _tipRate=@"0.15";
    [(UILabel*)[self viewWithTag:EachBodyLabel] setText:@"人均:"];
    
    [(UIButton*)[self viewWithTag:GoButton] setEnabled: YES];

}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView.tag == NumOfGuysPickerView)
    {
        return 1;
    }
    return 0;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == NumOfGuysPickerView) {
        return 31;
    }
    return 0;
}
-(CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if(pickerView.tag == NumOfGuysPickerView)
    {
        return 60.f;
    }
    return 0.f;
}
-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    if(pickerView.tag == NumOfGuysPickerView)
    {
        return 40.f;
    }
    return 0.f;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView.tag == NumOfGuysPickerView)
    {
        return ([NSString stringWithFormat:@"%d",row]);
    }
    return @"";
}
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag == NumOfGuysPickerView)
    {
        if (row!=0) {
            [(UITextView*)[self viewWithTag:NumOfGuysField] setText:[NSString stringWithFormat:@"%d",row]];
        }
        else 
        {
            [(UITextView*)[self viewWithTag:NumOfGuysField] setText:@""];
        }
    }
}

+ (BOOL) isTextValidNumber: (NSString*) text 
{
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern: @"^[0-9]*\\.?[0-9]{0,2}$" options: NSRegularExpressionAnchorsMatchLines error: nil];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString: text options: NSMatchingWithoutAnchoringBounds range:NSMakeRange(0, [text length])];
    if (numberOfMatches ==0 ) {
    	return NO;
    }
    else{
        return YES;
    }
}

- (BOOL) isAllInputValid
{
    BOOL retVal = YES;
    UITextField* textField = (UITextField*)[self viewWithTag:PretaxField];
    NSString* text = [textField text];
    if ([text length]!=0 && ![MyBackgroundView isTextValidNumber: text]) {
        retVal = NO;
    }
    textField = (UITextField*)[self viewWithTag:AftertaxField];
    text = [textField text];
    if ([text length]!=0 && ![MyBackgroundView isTextValidNumber: text]) {
        retVal = NO;
    }
    textField = (UITextField*)[self viewWithTag:TotalField];
    text = [textField text];
    if ([text length]!=0 && ![MyBackgroundView isTextValidNumber: text]) {
        retVal = NO;
    }
    return retVal;
}

-(void)showMessage:(NSString*) message
{
    [(UILabel*)[self viewWithTag:MessageLabel] setText:message];
}
@end
