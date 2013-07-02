//
//  PaidiBookTableViewController.m
//  eBookUniverse
//
//  Created by Babul Mirdha on 6/22/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import "PaidiBookTableViewController.h"
#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"
#import "BookDetailsTableViewController.h"
#import "CustomCellClass.h"


@interface PaidiBookTableViewController ()

{
    int row;
    int mrow;

}
@property(strong) NSDictionary *jsonDict;
@property(strong) NSArray *books;
@property(strong) NSMutableArray *freeEbooks;
@property(strong) NSMutableArray *paidEbooks;
@property(strong,nonatomic) UIImageView *imageView;
-(NSMutableArray *)getFreePaidEbooks;

@end

@implementation PaidiBookTableViewController
@synthesize jsonDict;
@synthesize books;
@synthesize freeEbooks;
@synthesize paidEbooks;

@synthesize imageView;

- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (IBAction)jsonTapped:(id)sender
{
    
    // 1
    //NSString *weatherUrl = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/search?term=media&media=ebook&limit=50"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     // 3
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        self.jsonDict  = (NSDictionary *)JSON;
                                                        
                                                        self.books=[jsonDict objectForKey:@"results"];
                                                        NSLog(@"jsondict %@",jsonDict);
                                                                                                             
                                                        paidEbooks= [self getFreePaidEbooks];
                                                         self.title =  [NSString stringWithFormat:@"iBookStore Paid: %i", self.paidEbooks.count];
                                                          NSLog(@"%i free ebooks",freeEbooks.count );
                                                            [self.tableView reloadData];
                                                    }
     // 4
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                     message:[NSString stringWithFormat:@"%@",error]
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        [av show];
                                                    }];
    
    // 5
    [operation start];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    [self jsonTapped:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    
    return paidEbooks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
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

    NSDictionary *object = paidEbooks[indexPath.row];
    
    NSString *trackName=[object objectForKey:@"trackName"];
    
  cell.title.text=[NSString stringWithFormat:@"%i. %@",mrow,trackName];
    
    cell.author.text=[NSString stringWithFormat:@"By %@",[object objectForKey:@"artistName"]];
    
    NSLog(@"trackName %@",cell.title.text);
    cell.price.text=[object objectForKey:@"formattedPrice"];

    
    NSString *artworkUrl100=[object objectForKey:@"artworkUrl100"];
    //__weak UITableViewCell *weakCell = cell;
    
    //imageView=cell.imageView;//(UIImageView *)[weakCell viewWithTag:100];
    
    [cell.eBookImage setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:artworkUrl100]] placeholderImage:[UIImage new] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        if(image)
            
        {
            
            cell.eBookImage.image=image;
            
            
            imageView.image=image;
            //[weakCell setNeedsDisplay];
            
            [cell setNeedsLayout];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Fail");
        
    }];
    
    
    
    return cell;
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


//-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [self performSegueWithIdentifier: @"iBookDetail" sender: self];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

//    
//   NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
//    
//    CustomCellClass *cell =(CustomCellClass*) [self.tableView cellForRowAtIndexPath:selectedIndexPath];
    
    
    if ([[segue identifier] isEqualToString:@"iBookPaidDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = paidEbooks[indexPath.row];
        
        [[segue destinationViewController] setDetailItem:object];// withImage:[cell.eBookImage.image copy]];
       // [[segue destinationViewController]setCVImage: [imageView.image copy] ];
     
        

    }
}


-(NSMutableArray *)getFreePaidEbooks{
    
    
    freeEbooks=[[NSMutableArray alloc]init];
    paidEbooks=[[NSMutableArray alloc]init];
    
    for (NSDictionary *freePdidEbooks in books) {
        
        
        if ([[freePdidEbooks objectForKey:@"formattedPrice" ] isEqualToString:@"Free"]) {
            
            [freeEbooks addObject:freePdidEbooks];
            
            // NSLog(@"freeEbooks:%@",freeEbooks);
        }
        else [paidEbooks addObject:freePdidEbooks];
        
        // NSLog(@"paidEbooks:%@",paidEbooks);
    }
    return paidEbooks;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"                  TOP Paid eBooks";
    
}
@end
