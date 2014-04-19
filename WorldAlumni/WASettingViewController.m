//
//  WASettingViewController.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-06.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WASettingViewController.h"
#import "WASettingTableViewCell.h"
#import "WADataController.h"
#import "WAUserSettingEntry.h"

@interface WASettingViewController ()
@property (nonatomic, strong) NSArray *settingEntries;
@end

@implementation WASettingViewController

@synthesize tableView = _tableView;
@synthesize settingEntries = _settingEntries, settingDic = _settingDic;
@synthesize user = _user;

-(NSArray *)settingEntries{
    if (!_settingEntries) {
        _settingEntries = [[NSArray alloc] initWithObjects:@"Distance Only", @"Invisible Mode", nil];
    }
    return _settingEntries;
}

-(NSMutableDictionary *)settingDic{
    if (!_settingDic) {
        _settingDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    }
    return _settingDic;
}

-(void)setSettingDic:(NSMutableDictionary *)settingDic
{
    _settingDic = settingDic;
    
    [self.tableView reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [self.settingEntries count];
    } else if (section == 1){
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView = switchView;
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        switchView.tag = indexPath.row;
        
        cell.textLabel.text = [self.settingEntries objectAtIndex:indexPath.row];
        
//        int savedValue = [[NSUserDefaults standardUserDefaults] integerForKey:[self.settingEntries objectAtIndex:indexPath.row]];

        WAUserSettingEntry *setting = [self.settingDic objectForKey:[NSString stringWithFormat:@"%d", (indexPath.row+1)]];
        int savedValue = 0;
        if (setting) {
            savedValue = [setting.value integerValue];
        }
        
        if (savedValue == 0) {
            [switchView setOn:NO];
        } else {
            [switchView setOn:YES];
        }
    } else if(indexPath.section == 1){
        if ([self.user.provider isEqualToString:@"facebook"]) {
            cell.textLabel.text = @"Log out from Facebook";
        } else {
            cell.textLabel.text = @"Log out from Linkedin";
        }

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [FBSession.activeSession closeAndClearTokenInformation];
        }
    }
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0) {
        return 120;
    } else {
        return 20;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // create the parent view that will hold header Label
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(20,0,300,60)];
    
    if(section == 0){
        
        // create the imageView with the image in it
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 16, 72, 72)];
        
        // add social image according to provider type
        if ([self.user.provider isEqual:@"facebook"]) {

            [imageView setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@?width=200&height=200", self.user.imageUrl]] placeholderImage:[UIImage imageNamed:@"WorldAlumni.png"]];
            
        } else if ([self.user.provider isEqual:@"linkedin-oauth2"] ){

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
        
        [customView addSubview:imageView];
        [customView addSubview:nameLabel];
    }
    
    return customView;
}


-(void)switchChanged:(id)sender {
    
    UISwitch* switchControl = sender;
    
    int value = 0;
    if ([switchControl isOn]) {
        value = 1;
    }
    
//    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:[self.settingEntries objectAtIndex:switchControl.tag]];
    
    WADataController *dataController = [WADataController sharedDataController];
    WAUserSettingEntry *entry = [[WAUserSettingEntry alloc] init];
    entry.eid = [NSString stringWithFormat:@"%d", (switchControl.tag + 1)];
    entry.value = [NSString stringWithFormat:@"%d", value];
    
    [dataController updateSettingEntry:entry withBindingId:self.user.bindingId];
    // also update settings in self
    WAUserSettingEntry *s = [self.settingDic objectForKey:entry.eid];
    s.value = entry.value;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
