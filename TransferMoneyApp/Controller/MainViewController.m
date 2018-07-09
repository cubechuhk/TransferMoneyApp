//
//  MainViewController.m
//  TransferMoneyApp
//
//  Created by Dicky Chu on 8/7/2018.
//  Copyright © 2018 Dicky. All rights reserved.
//

#import "MainViewController.h"
#import "TMNetworkManager.h"
#import "ConfirmViewController.h"
#import "TMUtility.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITextField *transferAmount;
@property (strong, nonatomic) NSString *recipentName;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.transferAmount.delegate = self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Set initial values
    
    // HardCode Recipent name for demo purpose
    self.recipentName = @"Sally Cheung";
    self.transferAmount.text = @"0.0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if ([textField.text containsString:@"."] && [string containsString:@"."]) {
        //Prevent user entering multiple dots
        return NO;
    } else {
    
        //Limiting Text Field to 1 decimal point
        NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSArray *sep = [newString componentsSeparatedByString:@"."];
        if([sep count] >= 2)
        {
            NSString *sepStr=[NSString stringWithFormat:@"%@",[sep objectAtIndex:1]];
            return !([sepStr length]>1);
        }
        
        return YES;
    }
}

- (BOOL)checkStringAmountIsZero:(NSString*)amount{
    //Check if it is zero amount
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *myNumber = [f numberFromString:amount];
    
    if([myNumber doubleValue] <= 0){
        return YES;
    }else{
        return NO;
    }
}

- (IBAction)submitBtn:(id)sender {
    if([self checkStringAmountIsZero:self.transferAmount.text]){
        [TMUtility showSimpleAlert:@"Error" message:@"Please input numbers greater than zero"];
        return;
    }else{
        [self.view endEditing:YES];
        [self performSegueWithIdentifier:@"confirmSegue" sender:self];
    }
    
}

- (IBAction)recipentBtn:(id)sender {
    [TMUtility showSimpleAlert:@"Warning" message:@"Recipent could not be altered as this app is just for demostration"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"confirmSegue"]) {
        //Pass Parameter to Confirm View
        ConfirmViewController *cvc = (ConfirmViewController*)segue.destinationViewController;
        cvc.recipentName = self.recipentName;
        cvc.transferAmount = [self.transferAmount.text doubleValue];
    }

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Dismiss KeyPad when Empty space is clicked
    [self.view endEditing:YES];
}



@end
