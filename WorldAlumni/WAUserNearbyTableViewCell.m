//
//  WAUserNearbyTableViewCell.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-07.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WAUserNearbyTableViewCell.h"

@implementation WAUserNearbyTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)layoutSubviews {
//    [super layoutSubviews];
//    self.imageView.frame = CGRectMake(5,5,60,60);
//    float limgW =  self.imageView.image.size.width;
//    if(limgW > 0) {
//        self.textLabel.frame = CGRectMake(75,self.textLabel.frame.origin.y,self.textLabel.frame.size.width,self.textLabel.frame.size.height);
//        self.detailTextLabel.frame = CGRectMake(75,self.detailTextLabel.frame.origin.y,self.detailTextLabel.frame.size.width,self.detailTextLabel.frame.size.height);
//    }
//}

@end
