//
//  WADataController.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WADataController : NSObject
+(id)sharedDataController;

-(void)checkBindingForUid:(NSString *)uid andProvider:(NSString *)provider;
@end
