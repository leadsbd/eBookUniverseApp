//
//  RightMenuViewController.h
//  SlideMenu
//
//  Created by Babul Mirdha on 6/16/13.
//  Copyright (c) 2013 Indee Box LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate<NSObject>
@required
-(void) didSelectedMenuItemWithTitle:(NSString*) title andCategoryId:(NSNumber*) index andUrl: (NSString*) url;

@end

@interface RightAmazonMenuViewController : UITableViewController

@property (strong) id <MenuViewControllerDelegate> delegate;
@property (strong, nonatomic) NSString *url;

@end
