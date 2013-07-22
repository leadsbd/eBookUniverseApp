//
//  CustomCellClass.m
//  eBookUniverse
//
//  Created by Farzana on 6/27/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import "CustomCellClass.h"

@implementation CustomCellClass
@synthesize title;
@synthesize eBookImage;
@synthesize author;


+ (NSString *)reuseIdentifier
{
    return @"Cell";    // Keep in sync with Identifier field in nib
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
