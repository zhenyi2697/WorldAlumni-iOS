//
//  WAUserDetailViewController.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-07.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WAUserNearby.h"
@interface WAUserDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) WAUserNearby *user;
@end
