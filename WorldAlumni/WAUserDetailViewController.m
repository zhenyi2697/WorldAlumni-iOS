//
//  WAUserDetailViewController.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-07.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WAUserDetailViewController.h"
#import "WAAttendance.h"
#import "WAUserDetailTableViewCell.h"

@interface WAUserDetailViewController ()
@property (nonatomic, strong) NSArray *sections;
@end

@implementation WAUserDetailViewController
@synthesize tableView = _tableView;
@synthesize sections = _sections, user = _user;

-(NSArray *)sections{
    if (!_sections) {
        _sections = [[NSArray alloc] initWithObjects:@"School", nil];
    }
    return _sections;
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
    
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.user.firstName;
    
    
    self.automaticallyAdjustsScrollViewInsets=YES;
    
    // Add a footer so that the tabbar do not cover the tableView bottom
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 152)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.sections count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sections objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) { //schools
        return [self.user.attendances count];
    } else if (section == 1) { // companies
        return 2;
    } else {
        return 0;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UserDetailCell";
    WAUserDetailTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell here
    if (indexPath.section == 0) {
        WAAttendance *attd = [self.user.attendances objectAtIndex:indexPath.row];
        cell.titleLabel.text = attd.type;
        cell.detailLabel.text = attd.school;
    } else {
        
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return 120;
    } else {
        return 30;
    }
}

-(void)showFacebookUserProfile
{
    NSURL *facebookUrl = [NSURL URLWithString:[NSString stringWithFormat:@"fb://profile/%@", self.user.uid]];
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://www.facebook.com/%@", self.user.uid]];
    BOOL isInstalled = [[UIApplication sharedApplication] canOpenURL:facebookUrl];
    
    if (isInstalled) {
        [[UIApplication sharedApplication] openURL:facebookUrl];
    } else {
        NSLog(@"cannot be opened, open in webview installed");
        [[UIApplication sharedApplication] openURL:url];
    }

}

-(void) showLinkedUserProfile
{
    NSLog(@"%@", self.user.uid);
    NSURL *linkedinURL = [NSURL URLWithString:[NSString stringWithFormat:@"linkedin://#profile/%@", self.user.uid]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.linkedin.com/profile/view?id=%@", self.user.uid]];
    
    BOOL isInstalled = [[UIApplication sharedApplication] canOpenURL:linkedinURL];
    
    if (isInstalled) {
        [[UIApplication sharedApplication] openURL:linkedinURL];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(20,0,300,60)];
    
    // configure section header title
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:15];
    headerLabel.frame = CGRectMake(120,18,200,20);
    headerLabel.textColor = [UIColor grayColor];
    
    if(section == 0){
        
        // create the imageView with the image in it
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 72, 72)];
        
        // add social image according to provider type
        if ([self.user.provider isEqual:@"facebook"]) {
            UIButton *facebookButton = [[UIButton alloc] initWithFrame:CGRectMake(96, 54, 30, 30)];
            [facebookButton setImage:[UIImage imageNamed:@"facebook.png"] forState:UIControlStateNormal];
            [facebookButton addTarget:self action:@selector(showFacebookUserProfile) forControlEvents:UIControlEventTouchUpInside];
            [customView addSubview:facebookButton];
            [imageView setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@?width=200&height=200", self.user.imageUrl]] placeholderImage:[UIImage imageNamed:@"WorldAlumni.png"]];

        } else if ([self.user.provider isEqual:@"linkedin-oauth2"] ){
//            UIButton *linkedinButton = [[UIButton alloc] initWithFrame:CGRectMake(134, 54, 30, 30)];
            UIButton *linkedinButton = [[UIButton alloc] initWithFrame:CGRectMake(96, 54, 30, 30)];
            [linkedinButton setImage:[UIImage imageNamed:@"linkedin.png"] forState:UIControlStateNormal];
            [linkedinButton addTarget:self action:@selector(showLinkedUserProfile) forControlEvents:UIControlEventTouchUpInside];
            [customView addSubview:linkedinButton];
            [imageView setImageWithURL:[NSURL URLWithString:self.user.imageUrl]
                                    placeholderImage:[UIImage imageNamed:@"WorldAlumni.png"]];
            
        }
        
        // set image round corner
        CALayer * l = [imageView layer];
        [l setMasksToBounds:YES];
        [l setCornerRadius:5.0];

        
        // configure labels
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(96,18,250,30)];
        nameLabel.font = [UIFont systemFontOfSize:19];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.user.firstName, self.user.lastName];
        
        headerLabel.frame = CGRectMake(16,96,230,25);
        headerLabel.text = [self.sections objectAtIndex:section];
        
        [customView addSubview:imageView];
        [customView addSubview:headerLabel];
        [customView addSubview:nameLabel];
    } else {
        headerLabel.frame = CGRectMake(16,0,230,25);
        headerLabel.text = [self.sections objectAtIndex:section];
        [customView addSubview:headerLabel];
    }
    
    return customView;
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
