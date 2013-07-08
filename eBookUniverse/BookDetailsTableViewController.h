//
//  BookDetailsTableViewController.h
//  RainFall
//
//  Created by Babul Mirdha on 6/13/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailsTableViewController : UITableViewController


@property (strong, nonatomic) NSDictionary *detailItem;

@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLable;
@property (strong, nonatomic) IBOutlet UILabel *bookDescriptionLable;
@property (strong, nonatomic) IBOutlet UITextView *eBookDescriptionTextView;

@property (strong, nonatomic) IBOutlet UIButton *buyButton;



- (IBAction)shareButton:(id)sender;


- (IBAction)openEBookInSafari:(id)sender;


@property(nonatomic,strong)UIImage *CVImage;


@property (strong, nonatomic) IBOutlet UILabel *price;

- (void)setDetailItem:(id)newDetailItem;// withImage: (UIImage*) image;
- (void)configureView;

@end
