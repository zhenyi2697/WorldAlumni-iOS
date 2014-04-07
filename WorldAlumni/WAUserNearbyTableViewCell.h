//
//  WAUserNearbyTableViewCell.h
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-07.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAUserNearbyTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *thumbnailImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *appearTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *associatedAttendancelabel;

@end
