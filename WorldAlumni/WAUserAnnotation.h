//
//  WAUserAnnotation.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-13.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAUserNearby.h"
#import <MapKit/MapKit.h>

@interface WAUserAnnotation : NSObject <MKAnnotation>
@property (nonatomic,strong) WAUserNearby *user;

+(WAUserAnnotation *)annotationForUser:(WAUserNearby *)user;
@end
