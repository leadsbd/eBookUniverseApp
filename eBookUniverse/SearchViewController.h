//
//  SearchViewController.h
//  eBookUniverse
//
//  Created by Farzana on 7/1/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController<UISearchBarDelegate,UISearchDisplayDelegate>


@property (strong, nonatomic) IBOutlet UISearchBar *searchBarDemo;

@end
