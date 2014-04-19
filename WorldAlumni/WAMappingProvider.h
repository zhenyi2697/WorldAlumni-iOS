//
//  WAMappingProvider.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAMappingProvider : NSObject
+ (RKObjectMapping *) userMapping;
+ (RKObjectMapping *) bindingMapping;
+ (RKObjectMapping *) checkBindingRequestMapping;
+ (RKObjectMapping *) locationMapping;
+ (RKObjectMapping *) locationRequestMapping;
+ (RKObjectMapping *) userNearbyMapping;
+ (RKObjectMapping *) attendanceMapping;
+ (RKObjectMapping *) userSettingEntryMapping;
+ (RKObjectMapping *) userSettingRequestMapping;
@end
