//
//  AmazonWebViewController.h
//  eBookUniverse
//
//  Created by Farzana on 6/23/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface AmazonWebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *amazonWebView;

@property(strong,nonatomic) NSURL *detailurl;

@property(strong,nonatomic) Item *item;

- (IBAction)doneButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *goForward;
- (IBAction)shareButton:(id)sender;

@end
