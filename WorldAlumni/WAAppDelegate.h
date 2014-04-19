//
//  WAAppDelegate.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-05.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WALoginViewController.h"
#import "WAListViewController.h"
#import "WAMapViewController.h"
#import "WASettingViewController.h"

@interface WAAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) WALoginViewController *loginViewController;
@property (strong, nonatomic) WAListViewController *listViewController;
@property (strong, nonatomic) WAMapViewController *mapViewController;
@property (strong, nonatomic) WASettingViewController *settingViewController;

- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

@end
