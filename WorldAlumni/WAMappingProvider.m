//
//  WAMappingProvider.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WAMappingProvider.h"
#import "WABinding.h"
#import "WAUser.h"
#import "WACheckBindingRequest.h"

@implementation WAMappingProvider
+ (RKObjectMapping *) userMapping
{
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[WAUser class]];
    [userMapping addAttributeMappingsFromDictionary:@{
                                                         @"id" : @"userId",
                                                         @"username": @"username",
                                                         @"email": @"eamil",
                                                         @"first_name": @"firstName",
                                                         @"last_name": @"lastName",
                                                         }];
    return userMapping;
}

+ (RKObjectMapping *) bindingMapping
{
    RKObjectMapping *bindingMapping = [RKObjectMapping mappingForClass:[WABinding class]];
    [bindingMapping addAttributeMappingsFromDictionary:@{
                                                         @"id" : @"bindingId",
                                                         @"bind_from": @"provider",
                                                         @"create_time": @"createTime",
                                                         @"modify_time": @"modifyTime",
                                                         }];
    return bindingMapping;
}

+ (RKObjectMapping *) checkBindingRequestMapping
{
    RKObjectMapping *checkBindingMapping = [RKObjectMapping mappingForClass:[WACheckBindingRequest class]];
    [checkBindingMapping addAttributeMappingsFromDictionary:@{
                                                      @"uid" : @"uid",
                                                      @"provider": @"provider",
                                                      @"access_token": @"access_token"
                                                      }];
    return checkBindingMapping;
}

@end
