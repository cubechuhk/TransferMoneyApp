//
//  ConfirmViewController.m
//  TransferMoneyApp
//
//  Created by Dicky Chu on 8/7/2018.
//  Copyright © 2018 Dicky. All rights reserved.
//

#import "ConfirmViewController.h"
#import "TMConfig.h"
#import "TransactionResultViewController.h"
#import "TransferResult.h"
#import "TMUtility.h"

@interface ConfirmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *recipentLabel;
@property (weak, nonatomic) IBOutlet UILabel *transferAmountLabel;
@property (strong, nonatomic) TransferResult *result;
@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.recipentLabel.text = self.recipentName;
    self.transferAmountLabel.text = [NSString stringWithFormat:@"%.01f",self.transferAmount];
    
    //Assign network delegate
    self.client = [TMNetworkManager sharedInstance];
    self.client.delegate = self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //Set initial values
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmTransactionButton:(id)sender {
    
    //Send POST request to server
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"fromUid"] = @"imgrl0x94hj8h2om6201";
    parameters[@"toUid"] = @"vjre4mxohv9ljxy6neyp";
    parameters[@"amount"] = [NSString stringWithFormat:@"%.01f",self.transferAmount];
    
    //Actual scenario should use POST request
    [self.client requestWithMethod:GET url:TRANSACTION_POST_URL parameters:parameters];
}

-(void)tmNetworkManager:(TMNetworkManager *)client didFinishRequest:(id)response{
    NSLog(@"ViewController - didFinishRequest:%@",response);
    
    NSData *responseData = [NSJSONSerialization dataWithJSONObject:response options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];

    NSError *error;
    TransferResult *tResult = [[TransferResult alloc] initWithString:jsonStr error:&error];
    self.result = tResult;
    
    if (error != NULL) {
        NSLog(@"JSON parsing Error: %@",[error description]);
    }else{
        //Pass Model to result via Controller
        [self performSegueWithIdentifier:@"transactionResultSegue" sender:self];
    }

}

-(void)tmNetworkManager:(TMNetworkManager *)client didFailWithError:(NSError *)error{
    NSLog(@"ViewController - didFailWithError:%@",error);
    [TMUtility showSimpleAlert:@"Error" message:@"Network Error Occurred. Please try again later."];
    
    //Send User back to root view
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"transactionResultSegue"]) {
        //Pass Parameter to Confirm View
        TransactionResultViewController *trvc = (TransactionResultViewController*)segue.destinationViewController;
        trvc.result = self.result;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
