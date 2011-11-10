//
//  SecondViewController.h
//  MultiplicationTable
//
//  Created by Carlos Vilhena on 30/10/2011.
//  Copyright 2011 Digital Science. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MultiplicationTableAppDelegate.h"

@interface SecondViewController : UIViewController <UITextFieldDelegate, UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UILabel *aLabel;
@property (nonatomic, retain) IBOutlet UILabel *bLabel;
@property (nonatomic, retain) IBOutlet UILabel *correctResultWasLabel;
@property (nonatomic, retain) IBOutlet UITextField *resultTextField;
@property (nonatomic, retain) IBOutlet UIImageView *isResCorrectImage;
@property (nonatomic, retain) IBOutlet UIWebView *multiplicationTableWebView;
@property (nonatomic, retain) NSMutableArray *multiplicationTableArray;
@property (nonatomic, assign) int expectedResult;
@property (nonatomic, retain) NSDate *startAnswerDate;

-(void)removeImage:(NSTimer*)theTimer;

@end
