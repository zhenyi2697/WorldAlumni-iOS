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
#import "WALocation.h"
#import "WAUserNearby.h"
#import "WAAttendance.h"

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

+ (RKObjectMapping *) locationMapping
{
    RKObjectMapping *locationMapping = [RKObjectMapping mappingForClass:[WALocation class]];
    [locationMapping addAttributeMappingsFromDictionary:@{
                                                         @"id" : @"locationId",
                                                         @"bindingId": @"bindingId",
                                                         @"create_time": @"createTime",
                                                         @"expire_time": @"expireTime",
                                                         @"latitude": @"latitude",
                                                         @"longitude": @"longitude"
                                                         }];
    return locationMapping;
}

+ (RKObjectMapping *) locationRequestMapping
{
    RKObjectMapping *locationRequestMapping = [RKObjectMapping mappingForClass:[WALocation class]];
    [locationRequestMapping addAttributeMappingsFromDictionary:@{
                                                          @"bindingId": @"bindingId",
                                                          @"latitude": @"latitude",
                                                          @"longitude": @"longitude"
                                                          }];
    return locationRequestMapping;
}

+ (RKObjectMapping *) attendanceMapping
{
    RKObjectMapping *attendanceMapping = [RKObjectMapping mappingForClass:[WAAttendance class]];
    [attendanceMapping addAttributeMappingsFromDictionary:@{
                                                          @"id" : @"attendanceId",
                                                          @"school": @"school",
                                                          @"type": @"type",
                                                          @"attend_year": @"attendYear"
                                                          }];
    return attendanceMapping;
}

+ (RKObjectMapping *) userNearbyMapping
{
    RKObjectMapping *userNearbyMapping = [RKObjectMapping mappingForClass:[WAUserNearby class]];
    [userNearbyMapping addAttributeMappingsFromDictionary:@{
                                                                 @"bindingId": @"bindingId",
                                                                 @"uid": @"uid",
                                                                 @"first_name": @"firstName",
                                                                 @"last_name": @"lastName",
                                                                 @"provider": @"provider",
                                                                 @"distance": @"distance",
                                                                 @"longitude": @"longitude",
                                                                 @"latitude": @"latitude",
                                                                 @"appear_time": @"appearTime"
                                                                 }];
    
    RKObjectMapping *attendanceMapping = [WAMappingProvider attendanceMapping];
    [userNearbyMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"attendances"
                                                                               toKeyPath:@"attendances"
                                                                             withMapping:attendanceMapping]];
    
    [userNearbyMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"associated_attendances"
                                                                                      toKeyPath:@"associatedAttendances"
                                                                                    withMapping:attendanceMapping]];
    
    return userNearbyMapping;
}


@end
