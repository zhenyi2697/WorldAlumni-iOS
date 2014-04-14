//
//  WAObjectManager.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WAObjectManager.h"

@implementation WAObjectManager
+(WAObjectManager *)objectManager
{
    NSURL *url = [NSURL URLWithString:@"http://theworldalumni.com"];
//    NSURL *url = [NSURL URLWithString:@"http://localhost:8000"];
    WAObjectManager *objectManager  = [self managerWithBaseURL:url];
    return objectManager;
}
@end