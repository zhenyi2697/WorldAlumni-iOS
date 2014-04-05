//
//  WABinding.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAUser.h"

@interface WABinding : NSObject
@property (strong, nonatomic) NSString *bindingId;
@property (strong, nonatomic) NSString *provider;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *modifyTime;
@property (strong, nonatomic) WAUser *user;
@property (strong, nonatomic) NSArray *schools;
@end
