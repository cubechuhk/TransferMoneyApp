//
//  TMUtility.m
//  TransferMoneyApp
//
//  Created by Dicky Chu on 9/7/2018.
//  Copyright © 2018 Dicky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TMUtility.h"


@implementation TMUtility

+ (void)showSimpleAlert:(NSString*)title message:(NSString*)msg {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alert dismissViewControllerAnimated:YES completion:nil];
        
    }];
    [alert addAction:cancel];
    
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [[vc presentedViewController] ? vc.presentedViewController : vc presentViewController:alert animated:YES completion:^{
    }];
    
}

@end
