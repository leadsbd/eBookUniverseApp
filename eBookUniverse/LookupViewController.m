//
//  LookupViewController.m
//  AWSECDemoApp
//
//  Created by Farzana on 6/13/13.
//  Copyright (c) 2013 Leansoft. All rights reserved.
//

#import "LookupViewController.h"

#import "AWSECommerceServiceClient.h"
#import "CommonTypes.h"
#import "SOAP11Fault.h"
#import "Toast+UIView.h"
//#import "ItemTableViewCell.h"
#import "ItemAttributes.h"
#import "BrowseNodeLookup.h"
#import "BrowseNodeLookupRequest.h"
#import "TopItem.h"

@interface LookupViewController ()
-(void)searchAmazonByKeyword:(NSArray *)asinArray;

//-(void)setCell:(UITableViewCell *)cell fromSearchItem:(Item *)item;

@end

@implementation LookupViewController
@synthesize lookupTableView;
@synthesize asinNoArrryTopSeller;
@synthesize delegateLookUp;

#pragma mark -
#pragma mark UITableViewDelegate

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//    NSLog(@"[_tableData count]: %i",[_tableData count]);
//    
//    return [_tableData count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView
//         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//	
//	// Initialize & Populate table cell
//    
//    // Initialize & Populate table cell
//	NSString *cellID = @"Cell";
//    UITableViewCell *cell = [self.lookupTableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell)
//    {
//        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    }
//    [self setCell:cell fromSearchItem:_tableData[[indexPath row]]];
//    return cell;}
//
//-(void)setCell:(UITableViewCell *)cell fromSearchItem:(Item *)item {
//    
//    
//    cell.textLabel.text=item.itemAttributes.title;
//    
//    cell.detailTextLabel.text=item.itemAttributes.listPrice.formattedPrice;
//
//    NSLog(@" item.customerReviews.hasReviews %@", item.customerReviews.iFrameURL);
//    
//    NSLog(@" ,item.editorialReviews.editorialReview.count %i" ,item.editorialReviews.editorialReview.count);
//    
//     NSLog(@"item.itemAttributes.audienceRating %@", item.itemAttributes.audienceRating);
//    
//    NSLog(@"detailPageURL:%@",item.detailPageURL);
//    
//  
//   
//   // [cell setImageURL:item.smallImage.url];
//    
////    NSString *authorName;
////
////    for (authorName in item.itemAttributes.author) {
////        
////        cell.detailTitleLable.text=authorName;
////    }
//    
// 
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//      // if (!self.detailsViewController) {
//    //        self.detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsView" bundle:nil];
//    //    }
//    //
//    //    Item *item = [_tableData objectAtIndex: [indexPath row]];
//    //    self.detailsViewController.item = item;
//    //
//    //    //switch to the item details view
//    //    [[self navigationController] pushViewController:self.detailsViewController animated:YES];
//}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}



