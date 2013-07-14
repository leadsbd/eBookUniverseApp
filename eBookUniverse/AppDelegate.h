//
//  AppDelegate.h
//  eBookUniverse
//
//  Created by Babul Mirdha on 6/20/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmazonPagerViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) AmazonPagerViewController *amazonPagerViewController;


@property (nonatomic) BOOL firstTime;

// FBSample logic
// In this sample the app delegate maintains a property for the current
// active session, and the view controllers reference the session via
// this property, as well as play a role in keeping the session object
// up to date; a more complicated application may choose to introduce
// a simple singleton that owns the active FBSession object as well
// as access to the object by the rest of the application
//@property (strong, nonatomic) FBSession *session;

@end
