//
//  WAUserAnnotation.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-13.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WAUserAnnotation.h"
#import "WAAttendance.h"

@implementation WAUserAnnotation

@synthesize user = _user;

+(WAUserAnnotation *)annotationForUser:(WAUserNearby *)user
{
    WAUserAnnotation *annotation = [[WAUserAnnotation alloc] init];
    annotation.user = user;
    return annotation;
}

//MKAnnotation protocol 的方法， title的setter
-(NSString *)title
{
    //    return self.location.name;
    return [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
}

//MKAnnotation protocol 的方法， subtitle的setter
- (NSString *)subtitle
{
    
    return @"";
}

//MKAnnotation protocol 的方法， coordinate的setter
- (CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.user.latitude doubleValue];
    coordinate.longitude = [self.user.longitude doubleValue];
    
    return coordinate;
}

@end