#pragma mark -
#pragma mark Memory management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Search on Amazon Server
-(void)searchAmazonByKeyword:(NSArray *)asinArray {
    
    // start progress activity
    [self.view makeToastActivity];
    
    // get shared client
    AWSECommerceServiceClient *client = [AWSECommerceServiceClient sharedClient];
    client.debug = YES;
    
    // build request
    
ItemLookup *request = [[ItemLookup alloc] init];
   request.associateTag = @"wwwleadsbdcom-20"; // seems any tag is ok
   request.shared = [[ItemLookupRequest alloc] init];

   request.shared.idType = @"ASIN";

request.shared.itemId=[NSMutableArray arrayWithArray:asinArray];

    
    
    
    
    request.shared.responseGroup = [NSMutableArray arrayWithObjects:@"ItemAttributes",@"Reviews",@"Accessories",@"BrowseNodes",@"EditorialReview",@"Images",@"ItemIds",@"Large",@"Medium",@"OfferFull",@" Offers",@"PromotionSummary",@"OfferSummary",@" RelatedItems",@"SalesRank",@"Similarities",@"Small",@"Tracks",@"VariationImages",@"Variations",@"VariationSummary",nil];
    
    // authenticate the request
    // see : http://docs.aws.amazon.com/AWSECommerceService/latest/DG/NotUsingWSSecurity.html
    [client authenticateRequest:@"ItemLookup"];
    
    [client itemLookup:request  success:^(ItemLookupResponse *responseObject) {
        
        
        // stop progress activity
        [self.view hideToastActivity];
        
        
        NSLog(@"responseObject.items.count: %i",responseObject.items.count);
        NSLog(@"responseObject.items.count: %@",responseObject.items);
        
              
        // success handling logic
        if (responseObject.items.count > 0) {
            
            
            Items *items = [responseObject.items objectAtIndex:0];
            
            
            
            // BrowseNode *browseNode=[]
            //NSLog(@"items.item.count  :%i",browseNodes.browseNode.count);
           // BrowseNode *browseNode=[browseNodes.browseNode objectAtIndex:0];
            
            //TopItemSet *topItemSet=[browseNode.topItemSet objectAtIndex:0];
            
            if (items.item.count > 0) {
                // Show found items in the table
                [_tableData removeAllObjects];
                [_tableData addObjectsFromArray:items.item];
                [self.lookupTableView reloadData];
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

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    NSLog(@"asinNoArrryTopSeller:%@",asinNoArrryTopSeller);
    [self getAsin];
    
    if (_tableData) {
        [_tableData removeAllObjects];
    } else {
        _tableData = [[NSMutableArray alloc] init];
    }
}

- (void)dealloc {
    
//    [lookupTableView release];
//    [super dealloc];
}

#pragma mark -
#pragma mark Search on Amazon Server
-(void)getAsin {
    
    // start progress activity
[self.view makeToastActivity];
    
    // get shared client
    AWSECommerceServiceClient *client = [AWSECommerceServiceClient sharedClient];
    client.debug = YES;
    
    // build request
    
    BrowseNodeLookup *request=[[BrowseNodeLookup alloc] init];
    
    request.associateTag=@"wwwleadsbdcom-20";
    
    request.shared=[[BrowseNodeLookupRequest alloc] init];
    request.shared.browseNodeId=[NSMutableArray arrayWithObjects:@"17",@"18",@"11233",@"3048861",@"11232",@"11242",nil];
      
    request.shared.responseGroup = [NSMutableArray arrayWithObjects:@"TopSellers" ,@"NewReleases",nil];
    
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
            
            // BrowseNode *browseNode=[]
            NSLog(@" browseNodes.browseNode.count  :%i",browseNodes.browseNode.count);

            NSMutableArray *browseNodesArray=browseNodes.browseNode;

            for (BrowseNode * node in browseNodesArray) {
                
               
                
                
                if (node.topSellers.topSeller.count > 0) {
                    
                    NSLog(@"Category:%@ \n node.topSellers.topSeller.count  :%i",node.name,node.topSellers.topSeller.count );
                    
                    for (TopSeller *topSeller  in node.topSellers.topSeller )
                    {
                        NSLog(@"Top Seller: %@", topSeller.title);
                    }
                    
              NSArray * array= [ self getTopSellersAsinArray:node.topSellers.topSeller];
                    
                    
                    [self searchAmazonByKeyword:array];
  
                    
                    
                } else {
                    // no result
                    [self.view makeToast:@"No result" duration:3.0 position:@"center"];
                }

                
                
//                NSLog(@"node.topItemSet.count  :%i",node.topItemSet.count );
//
//                for ( topItemSet  in node.topItemSet )
//                {
//                    NSLog(@"topItemSet.topItem :%i",topItemSet.topItem.count );
//                    
//                    for (TopItem *topItem in topItemSet.topItem )
//                    {
//                        NSLog(@"Top Item: %@", topItem.title);
//
//                    }
//                    
//                    
//                }
//                

                
                
                
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

-(NSArray*)getTopSellersAsinArray: (NSMutableArray *) topSellers{
    
    
    NSMutableArray * asinArray=[NSMutableArray new];
    
    for (TopSeller *topSeller  in topSellers )
    {
        //NSLog(@"Top Seller: %@", topSeller.title);
        
        [asinArray addObject:topSeller.asin];
    }
    
//    for (topItem in topSellers) {
//        
//        [asinNoArry addObject:topItem.asin];
//        
//        NSLog(@"%@",asinNoArry);
//        
//        NSLog(@"%@",topItem.productGroup);
//    }
   
    return asinArray;
    
//    NSLog(@"%@",asinNoArry);
//    
//    // lookUpVC.delegateLookUp=self.delegate;
//    
//    lookUpVC.asinNoArrryTopSeller=asinNoArry;
//    
//    NSLog(@"lookUpVC.asinNoArrryTopSeller %@",lookUpVC.asinNoArrryTopSeller);
//   
        
}
- (void)setImageURL:(NSString *)urlString {
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    [self.afImageView setImageWithURLRequest: request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        if (image) {
//            self.thumbnailView.image = image;
//        }
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        // do nothing
//    }];
}
@end
