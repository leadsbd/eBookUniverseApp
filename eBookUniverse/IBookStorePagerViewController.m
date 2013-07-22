//

//  eBookUniverse
//
//  Created by Babul Mirdha on 6/20/13.
//  Copyright (c) 2013 Leads Corporation Limited. All rights reserved.
//

#import "IBookStorePagerViewController.h"

@interface IBookStorePagerViewController ()
@property (assign) BOOL pageControlUsed;
@property (assign) NSUInteger page;
@property (assign) BOOL rotating;
- (void)loadScrollViewWithPage:(int)page;
@end

@implementation IBookStorePagerViewController

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
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"paidiBook"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"freeiBook"]];
	
    
    
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



@end
