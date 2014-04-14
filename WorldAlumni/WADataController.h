//
//  WADataController.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WABinding.h"
#import "WALocation.h"
#import "WAUserNearby.h"
#import "WAAttendance.h"

@interface WADataController : NSObject <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, strong) WABinding *me;
+(id)sharedDataController;

-(void)checkBindingForUid:(NSString *)uid andProvider:(NSString *)provider;
-(void)nearbyUsersForBinding:(WABinding *)binding;
@end
