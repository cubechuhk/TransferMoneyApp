//
//  TMNetworkManager.m
//  TransferMoneyApp
//
//  Created by Dicky Chu on 8/7/2018.
//  Copyright © 2018 Dicky. All rights reserved.
//


#import "TMNetworkManager.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "TMConfig.h"

static TMNetworkManager *sharedInstance = nil;

@implementation TMNetworkManager

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

+ (void)releaseInstance
{
    sharedInstance = nil;
}

- (id)init
{
    self = [super init];
    if(self)
    {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = DEFAULT_REQUEST_TIMEOUT;
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/plain", nil];
 
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

- (void)requestWithMethod:(HTTPMethod)method url:(NSString *)url parameters:(NSDictionary*)params
{
    switch (method) {
        case GET:{
            [self GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                //Download Progress
                NSLog(@"downloadProgress: %@",downloadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //Return responseObject conforms responseSerializer's format
                NSLog(@"responseObject: %@",responseObject);
                if ([self.delegate respondsToSelector:@selector(tmNetworkManager:didFinishRequest:)]) {
                    [self.delegate tmNetworkManager:self didFinishRequest:responseObject];
                    
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //Request Fail
                NSLog(@"error: %@",error);
                if ([self.delegate respondsToSelector:@selector(tmNetworkManager:didFailWithError:)]) {
                    [self.delegate tmNetworkManager:self didFailWithError:error];
                }
            }];
            break;
        }
        case POST:{
            [self POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                //Download Progress
                NSLog(@"downloadProgress: %@",uploadProgress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //Return responseObject conforms responseSerializer's format
                NSLog(@"responseObject: %@",responseObject);
                if ([self.delegate respondsToSelector:@selector(tmNetworkManager:didFinishRequest:)]) {
                    [self.delegate tmNetworkManager:self didFinishRequest:responseObject];
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //Request Fail
                NSLog(@"error: %@",error);
                if ([self.delegate respondsToSelector:@selector(tmNetworkManager:didFailWithError:)]) {
                    [self.delegate tmNetworkManager:self didFailWithError:error];
                }
            }];
            break;
        }
        default:
            break;
    }
}

@end
