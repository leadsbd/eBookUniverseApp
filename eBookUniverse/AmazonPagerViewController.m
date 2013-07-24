//
//  GeneralPageController.m
//  BusinessAppDemo
//
//  Created by Babul Mirdha on 12/30/12.
//  Copyright (c) 2012 LeadSoft. All rights reserved.
//

#import "AmazonPagerViewController.h"

//for lookup request
#import "AWSECommerceServiceClient.h"
#import "CommonTypes.h"
#import "SOAP11Fault.h"
#import "Toast+UIView.h"
#import "ItemAttributes.h"
#import "BrowseNodeLookup.h"
#import "BrowseNodeLookupRequest.h"
#import "LookupViewController.h"
#import "TopItem.h"
#import "UIImageView+AFNetworking.h"
#import "PaidAmazonViewController.h"
#import "AppDelegate.h"
#import "ItemAttributes.h"
#import "FreeAmazonViewController.h"

@interface AmazonPagerViewController ()


{


    
    NSMutableArray *freeEbookArray;
    NSMutableArray *paidEbookArray;

}
@property (assign) BOOL pageControlUsed;
@property (assign) NSUInteger page;
@property (assign) BOOL rotating;
- (void)loadScrollViewWithPage:(int)page;
-(NSMutableArray*)freeEBook:( NSMutableArray *) itemX;
-(void)getAsinByCategoryId:(NSNumber*)categoryID andCategoryTitle:(NSString*) categoryTitle AndUrl:(NSString*) url;
-(void)searchAmazonByKeyword:(NSArray *)asinArray withUrl:(NSString*) url ;
@end

@implementation AmazonPagerViewController
@synthesize scrollView;
@synthesize pageControll;

@synthesize pageControlUsed = _pageControlUsed;
@synthesize page = _page;
@synthesize rotating = _rotating;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (void)addChildControllers
{
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"paidAmazon"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"freeAmazon"]];
	
    
    
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.scrollView setPagingEnabled:YES];
	[self.scrollView setScrollEnabled:YES];
	[self.scrollView setShowsHorizontalScrollIndicator:NO];
	[self.scrollView setShowsVerticalScrollIndicator:NO];
	[self.scrollView setDelegate:self];

    
    [self addChildControllers];
    
    
    AppDelegate *appDelegate=[[UIApplication sharedApplication ] delegate];
    appDelegate.amazonPagerViewController=self;

    if(appDelegate.firstTime==NO){
       
        //[self getAsinByCategoryId:[NSNumber numberWithInt:916520] andCategoryTitle:@"Books" AndUrl:@"https://webservices.amazon.ca/onca/soap?Service=AWSECommerceService"];
        
        [self getAsinByCategoryId:[NSNumber numberWithInt:1] andCategoryTitle:@"Books" AndUrl:@"https://webservices.amazon.com/onca/soap?Service=AWSECommerceService"];
        
        appDelegate.firstTime=YES;
    }
    
    AppDelegate *appDeletage=[[UIApplication sharedApplication] delegate];
    
    if(appDeletage.amazonPagerViewController==nil){
        appDeletage.amazonPagerViewController=self;
    }
 
}





- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
	return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
	[viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	_rotating = YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
	[viewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [self.childViewControllers count], scrollView.frame.size.height);
	NSUInteger page = 0;
	for (viewController in self.childViewControllers) {
		CGRect frame = self.scrollView.frame;
		frame.origin.x = frame.size.width * page;
		frame.origin.y = 0;
		viewController.view.frame = frame;
		page++;
	}
	
	CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * _page;
    frame.origin.y = 0;
	[self.scrollView scrollRectToVisible:frame animated:NO];
	
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	_rotating = NO;
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
	[viewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	for (NSUInteger i =0; i < [self.childViewControllers count]; i++) {
		[self loadScrollViewWithPage:i];
	}
	
	self.pageControll.currentPage = 0;
	_page = 0;
	[self.pageControll setNumberOfPages:[self.childViewControllers count]];
	
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewWillAppear:animated];
	}
	
	self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [self.childViewControllers count], scrollView.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	if ([self.childViewControllers count]) {
		UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
		if (viewController.view.superview != nil) {
			[viewController viewDidAppear:animated];
		}
	}
}

- (void)viewWillDisappear:(BOOL)animated {
	if ([self.childViewControllers count]) {
		UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
		if (viewController.view.superview != nil) {
			[viewController viewWillDisappear:animated];
		}
	}
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewDidDisappear:animated];
	}
	[super viewDidDisappear:animated];
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0)
        return;
    if (page >= [self.childViewControllers count])
        return;
    
	// replace the placeholder if necessary
    UIViewController *controller = [self.childViewControllers objectAtIndex:page];
    if (controller == nil) {
		return;
    }
	
	// add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
    }
}




