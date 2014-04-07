//
//  WAListViewController.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-06.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WAListViewController.h"

@interface WAListViewController ()

@end

@implementation WAListViewController

@synthesize tableView = _tableView;
@synthesize refreshControl = _refreshControl;
@synthesize nearbyUsers = _nearbyUsers;

-(NSArray *)nearbyUsers
{
    if (!_nearbyUsers) {
        _nearbyUsers = [[NSArray alloc] initWithObjects:nil];
    }
    return _nearbyUsers;
}

-(void)setNearbyUsers:(NSArray *)users
{
    _nearbyUsers = users;
    [self.tableView reloadData];
}

-(ODRefreshControl *)refreshControl
{
    if (!_refreshControl) {
        _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    }
    return _refreshControl;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // IMPORTANT!
    // Added this line so that refresh control can properly be showed
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.automaticallyAdjustsScrollViewInsets=YES;
    
    // Add a footer so that the tabbar do not cover the tableView bottom
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 152)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
    //Refresh Control
    [self.refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.nearbyUsers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserNearbyCell";
    WAUserNearbyTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell here
    WAUserNearby *user = [self.nearbyUsers objectAtIndex:indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%@ %@", user.firstName, user.lastName];
    cell.distanceLabel.text = user.distance;
    cell.appearTimeLabel.text = user.appearTime;
    
    if ([user.associatedAttendances count]) {
        WAAttendance *associatedAttendance = [user.associatedAttendances objectAtIndex:0];
        cell.associatedAttendancelabel.text = associatedAttendance.school;
    } else {
        cell.associatedAttendancelabel.text = @"No common schools";
    }
    
    // Using SDWebImage to load image
    NSString *imageUrl = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=100&height=100", user.uid];
    [cell.thumbnailImageView setImageWithURL:[NSURL URLWithString:imageUrl]
                   placeholderImage:[UIImage imageNamed:@"WorldAlumni.png"]];
    CALayer * l = [cell.thumbnailImageView layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:5.0];
    
    return cell;
}

// Refresh when dropping down
- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    double delayInSeconds = 1.5;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Refreshed");
        [refreshControl endRefreshing];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
