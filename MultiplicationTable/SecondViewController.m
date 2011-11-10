//
//  SecondViewController.m
//  MultiplicationTable
//
//  Created by Carlos Vilhena on 30/10/2011.
//  Copyright 2011 Digital Science. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController
@synthesize aLabel;
@synthesize bLabel;
@synthesize resultTextField;
@synthesize expectedResult;
@synthesize isResCorrectImage;
@synthesize correctResultWasLabel;
@synthesize multiplicationTableWebView;
@synthesize multiplicationTableArray;
@synthesize startAnswerDate;


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)dealloc {
    self.aLabel = nil;
    self.bLabel = nil;
    self.resultTextField = nil;
    self.isResCorrectImage = nil;
    [super dealloc];
}

-(void)removeImage:(NSTimer*)theTimer {
    self.isResCorrectImage.hidden = YES;
    self.correctResultWasLabel.hidden = YES;
}

-(int)randomSmallerOrEqualTo:(int)value {
    return (arc4random()%value) + 1;
}

-(void)newExercise {
    int valueA = [self randomSmallerOrEqualTo:10];
    int valueB = [self randomSmallerOrEqualTo:10];
    
    self.aLabel.text = [NSString stringWithFormat:@"%d", valueA];
    self.bLabel.text = [NSString stringWithFormat:@"%d", valueB];
    self.resultTextField.text = nil;
    self.expectedResult = valueA * valueB;
    
    self.startAnswerDate = [NSDate date];
}

-(NSString *)buildTableString {
    NSMutableString *tableString = [NSMutableString stringWithFormat:@"<table border=\"1\" cellpadding=\"20\"><head><style TYPE=\"text/css\"><!--td {text-align: center; font-size: 28px;}--></style></head>"];

    NSLog(@"tableLength: %d", [self.multiplicationTableArray count]);
    for (NSMutableArray *line in self.multiplicationTableArray) {
        [tableString appendFormat:@"<tr>"];
        for (NSString *value in line) {
            [tableString appendFormat:@"<td>%@</td>", value];
        }
        [tableString appendFormat:@"</tr>"];
    }
    [tableString appendString:@"</table>"];
    NSLog(@"%@", tableString);
    return tableString;
}

-(void)refreshTable {
    NSString *html = [self buildTableString];
    [self.multiplicationTableWebView loadHTMLString:html baseURL:nil];
    [self.multiplicationTableWebView sizeToFit];
}

-(void)viewWillAppear:(BOOL)animated {
    [self newExercise];
    self.multiplicationTableArray = [NSMutableArray arrayWithObject:[NSMutableArray arrayWithObjects:@"", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil]];
    for (int i=1; i<=10; i++) {
        NSMutableArray *lineArray = [NSMutableArray arrayWithObjects:[NSString stringWithFormat:@"%d", i], @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
        [self.multiplicationTableArray addObject:lineArray];
    }
    [self refreshTable];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
//    [self.multiplicationTableWebView sizeToFit];
}

-(void)updateUserResults:(NSString *)lineColumn {
    MultiplicationTableAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    NSMutableDictionary *usersDictionary = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *linesAndColumns = [usersDictionary objectForKey:appDelegate.username];
    NSDictionary *lineAndColumnDictionary = [linesAndColumns objectForKey:lineColumn];
    NSNumber *total = [lineAndColumnDictionary objectForKey:@"total"];
    NSNumber *bestTime = [lineAndColumnDictionary objectForKey:@"bestTime"];
    NSNumber *worstTime = [lineAndColumnDictionary objectForKey:@"worstTime"];
    NSNumber *correct = [lineAndColumnDictionary objectForKey:@"correct"];
    
    NSNumber *newTotal = [NSNumber numberWithInt:[total intValue]+1];
    [lineAndColumnDictionary setValue:newTotal forKey:@"total"];
    
    //TODO
    int spentTime;
    if ([bestTime intValue] > spentTime) {
        [lineAndColumnDictionary setValue:[NSNumber numberWithInt:spentTime] forKey:@"bestTime"];
    }
    
    if ([worstTime intValue] < spentTime) {
        [lineAndColumnDictionary setValue:[NSNumber numberWithInt:spentTime] forKey:@"worstTime"];
    }
    
}

-(IBAction)resultChanged:(id)sender {
    NSString *expectedResultString = [NSString stringWithFormat:@"%d", self.expectedResult];
    if ([self.resultTextField.text length] == [expectedResultString length]) {
        if ([self.resultTextField.text intValue] == self.expectedResult) {
            [[self.multiplicationTableArray objectAtIndex:[self.aLabel.text intValue]] replaceObjectAtIndex:[self.bLabel.text intValue] withObject:@"1/1"];
            [self refreshTable];
            NSLog(@"Correct");
            self.isResCorrectImage.image = [UIImage imageNamed:@"happySmile.jpg"];
            [self performSelector:@selector(removeImage:) withObject:nil afterDelay:0.7];
        }
        else {
            [[self.multiplicationTableArray objectAtIndex:[self.aLabel.text intValue]] replaceObjectAtIndex:[self.bLabel.text intValue] withObject:@"0/1"];
            [self refreshTable];
            NSLog(@"Wrong");
            self.isResCorrectImage.hidden = NO;
            self.correctResultWasLabel.text = [NSString stringWithFormat:@"%@ x %@ = %d", self.aLabel.text, self.bLabel.text, self.expectedResult];
            self.correctResultWasLabel.hidden = NO;
            self.isResCorrectImage.image = [UIImage imageNamed:@"sadSmile.jpeg"];
            [self performSelector:@selector(removeImage:) withObject:nil afterDelay:2.5];
        }
        NSDate *now = [NSDate date];
//        int answerTime = now - self.startAnswerDate;
        self.isResCorrectImage.hidden = NO;
        [self newExercise];
    }
}

@end
