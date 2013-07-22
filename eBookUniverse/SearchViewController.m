//
//  SearchViewController.m
//  eBookUniverse
//
//  Created by Farzana on 7/1/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize searchBarDemo;

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
    
    searchBarDemo.delegate=self;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    NSLog(@"cancel clicked");
    [searchBar resignFirstResponder]; // dismiss keyboard
    return;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}

///* Delegate for when touch ends.  */
//-(void)touchesEnded:(NSSet *)touches
//          withEvent:(UIEvent *)event
//{
//    [searchBarDemo resignFirstResponder];
//}
@end
