//
//  FreeViewController.m
//  eBookUniverse
//
//  Created by Babul Mirdha on 6/20/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import "FreeAmazonViewController.h"
#import "AWSECommerceServiceClient.h"
#import "CommonTypes.h"
#import "SOAP11Fault.h"
#import "Toast+UIView.h"
#import "ItemAttributes.h"
#import "BrowseNodeLookup.h"
#import "BrowseNodeLookupRequest.h"
#import "UIImageView+AFNetworking.h"
#import "AmazonWebViewController.h"
#import "CustomCellClass.h"
#import "Price.h"

@interface FreeAmazonViewController ()

{
    ItemAttributes *itemAttribute;
    AmazonWebViewController *webViewController;
    int rowPlusOne;
    int row;
    
}

-(void)setCell:(CustomCellClass *)cell fromSearchItem:(Item *)item;

@end

@implementation FreeAmazonViewController
@synthesize  topTableViewFree;
@synthesize tableData;


#pragma mark -
#pragma mark UITableViewDelegate

- (void)viewDidLoad
{
	[super viewDidLoad];
    
    // start progress activity

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
    
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell =[[UITableViewCell alloc] init];
    }
    row=indexPath.row ;
    NSLog(@"row %i",row);
    rowPlusOne=row+1;
    NSLog(@"mrow %i",rowPlusOne);
    
    
[self setCell:cell fromSearchItem:tableData[[indexPath row]]];
    
    // stop progress activity
 [self.view hideToastActivity];
    
    return cell;
    
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"                  TOP 10 eBooks";
    
}

-(void)setCell:(CustomCellClass *)cell fromSearchItem:(Item *)item {
    
    
    NSString *imageURL=item.largeImage.url;
    
    __weak typeof(cell) weakCell = cell;
    
    [cell.eBookImage setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageURL]] placeholderImage:[UIImage new] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {

        if(image)
            
        {
            weakCell.eBookImage.image=image;
            [weakCell setNeedsLayout];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Fail");
        
    }];

    
    
    NSString *authorName;
    for (authorName in item.itemAttributes.author) {
        
        cell.author.text=[NSString stringWithFormat:@"By %@",authorName];
        
    }

    cell.title.text=[NSString stringWithFormat:@"%i. %@", rowPlusOne,item.itemAttributes.title];
    
    cell.price.text=item.itemAttributes.listPrice.formattedPrice;
    
    NSLog(@"item.itemAttributes.listPrice.formattedPrice %@",item.itemAttributes.listPrice.formattedPrice);
    

    
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    NSIndexPath *indexPath = [self.topTableViewFree indexPathForSelectedRow];
    
    Item *item= tableData[indexPath.row];
    
    UINavigationController *nc=segue.destinationViewController;
    
    webViewController=[nc.viewControllers objectAtIndex:0];
    
    webViewController.item=item;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