- (void)viewDidUnload
{
    [self setScrollView:nil];
    [self setPageControll:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}




#pragma mark nextPage previouspare method.






- (IBAction)changePage:(id)sender {
    
    int page = ((UIPageControl *)sender).currentPage;
	
	// update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    
	UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
	UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
	[oldViewController viewWillDisappear:YES];
	[newViewController viewWillAppear:YES];
	
	[self.scrollView scrollRectToVisible:frame animated:YES];
	
	// Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    _pageControlUsed = YES;
}


-(void) didSelectedMenuItemWithTitle:(NSString*) title andCategoryId:(NSNumber*) index andUrl: (NSString*) url
{
 
    UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
    
    NSLog(@"title: %@ index%@, viewController %@",title,index,viewController);
   
     [self getAsinByCategoryId:index andCategoryTitle:title AndUrl:url];
    
}


#pragma mark -
#pragma mark UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (_pageControlUsed || _rotating) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
	
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    if (page < 0)
        return;
    if (page >= [self.childViewControllers count])
        return;
    
    
   
    
    
	if (self.pageControll.currentPage != page) {
		UIViewController *oldViewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
		UIViewController *newViewController = [self.childViewControllers objectAtIndex:page];
		[oldViewController viewWillDisappear:YES];
        		[newViewController viewWillAppear:YES];
		self.pageControll.currentPage = page;
		[oldViewController viewDidDisappear:YES];
		[newViewController viewDidAppear:YES];
		_page = page;
	}
    
    

    
}

// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _pageControlUsed = NO;
}


- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	UIViewController *oldViewController = [self.childViewControllers objectAtIndex:_page];
	UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControll.currentPage];
	[oldViewController viewDidDisappear:YES];
	[newViewController viewDidAppear:YES];
	
	_page = self.pageControll.currentPage;
}


//LookUp request to Amazon

-(void)getAsinByCategoryId:(NSNumber*)categoryID andCategoryTitle:(NSString*) categorytitle AndUrl:(NSString*) url {
     self.navivationBar.topItem.title=categorytitle;
    
//    // start progress activity
//    [self.view makeToastActivity];
    
    // get shared client
    
    
    //AWSECommerceServiceClient *client = nil;
    AWSECommerceServiceClient *client =[AWSECommerceServiceClient sharedClientWithUrl:url];
    client.debug = YES;
    
    // build request
    
    BrowseNodeLookup *request=[[BrowseNodeLookup alloc] init];
    
    request.associateTag=@"funebooks-20";
    //request.associateTag=@"wwwleadscom-20";
    
    request.shared=[[BrowseNodeLookupRequest alloc] init];
    request.shared.browseNodeId= [NSMutableArray arrayWithObjects:[categoryID stringValue],nil];
    
    request.shared.responseGroup = [NSMutableArray arrayWithObjects:@"TopSellers" ,nil];
    
    // authenticate the request
    // see : http://docs.aws.amazon.com/AWSECommerceService/latest/DG/NotUsingWSSecurity.html
    [client authenticateRequest:@"BrowseNodeLookup"];
    
    [client browseNodeLookup:request success:^(BrowseNodeLookupResponse *responseObject) {
        
        // stop progress activity
        [self.view hideToastActivity];
        
        
        NSLog(@"responseObject.items.count: %i",responseObject.browseNodes.count);
        NSLog(@"responseObject.items.count: %@",responseObject.browseNodes);
        
        // success handling logic
        if (responseObject.browseNodes.count > 0) {
            
            
            BrowseNodes *browseNodes = [responseObject.browseNodes objectAtIndex:0];

           // NSLog(@" browseNodes.browseNode.count  :%i",browseNodes.browseNode.count);
            
            NSMutableArray *browseNodesArray=browseNodes.browseNode;
            
            for (BrowseNode * node in browseNodesArray) {

                if (node.topSellers.topSeller.count > 0) {
                    
                    //NSLog(@"Category:%@ \n node.topSellers.topSeller.count  :%i",node.name,node.topSellers.topSeller.count );
                    
                    for (TopSeller *topSeller  in node.topSellers.topSeller )
                    {
                       // NSLog(@"Top Seller: %@", topSeller.title);
                    }
                    
                    NSArray * array= [ self getTopSellersAsinArray:node.topSellers.topSeller byCategoryName:node.name];
                    
                     
                    [self searchAmazonByKeyword:array withUrl:url];

                } else {
                    // no result
                    [self.view makeToast:@"No result" duration:3.0 position:@"center"];
                }

                
                
            }
            
            
            
        } else {
            // no result
            [self.view makeToast:@"No result" duration:3.0 position:@"center"];
        }
    } failure:^(NSError *error, id<PicoBindable> soapFault) {
        // stop progress activity
        [self.view hideToastActivity];
        
        // error handling logic
        if (error) { // http or parsing error
            [self.view makeToast:[error localizedDescription] duration:3.0 position:@"center" title:@"Error"];
        } else if (soapFault) {
            SOAP11Fault *soap11Fault = (SOAP11Fault *)soapFault;
            [self.view makeToast:soap11Fault.faultstring duration:3.0 position:@"center" title:@"SOAP Fault"];
        }
    }];
    
    
}


