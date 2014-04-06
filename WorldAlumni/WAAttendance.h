//
//  WAAttendance.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-06.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAAttendance : NSObject
@property (strong, nonatomic) NSString *attendanceId;
@property (strong, nonatomic) NSString *school;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *attendYear;
@end