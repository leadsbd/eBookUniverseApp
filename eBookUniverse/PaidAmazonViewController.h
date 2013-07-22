//
//  PaidViewController.h
//  eBookUniverse
//
//  Created by Babul Mirdha on 6/20/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"



@interface PaidAmazonViewController : UIViewController<UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *topTableView;
@property (strong, nonatomic) NSMutableArray *tableData;
@property (nonatomic, retain) Item *item;
@end
