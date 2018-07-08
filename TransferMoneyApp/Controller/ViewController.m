//
//  ViewController.m
//  TransferMoneyApp
//
//  Created by Dicky Chu on 8/7/2018.
//  Copyright © 2018 Dicky. All rights reserved.
//

#import "ViewController.h"
#import "TMNetworkManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        parameters[@"uid"] = @"fwefwfwef";
        parameters[@"format"] = @"json";
        parameters[@"fewkey"] = @"fewfwefw";
    
    TMNetworkManager *client = [TMNetworkManager sharedInstance];
    client.delegate = self;
    [client requestWithMethod:GET url:@"https://reqres.in/api/users?page=2" parameters:parameters];
//    [client performPostRequest:@"https://reqres.in/api/users?page=2" parameters:parameters];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tmNetworkManager:(TMNetworkManager *)client didFinishRequest:(id)response{
    NSLog(@"ViewController - didFinishRequest:%@",response);
}

-(void)tmNetworkManager:(TMNetworkManager *)client didFailWithError:(NSError *)error{
    NSLog(@"ViewController - didFailWithError:%@",error);
}


@end
