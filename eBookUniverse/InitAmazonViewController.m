//
//  InitViewController.m
//  SlideMenu
//
//  Created by Kyle Begeman on 1/13/13.
//  Copyright (c) 2013 Indee Box LLC. All rights reserved.
//

#import "InitAmazonViewController.h"

@interface InitAmazonViewController ()
@end

@implementation InitAmazonViewController



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
	
   
    self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"amazonPager"];
      
   
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
