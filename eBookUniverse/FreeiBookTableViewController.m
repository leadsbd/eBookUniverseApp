//
//  FreeiBookTableViewController.m
//  eBookUniverse
//
//  Created by Babul Mirdha on 6/22/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import "FreeiBookTableViewController.h"


#import "AFJSONRequestOperation.h"
#import "UIImageView+AFNetworking.h"
#import "BookDetailsTableViewController.h"
#import "CustomCellClass.h"
#import "Toast+UIView.h"


@interface FreeiBookTableViewController ()

{

    int row;
    int rowPlusOne;

}
@property(strong) NSDictionary *jsonDict;
@property(strong) NSArray *books;
@property(strong) NSMutableArray *freeEbooks;
@property(strong) NSMutableArray *paidEbooks;
@property(weak) UIImageView *imageView;
-(NSMutableArray *)getFreePaidEbooks;

@end

@implementation FreeiBookTableViewController
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
                                                        
                                                        
                                                        freeEbooks= [self getFreePaidEbooks];
                                                        self.title =  [NSString stringWithFormat:@"iBooks: %i", self.freeEbooks.count];
                                                        NSLog(@"%i free ebooks",freeEbooks.count );
                                                        [self.tableView reloadData];
                                                    }
     // 4
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error "
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
    
    
    // start progress activity
    [self.view makeToastActivity];
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
    
    
    return freeEbooks.count;
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
        rowPlusOne=row+1;
        NSLog(@"mrow %i",rowPlusOne);
  
    //
    //    [self setCell:cell fromSearchItem:tableData[[indexPath row]]];
    
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    
    [tableView setSeparatorColor:[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.3]];
    
    
    NSDictionary *object = freeEbooks[indexPath.row];
    
    NSString *trackName=[object objectForKey:@"trackName"];
    
    cell.title.text=[NSString stringWithFormat:@"%i. %@",rowPlusOne,trackName];
    
cell.author.text=[NSString stringWithFormat:@"By %@",[object objectForKey:@"artistName"]];
    
    NSLog(@"trackName %@",cell.title.text);
    cell.price.text=[object objectForKey:@"formattedPrice"];
    

    
    NSString *artworkUrl100=[object objectForKey:@"artworkUrl100"];
    
    //__weak typeof(cell) weakCell = cell;

    [cell.eBookImage setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:artworkUrl100]] placeholderImage:[UIImage new] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        if(image)
            
        {
            
            cell.eBookImage.image=image;

            [cell setNeedsLayout];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Fail");
        
    }];
    
    // stop progress activity
    [self.view hideToastActivity];
    return cell;
}




- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"iBookFreeDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = freeEbooks[indexPath.row];
        
        [[segue destinationViewController] setDetailItem:object];
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
    return freeEbooks;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"                  TOP Free eBooks";
    
}

@end
