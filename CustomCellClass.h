//
//  CustomCellClass.h
//  eBookUniverse
//
//  Created by Farzana on 6/27/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCellClass : UITableViewCell

+ (NSString *)reuseIdentifier;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *author;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UIImageView *eBookImage;

@end
