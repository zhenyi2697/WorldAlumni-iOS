//
//  WALocation.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-06.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WALocation : NSObject
@property (strong, nonatomic) NSString *locationId;
@property (strong, nonatomic) NSString *bindingId;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *expireTime;
@end
