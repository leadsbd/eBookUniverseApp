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

@interface AmazonWebViewController ()


@end

@implementation AmazonWebViewController
@synthesize detailurl;
@synthesize amazonWebView;
@synthesize goBack;
@synthesize goForward;
@synthesize item;


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
    
    amazonWebView.scalesPageToFit=YES;
    self.amazonWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);


    [amazonWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:item.detailPageURL]]];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    

    [imageV setImageWithURLRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:imageURL]] placeholderImage:[UIImage new] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        if(image)
            
        {
            imageV.image=image;
            [imageV setNeedsLayout];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"Fail");
        
    }];
    
    
    
    NSString *urlString = item.detailPageURL;
    NSURL *url1 = [NSURL URLWithString:urlString];
    
    
    
    UIImage *secondImage=[UIImage imageNamed:@"home"];
    
    NSString *secondMsg=@"It's just an great App";
    
    NSArray *activityItems = @[url1,secondMsg];
    

 
//
//    NSString *caption =item.itemAttributes.title;
//    
//    
//    NSArray *activityItems = @[caption,imageV.image,secondMsg];
    
    
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
