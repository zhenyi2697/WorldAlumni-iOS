//
//  WACheckBindingRequest.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WACheckBindingRequest : NSObject
@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *provider;
@property (strong, nonatomic) NSString *access_token;
@end
