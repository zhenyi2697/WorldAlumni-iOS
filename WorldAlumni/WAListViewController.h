//
//  WAListViewController.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-06.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
//RefreshControl Library
#import "ODRefreshControl.h"

#import "WAUserNearby.h"
#import "WAAttendance.h"
#import "WAUserNearbyTableViewCell.h"

@interface WAListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ODRefreshControl *refreshControl;
@property (nonatomic, strong) NSArray *nearbyUsers;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *filterButton;
- (IBAction)filter:(id)sender;
@end
