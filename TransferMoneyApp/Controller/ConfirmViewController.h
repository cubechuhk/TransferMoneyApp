//
//  ConfirmViewController.h
//  TransferMoneyApp
//
//  Created by Dicky Chu on 8/7/2018.
//  Copyright © 2018 Dicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMNetworkManager.h"

@interface ConfirmViewController : UIViewController <TMNetworkManagerDelegate>

@property (strong, nonatomic) NSString *recipentName;
@property (assign, nonatomic) double transferAmount;
@property (strong, nonatomic) TMNetworkManager *client;
@end
