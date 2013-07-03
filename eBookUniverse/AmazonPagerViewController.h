//
//  GeneralPageController.h
//  BusinessAppDemo
//
//  Created by Babul Mirdha on 12/30/12.
//  Copyright (c) 2012 LeadSoft. All rights reserved.
//


#import "ParentViewController.h"
#import "LeftAmazonMenuViewController.h"
@interface AmazonPagerViewController : ParentViewController<UIScrollViewDelegate,MenuViewControllerDelegate>

{


}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControll;

- (IBAction)changePage:(id)sender;
@property (strong, nonatomic) IBOutlet UINavigationBar *navivationBar;

-(NSMutableArray*)freeEBook;
@end
