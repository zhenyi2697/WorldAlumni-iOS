//
//  WASettingTableViewCell.m
//  WorldAlumni
//
//  Created by Zhenyi ZHANG on 2014-04-17.
//  Copyright (c) 2014 Zhenyi Zhang. All rights reserved.
//

#import "WASettingTableViewCell.h"

@implementation WASettingTableViewCell

@synthesize entryLabel = _entryLabel, entrySwitch = _entrySwitch;

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


@end