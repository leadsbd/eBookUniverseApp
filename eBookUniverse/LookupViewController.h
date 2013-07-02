//
//  LookupViewController.h
//  AWSECDemoApp
//
//  Created by Farzana on 6/13/13.
//  Copyright (c) 2013 Leansoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "TopItem.h"
#import "TopItemSet.h"

@class LookupViewController;
@protocol LookupViewControllerDelegate

@end

@interface LookupViewController : UIViewController<UITableViewDelegate>
{
    // container halding search results;
    NSMutableArray *_tableData;
    NSMutableArray *asinNoArrryTopSeller;
    
    
        ItemAttributes *itemAttribute;
        NSMutableArray *topItemsArry;
        TopItemSet *topItemSet;
        

        
        LookupViewController *lookUpVC;
        


}

@property (retain, nonatomic) IBOutlet UITableView *lookupTableView;
@property (retain, nonatomic) NSMutableArray *asinNoArrryTopSeller;

@property (nonatomic, retain) Item *item;
@property (nonatomic, strong) id <LookupViewControllerDelegate> delegateLookUp;
-(void)getAsin;
- (void)setImageURL:(NSString *)urlString;
           


@end
