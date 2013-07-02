//
//  RightMenuViewController.m
//  SlideMenu
//
//  Created by Babul Mirdha on 6/16/13.
//  Copyright (c) 2013 Indee Box LLC. All rights reserved.
//

#import "RightAmazonMenuViewController.h"
#import "ECSlidingViewController.h"

@interface RightAmazonMenuViewController ()
@property (strong, nonatomic) NSArray *menu;
@end

@implementation RightAmazonMenuViewController
@synthesize menu;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.menu = [NSArray arrayWithObjects:@"Cat1", @"Cat2" ,nil];
    
    
    [self.slidingViewController setAnchorLeftRevealAmount:360.0f];
    self.slidingViewController.underRightWidthLayout = ECFullWidth;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.menu objectAtIndex:indexPath.row]];
    
    cell.textLabel.textAlignment=NSTextAlignmentRight;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *identifier = [NSString stringWithFormat:@"%@", [self.menu objectAtIndex:indexPath.row]];
    
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController
     anchorTopViewOffScreenTo:ECLeft
     animations:nil
     onComplete:^{
         CGRect frame = self.slidingViewController.topViewController.view.frame;
         self.slidingViewController.topViewController = newTopViewController;
         self.slidingViewController.topViewController.view.frame = frame;
         [self.slidingViewController resetTopView];
     }];
    
}

@end
