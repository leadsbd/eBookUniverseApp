//
//  AmazonWebViewController.m
//  eBookUniverse
//
//  Created by Farzana on 6/23/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//


//@class ItemAttributes;

#import "AmazonWebViewController.h"
#import "ItemAttributes.h"
#import "Image.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
@interface AmazonWebViewController ()

@property(nonatomic,copy) NSArray *excludedActivityTypes;
@end

@implementation AmazonWebViewController
@synthesize detailurl;
@synthesize amazonWebView;
@synthesize goBack;
@synthesize goForward;
@synthesize item;
@synthesize excludedActivityTypes;
@synthesize webViewNavigationBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    

    
    
    amazonWebView.scalesPageToFit=YES;
    self.amazonWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);


    [amazonWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:item.detailPageURL]]];

    
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.amazonPagerViewController)
    {
        [appDelegate.amazonPagerViewController.navivationBar removeFromSuperview ];
    }
    
  [[self navigationController] setNavigationBarHidden:NO animated:YES];
    
//    NSLog(@"x       = %f", self.webViewNavigationBar.titleView.frame.origin.x);
//    NSLog(@"y      = %f", self.webViewNavigationBar.titleView.frame.size.height);
//    
//    
//    
//    //  NSLog(@"height     = %f", self.view.frame.size.height);
//    
//    CGRect cgRect;
//    
//    //self.view.frame.size.height= 320;
//    cgRect.origin.y=0;
//    cgRect.size.height=460;
//    cgRect.size.width=320;
//    self.view.frame= cgRect;
//    //self.view.frame.origin.y=0;
//    [self loadView];
    
    
    self.view.frame = CGRectMake(0, 0, 320, 460);

    

    
    NSLog(@"height     = %f", self.view.frame.size.height);
    NSLog(@"x       = %f", self.view.frame.origin.x);
    NSLog(@"y      = %f", self.view.frame.origin.y);


	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.view.frame = CGRectMake(0, 0, 480, 960);

//    CGRect cgRect;
//    cgRect.origin.x=0;
//    cgRect.origin.y=0;
//    cgRect.size.height=960;
//    cgRect.size.width=320;
//    self.view.frame= cgRect;
    //[self loadView];

    NSLog(@"height     = %f", self.view.frame.size.height);
    NSLog(@"x       = %f", self.view.frame.origin.x);
    NSLog(@"y      = %f", self.view.frame.origin.y);


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    goBack.enabled=[webView canGoBack];
    goForward.enabled=[webView canGoForward];
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
    
}

- (IBAction)doneButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)shareButton:(id)sender {
    
    
    
    
    NSString *imageURL=item.largeImage.url;
    
     UIImageView *imageV=[[UIImageView alloc]init];
    
    
    __weak typeof(imageV) weakImageV = imageV;

    [imageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageURL]] placeholderImage:[UIImage new] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        if(image)
            
        {
            weakImageV.image=image;
            [weakImageV setNeedsLayout];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Fail");
        
    }];
    
    
    
    NSString *urlString = item.detailPageURL;
    NSURL *url1 = [NSURL URLWithString:urlString];
    
    
    
   // UIImage *secondImage=[UIImage imageNamed:@"home"];
    
    NSString *secondMsg=@"It's just an great App";
    
    NSArray *activityItems = @[url1,secondMsg];
    

 
//
//    NSString *caption =item.itemAttributes.title;
//    
//    
//    NSArray *activityItems = @[caption,imageV.image,secondMsg];
    
    
    // Initialize Activity View Controller
   UIActivityViewController *vc = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];

//    if (vc) {
//        
//  
//    
//    [vc setCompletionHandler:^(NSString *activityType, BOOL completed) {
//        
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"Shared Successfully" delegate:self cancelButtonTitle:@"Done" otherButtonTitles: nil];
//        [alert show];
//     NSLog(@"completed dialog - activity: %@ - finished flag: %d", activityType, completed);
//    }];
//
//      }
//    
//
//       NSLog(@"Failed to share");
//   
//    // Present Activity View Controller
    [self presentViewController:vc animated:YES completion:nil];
    
   // [self initWithActivityItems:activityItems applicationActivities:activityItems];
    
    
}
//
//- (id)initWithActivityItems:(NSArray *)activityItems applicationActivities:(NSArray *)applicationActivities{
//
//    NSLog(@"activity arry %@",activityItems);
//    return nil;
//}

- (void)viewDidUnload {
    [self setWebViewNavigationBar:nil];
    [super viewDidUnload];
}
@end
