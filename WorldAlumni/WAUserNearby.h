//
//  WAUserNearby.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-06.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAUserNearby : NSObject
@property (strong, nonatomic) NSString *bindingId;
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *imageUrl;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *provider;
@property (strong, nonatomic) NSString *distance;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *appearTime;
@property (strong, nonatomic) NSArray *attendances;
@property (strong, nonatomic) NSArray *associatedAttendances;
@end