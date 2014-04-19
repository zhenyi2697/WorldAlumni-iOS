//
//  WAUserSettingRequest.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-18.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAUserSettingRequest : NSObject
@property (nonatomic, strong) NSString *bindingId;
@property (nonatomic, strong) NSString *entryId;
@property (nonatomic, strong) NSString *value;
@end
