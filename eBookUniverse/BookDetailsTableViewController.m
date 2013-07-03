//
//  BookDetailsTableViewController.m
//  RainFall
//
//  Created by Babul Mirdha on 6/13/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import "BookDetailsTableViewController.h"
#import "AFJSONRequestOperation.h"
#import "NSString+stripHtml.h"
#import "UIImageView+AFNetworking.h"


@interface BookDetailsTableViewController ()


@end

@implementation BookDetailsTableViewController
@synthesize coverImageView;
@synthesize eBookDescriptionTextView;
@synthesize price;
@synthesize CVImage;
@synthesize buyButton;



#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem// withImage: (UIImage*) image
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        //self.coverImageView.image=image;
        
        // Update the view.
       [self configureView];
        
        
        NSLog(@"%@",_detailItem);
        
       
        
    }
}

-(void)viewDidAppear:(BOOL)animated{


}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.titleLable.text  = [self.detailItem objectForKey:@"trackName"];
        
        NSLog(@" [self.detailItem objectForKey: %@", [self.detailItem objectForKey:@"trackName"]);

        
        NSString *atrStr=[self.detailItem objectForKey:@"description"];
        NSString* stripped = [atrStr stripHtml];
        
        self.eBookDescriptionTextView.text=stripped;
    
        
        self.price.text=[self.detailItem objectForKey:@"formattedPrice"];
       
     NSString *artworkUrl60=[self.detailItem objectForKey:@"artworkUrl60"];
        
        //__weak typeof(self) weakSelf = self;

      [ self.coverImageView setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:artworkUrl60]] placeholderImage:[UIImage new] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
       
           
        {
           if(image)
                           {
               
               self.coverImageView.image=image;
               [self.coverImageView setNeedsLayout];
            }
        
       }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
       NSLog(@"Fail");
    }];
        
        
    
}

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[self.detailItem objectForKey:@"formattedPrice"] isEqualToString:@"Free"]) {
        [buyButton setTitle:@"Download" forState:UIControlStateNormal];

    }
   
       [self configureView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)openEbookInSafari:(id)sender {
    
    
    NSString *trackUrl=[self.detailItem objectForKey:@"trackViewUrl"];

    NSURL* url = [NSURL URLWithString:trackUrl];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction)shareButton:(id)sender {

    
    NSString *trackUrl=[self.detailItem objectForKey:@"trackViewUrl"];
    
    NSURL* url = [NSURL URLWithString:trackUrl];
    
    NSString *secondMsg=@"It's just an great App";
    
    NSArray *activityItems = @[url,secondMsg];
    
    
    // Initialize Activity View Controller
    UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    
    [vc setCompletionHandler:^(NSString *activityType, BOOL completed) {
        
       UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Shared Successfully" delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
          [alert show];
        NSLog(@"completed dialog - activity: %@ - finished flag: %d", activityType, completed);
    }];

    // Present Activity View Controller
    [self presentViewController:vc animated:YES completion:nil];


}
@end
