//
//  PaidViewController.m
//  eBookUniverse
//
//  Created by Babul Mirdha on 6/20/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import "PaidAmazonViewController.h"
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
#import "AmazonWebViewController.h"
#import "CustomCellClass.h"
#import "Price.h"


@interface PaidAmazonViewController ()

{
    ItemAttributes *itemAttribute;
    NSMutableArray *topItemsArry;
    TopItemSet *topItemSet;
    
    NSMutableArray *asinNoArry;
    
    LookupViewController *lookUpVC;
    
    AmazonWebViewController *webViewController;
    NSMutableArray *asinNoArrryTopSeller;
    int mrow;
    int row;
    
    
}


-(void)setCell:(CustomCellClass *)cell fromSearchItem:(Item *)item;
@property(strong) UIImageView *imageView;



@end

@implementation PaidAmazonViewController
@synthesize  topTableView;

@synthesize imageView;
@synthesize tableData;


#pragma mark -
#pragma mark UITableViewDelegate

- (void)viewDidLoad
{
	[super viewDidLoad];
    if (tableData) {
        [tableData removeAllObjects];
    } else {
        tableData = [[NSMutableArray alloc] init];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"[_tableData count]: %i",[tableData count]);
    
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
	NSString *cellID = [CustomCellClass reuseIdentifier];

    CustomCellClass *cell = (CustomCellClass*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell =[[CustomCellClass alloc] init];
    }
    row=indexPath.row ;
    NSLog(@"row %i",row);
    mrow=row+1;
    NSLog(@"mrow %i",mrow);
    
    
    [self setCell:cell fromSearchItem:tableData[[indexPath row]]];
    

    return cell;

}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

return @"                  TOP 10 eBooks";

}

-(void)setCell:(CustomCellClass *)cell fromSearchItem:(Item *)item {
    
    
    NSString *imageURL=item.largeImage.url;
    
    [cell.eBookImage setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageURL]] placeholderImage:[UIImage new] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        if(image)
            
        {
            cell.eBookImage.image=image;
            [cell setNeedsLayout];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Fail");
        
    }];
    
    

    NSString *authorName;
    for (authorName in item.itemAttributes.author) {
        
        cell.author.text=[NSString stringWithFormat:@"By %@",authorName];
      
    }
    
    cell.title.text=[NSString stringWithFormat:@"%i. %@", mrow,item.itemAttributes.title];
 
    cell.price.text=item.itemAttributes.listPrice.formattedPrice;

    
    
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
     //[self performSegueWithIdentifier: @"amazon" sender: self];
//       if (!self.detailsViewController) {
//            self.detailsViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsView" bundle:nil];
//    }
//    
//Item *item = [_tableData objectAtIndex: [indexPath row]];
//        self.detailsViewController.item = item;
//    
//        //switch to the item details view
//        [[self navigationController] pushViewController:self.detailsViewController animated:YES];
//}

//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Item *item=tableData [indexPath.row ];
//    
//    NSString *detailUrl=item.detailPageURL;
//
//    NSURL* url = [NSURL URLWithString:detailUrl];
//    [[UIApplication sharedApplication] openURL:url];
//    //[self performSegueWithIdentifier: @"amazonDetail" sender: self];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexPath = [self.topTableView indexPathForSelectedRow];
    
    Item *item= tableData[indexPath.row];
    

//    NSString *urlstr=item.detailPageURL;
//    NSURL* url = [NSURL URLWithString:urlstr];
    
    UINavigationController *nc=segue.destinationViewController;

    webViewController=[nc.viewControllers objectAtIndex:0];
    
    webViewController.item=item;
}


#pragma mark -
#pragma mark Memory management
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
