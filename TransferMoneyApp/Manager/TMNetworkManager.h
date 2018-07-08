//
//  TMNetworkManager.h
//  TransferMoneyApp
//
//  Created by Dicky Chu on 8/7/2018.
//  Copyright © 2018 Dicky. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol TMNetworkManagerDelegate;

typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;

@interface TMNetworkManager : AFHTTPSessionManager
@property (nonatomic, weak) id<TMNetworkManagerDelegate>delegate;

+ (id)sharedInstance;
+ (void)releaseInstance;

//- (void)performGetRequest:(NSString*)url parameters:(NSDictionary *)params;
//- (void)performPostRequest:(NSString*)url parameters:(NSDictionary *)params;

- (void)requestWithMethod:(HTTPMethod)method url:(NSString *)url parameters:(NSDictionary*)params;
@end

@protocol TMNetworkManagerDelegate <NSObject>
@optional
-(void)tmNetworkManager:(TMNetworkManager *)client didFinishRequest:(id)response;
-(void)tmNetworkManager:(TMNetworkManager *)client didFailWithError:(NSError *)error;
@end
