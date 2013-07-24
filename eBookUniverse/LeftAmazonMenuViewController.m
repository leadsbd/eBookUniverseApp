//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Kyle Begeman on 1/13/13.
//  Copyright (c) 2013 Indee Box LLC. All rights reserved.
//

#import "LeftAmazonMenuViewController.h"
#import "ECSlidingViewController.h"
#import "AmazonPagerViewController.h"

@interface LeftAmazonMenuViewController ()

@end

@implementation LeftAmazonMenuViewController
{
    
}

@synthesize menu;
@synthesize delegate;
@synthesize catagoryDict;

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
       
    
    catagoryDict =[[NSMutableDictionary alloc] init];
    
    
    [catagoryDict setObject:@"Arts & Photography Books" forKey:[NSNumber numberWithInt:1]];
    [catagoryDict setObject:@"Biographies and Memoirs" forKey:[NSNumber numberWithInt:2]];

    [catagoryDict setObject:@"Business & Investing Books" forKey:[NSNumber numberWithInt:3]];

    [catagoryDict setObject:@"Children's Books" forKey:[NSNumber numberWithInt:4]];
    [catagoryDict setObject:@"Comics & Graphic Novels" forKey:[NSNumber numberWithInt:4366]];
    [catagoryDict setObject:@"Computer & Internet Books" forKey:[NSNumber numberWithInt:5]];
    [catagoryDict setObject:@"Cooking, Food & Wine" forKey:[NSNumber numberWithInt:6]];
    
    [catagoryDict setObject:@"Mystery & Thrillers" forKey:[NSNumber numberWithInt:18]];
    [catagoryDict setObject:@"Science Fiction and Fantasy Books" forKey:[NSNumber numberWithInt:25]];
    [catagoryDict setObject:@"Professional & Technical Books" forKey:[NSNumber numberWithInt:173507]];

    
    //self.menu=[catagoryDict allKeys];
    
       
    self.menu=[NSMutableArray arrayWithArray:[catagoryDict allKeys]];
    
    
//        Entertainment Books (86)
//    Gay & Lesbian Books (301889)
//    Health, Mind and Body (10)
//    History Books (9)
//    Home & Garden Books (48)
//    Law (10777)
//    Literature & Fiction Books (17)
//    Medicine Books (13996)
//    
//    
//    
//    Mystery & Thrillers (18)
//    Nonfiction Books (53)
//    Outdoors & Nature (290060)
//    Parenting & Families (20)
//    Politics & Social Sciences Books (3377866011)
//    Professional & Technical Books (173507)
//    Reference Books (21)
//    Religion & Spirituality (22)
//    Romance Books (23)
//    Science Books (75)
//    Science Fiction and Fantasy Books (25)
//    Sports Books (26)
//    Teens (28)
//    Travel (27)
//    
    
    [self.slidingViewController setAnchorRightRevealAmount:275.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    
    
       
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
   // [self loadView];
    
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

              cell.textLabel.text =  [catagoryDict objectForKey:[self.menu objectAtIndex:indexPath.row]];
 
    NSLog(@"catagoryDict: %@",catagoryDict);
      NSLog(@"menu: %@",menu);
    
    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0) return @"Book Categories";
    else return nil;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      
   AmazonPagerViewController *amazonPagerViewController = (AmazonPagerViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"amazonPager"];
    
    self.delegate=amazonPagerViewController;
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = amazonPagerViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
        
        
       
            NSNumber *key=  [self.menu objectAtIndex:indexPath.row];
            NSString *value=[catagoryDict objectForKey:key];
            [self.delegate didSelectedMenuItemWithTitle:value andCategoryId:key andUrl:self.url];
     
        
       
        
    }];
    
    
}

@end
