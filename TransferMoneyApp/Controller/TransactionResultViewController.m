//
//  TransactionResultViewController.m
//  TransferMoneyApp
//
//  Created by Dicky Chu on 8/7/2018.
//  Copyright © 2018 Dicky. All rights reserved.
//

#import "TransactionResultViewController.h"

@interface TransactionResultViewController ()
@property (weak, nonatomic) IBOutlet UILabel *transactionNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *transactionTimeLabel;

@end

@implementation TransactionResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.transactionNumberLabel.text =  [self.result tid];
    self.transactionTimeLabel.text = [self getDateTimeStr:[self.result ttime]] ;
    self.transactionStatusLabel.text = [self getTransactionStatusMessage:[self.result tstatus]];
    
    //Hide Back button in Navigation bar
    [self.navigationItem setHidesBackButton:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)getDateTimeStr:(NSString*)timestamp{
    NSTimeInterval time=[timestamp doubleValue];
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

- (NSString*)getTransactionStatusMessage:(NSString*)statusCode{
    if([statusCode isEqualToString:@"001"]){
        return @"Success";
    }else if([statusCode isEqualToString:@"002"]){
        return @"Insufficient fund in debit account";
    }else if([statusCode isEqualToString:@"003"]){
        return @"Recipent not found";
    }else{
        return @"Unknown error occurred";
    }
    return @"";
}

- (IBAction)doneButton:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
