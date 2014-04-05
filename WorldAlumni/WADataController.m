//
//  WADataController.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WADataController.h"
#import "WABinding.h"
#import "WAMappingProvider.h"
#import "WACheckBindingRequest.h"
#import "WAObjectManager.h"

@implementation WADataController
+ (id)sharedDataController {
    static WADataController *sharedDataController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataController = [[self alloc] init];
    });
    return sharedDataController;
}

-(void)checkBindingForUid:(NSString *)uid andProvider:(NSString *)provider
{
    RKObjectMapping *bindingMapping = [WAMappingProvider bindingMapping];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:bindingMapping method:RKRequestMethodAny pathPattern:nil keyPath:nil statusCodes:nil];
    
    RKObjectMapping *checkBindingMapping = [WAMappingProvider checkBindingRequestMapping];
    
    //Inverse mapping, to perform a POST
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:[checkBindingMapping inverseMapping] objectClass:[WACheckBindingRequest class] rootKeyPath:nil  method:RKRequestMethodAny];
    
    WAObjectManager *manager = [WAObjectManager objectManager];
    
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:responseDescriptor];
    
    WACheckBindingRequest *request = [[WACheckBindingRequest alloc] init];
    request.uid = uid;
    request.provider = provider;
    request.access_token = [[[FBSession activeSession] accessTokenData] accessToken];
    
    [manager postObject:request path:@"/api/check_binding/" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        NSLog(@"Success");
        for (WABinding *b in [result array]) {
            NSLog(@"%@", b);
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Error");
    }];
    
}

@end