-(NSArray*)getTopSellersAsinArray: (NSMutableArray *) topSellers byCategoryName:(NSString *)categoryName{
    
    
    
   // NSLog(@"category name %@",categoryName);
    
    NSMutableArray * asinArray=[NSMutableArray new];
    
    for (TopSeller *topSeller  in topSellers )
    {
        //NSLog(@"Top Seller: %@", topSeller.title);
        
        [asinArray addObject:topSeller.asin];
    }

    return asinArray;

}

#pragma mark -
#pragma mark Search on Amazon Server


-(void)searchAmazonByKeyword:(NSArray *)asinArray withUrl:(NSString*) url {
    
//    // start progress activity
//    [self.view makeToastActivity];
    
    // get shared client
    
    AWSECommerceServiceClient *client = [AWSECommerceServiceClient sharedClientWithUrl:url];
    client.debug = YES;
    
    // build request
    
    ItemLookup *request = [[ItemLookup alloc] init];
    request.associateTag = @"funebooks-20"; // seems any tag is ok
    request.shared = [[ItemLookupRequest alloc] init];
    
    request.shared.idType = @"ASIN";
    
    
    request.shared.itemId=[NSMutableArray arrayWithArray:asinArray];

    request.shared.responseGroup = [NSMutableArray arrayWithObjects:@"ItemAttributes",@"BrowseNodes",@"Images",nil];//@"ItemIds",@"Large",@"Medium",//@"Reviews",@"Accessories",@"EditorialReview",@"OfferFull",@" Offers",@"PromotionSummary",@"OfferSummary",@" RelatedItems",@"SalesRank",@"Similarities",@"Small",@"Tracks",@"VariationImages",@"Variations",@"VariationSummary",nil];
    
    // authenticate the request
    // see : http://docs.aws.amazon.com/AWSECommerceService/latest/DG/NotUsingWSSecurity.html
    [client authenticateRequest:@"ItemLookup"];
    
    [client itemLookup:request  success:^(ItemLookupResponse *responseObject) {

        // success handling logic
        if (responseObject.items.count > 0) {
            
            Items *items = [responseObject.items objectAtIndex:0];
         
             if (items.item.count > 0) {

         //itemX=items.item;
                 
               freeEbookArray= [self freeEBook:items.item];
//                 
//                   NSLog(@"freeEbookArray%@",freeEbookArray);
                 
                 
                 UINavigationController *paidnavVC =(UINavigationController*) [self.childViewControllers objectAtIndex:0];
                 
                 
                 

                 
            PaidAmazonViewController *viewController =(PaidAmazonViewController*) [[paidnavVC viewControllers] objectAtIndex:0];
//                 
//                 UINavigationController *nc;//=segue.destinationViewController;
//                
//                    viewController=[nc.viewControllers objectAtIndex:0];

                // Show found items in the table
                [viewController.tableData removeAllObjects];
                [viewController.tableData addObjectsFromArray:paidEbookArray];

               [viewController.topTableView reloadData];
                 
                 
                 UINavigationController *freenavVC =(UINavigationController*) [self.childViewControllers objectAtIndex:1];
                 
                 FreeAmazonViewController *freeVc =(FreeAmazonViewController*) [[freenavVC viewControllers] objectAtIndex:0];

                                NSLog(@"FreeAmazonViewController: %@", freeVc);
                 
                 if([freeVc isKindOfClass:[FreeAmazonViewController class]])
                {
                     [freeVc.tableData removeAllObjects];
                     [freeVc.tableData addObjectsFromArray:freeEbookArray];
                     
                     [freeVc.topTableViewFree reloadData];
                     
                 }

                 
                 
                 
                 [self.view hideToastActivity];
                
            } else {
                // no result
                [self.view makeToast:@"No result" duration:3.0 position:@"center"];
            }
            
        } else {
            // no result
            [self.view makeToast:@"No result" duration:3.0 position:@"center"];
        }
        
        
    } failure:^(NSError *error, id<PicoBindable> soapFault) {
        // stop progress activity
        [self.view hideToastActivity];
        
        // error handling logic
        if (error) { // http or parsing error
            [self.view makeToast:[error localizedDescription] duration:3.0 position:@"center" title:@"Error"];
        } else if (soapFault) {
            SOAP11Fault *soap11Fault = (SOAP11Fault *)soapFault;
            [self.view makeToast:soap11Fault.faultstring duration:3.0 position:@"center" title:@"SOAP Fault"];
        }
    }];
}

//
-(NSMutableArray*)freeEBook:( NSMutableArray *) itemX{
    
    
    freeEbookArray=[[NSMutableArray alloc] init];
      paidEbookArray=[[NSMutableArray alloc] init];
    
   
    
    for (Item *expectedItem in itemX) {
        
        if (expectedItem.itemAttributes.listPrice.formattedPrice==NULL) {
            
            [freeEbookArray addObject:expectedItem];
            
            NSLog(@"%@",freeEbookArray);
    

        }
        
        else{ [paidEbookArray addObject:expectedItem];
        
               }
    }
return freeEbookArray;
}





@end
