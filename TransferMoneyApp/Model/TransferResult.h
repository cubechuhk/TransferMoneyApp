//
//  TransferResult.h
//  TransferMoneyApp
//
//  Created by Dicky Chu on 9/7/2018.
//  Copyright © 2018 Dicky. All rights reserved.
//

#import "JSONModel.h"

@interface TransferResult : JSONModel

@property (nonatomic) NSString *tid;
@property (nonatomic) NSString *tstatus;
@property (nonatomic) NSString *ttime;

@end
