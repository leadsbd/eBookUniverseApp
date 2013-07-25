//
//  RightMenuViewController.m
//  SlideMenu
//
//  Created by Babul Mirdha on 6/16/13.
//  Copyright (c) 2013 Indee Box LLC. All rights reserved.
//

#import "RightAmazonMenuViewController.h"
#import "ECSlidingViewController.h"
#import "AppDelegate.h"
#import "LeftAmazonMenuViewController.h"
#import "AmazonPagerViewController.h"
@interface RightAmazonMenuViewController ()
{
    NSMutableDictionary *countriesDict;
    UITableViewCell *oldCell;
}
@property (strong, nonatomic) NSArray *menu;
@end

@implementation RightAmazonMenuViewController
@synthesize menu;
@synthesize delegate;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
       
      
   countriesDict =[[NSMutableDictionary alloc] init];

    NSMutableDictionary *categoryUSA =[[NSMutableDictionary alloc] init];

    [categoryUSA setObject:@"Arts & Photography" forKey:[NSNumber numberWithInt:1]];
    [categoryUSA setObject:@"Biographies and Memoirs" forKey:[NSNumber numberWithInt:2]];
    
    [categoryUSA setObject:@"Business & Investing" forKey:[NSNumber numberWithInt:3]];
    
    [categoryUSA setObject:@"Children's Books" forKey:[NSNumber numberWithInt:4]];
    [categoryUSA setObject:@"Comics & Graphic Novels" forKey:[NSNumber numberWithInt:4366]];
    [categoryUSA setObject:@"Computer & Internet" forKey:[NSNumber numberWithInt:5]];
    [categoryUSA setObject:@"Cooking, Food & Wine" forKey:[NSNumber numberWithInt:6]];
    
    [categoryUSA setObject:@"Mystery & Thrillers" forKey:[NSNumber numberWithInt:18]];
    [categoryUSA setObject:@"Science Fiction and Fantasy" forKey:[NSNumber numberWithInt:25]];
    [categoryUSA setObject:@"Professional & Technical" forKey:[NSNumber numberWithInt:173507]];
    
    NSMutableDictionary *countryDataUSA= [NSMutableDictionary dictionaryWithObjectsAndKeys:@"https://webservices.amazon.com/onca/soap?Service=AWSECommerceService",@"url"
                                       ,categoryUSA, @"category"
                                       ,[NSNumber numberWithInt:1],@"asin", nil];
    
    
    [countriesDict setObject:countryDataUSA forKey:@"USA"];
    
    
    
    
    NSMutableDictionary *categoryCanada =[[NSMutableDictionary alloc] init];

    [categoryCanada setObject:@"Arts & Photography" forKey:[NSNumber numberWithInt:933484]];
    [categoryCanada setObject:@"Biographies and Memoirs" forKey:[NSNumber numberWithInt:934986]];
    
    [categoryCanada setObject:@"Business & Investing" forKey:[NSNumber numberWithInt:935522]];
    
    [categoryCanada setObject:@"Children's Books" forKey:[NSNumber numberWithInt:935948]];
    [categoryCanada setObject:@"Comics & Graphic Novels" forKey:[NSNumber numberWithInt:13932641]];
    [categoryCanada setObject:@"Computer & Technology" forKey:[NSNumber numberWithInt:939082]];
    [categoryCanada setObject:@"CookBooks, Food & Wine" forKey:[NSNumber numberWithInt:940804]];
    
    [categoryCanada setObject:@"Mystery, Thrillers & Suspense" forKey:[NSNumber numberWithInt:948808]];
    [categoryCanada setObject:@"Science Fiction & Fantasy" forKey:[NSNumber numberWithInt:957368]];
    [categoryCanada setObject:@"Professional & Technical" forKey:[NSNumber numberWithInt:950756]];
       
    [countriesDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"https://webservices.amazon.ca/onca/soap?Service=AWSECommerceService",@"url",categoryCanada, @"category", nil] forKey:@"Canada"];
    
    
    
    NSMutableDictionary *categoryGermany =[[NSMutableDictionary alloc] init];
    
    [categoryGermany setObject:@"Film, Kunst & Kultur" forKey:[NSNumber numberWithInt:548400]];
    [categoryGermany setObject:@"Biografien & Erinnerungen" forKey:[NSNumber numberWithInt:187254]];
    
    [categoryGermany setObject:@"Business, Karriere & Geld" forKey:[NSNumber numberWithInt:403434]];
    
    [categoryGermany setObject:@"Kinderbücher" forKey:[NSNumber numberWithInt:280652]];
    [categoryGermany setObject:@"Comics, Manga & Cartoons" forKey:[NSNumber numberWithInt:287621]];
    [categoryGermany setObject:@"Computer & Internet" forKey:[NSNumber numberWithInt:124]];
    [categoryGermany setObject:@"Kochbücher" forKey:[NSNumber numberWithInt:189528]];
    
    [categoryGermany setObject:@"Krimis & Thriller" forKey:[NSNumber numberWithInt:287480]];
    [categoryGermany setObject:@"Fantasy, Science Fiction, Vampire & Horror" forKey:[NSNumber numberWithInt:142]];
    [categoryGermany setObject:@"Naturwissenschaften & Technik" forKey:[NSNumber numberWithInt:121]];
    
    [countriesDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"https://webservices.amazon.de/onca/soap?Service=AWSECommerceService",@"url",categoryGermany, @"category", nil] forKey:@"Germany"];
    
    
    
    NSMutableDictionary *categorySpain =[[NSMutableDictionary alloc] init];
    
    [categorySpain setObject:@"Arte, cine y fotografía" forKey:[NSNumber numberWithInt:902486031]];
    [categorySpain setObject:@"Biografías y hechos reales" forKey:[NSNumber numberWithInt:902498031]];
    
    [categorySpain setObject:@"Economía y empresa" forKey:[NSNumber numberWithInt:902595031]];
    
    [categorySpain setObject:@"Infantil y juvenil" forKey:[NSNumber numberWithInt:902621031]];
    [categorySpain setObject:@"Cómics y manga" forKey:[NSNumber numberWithInt:902516031]];
    [categorySpain setObject:@"Informática, internet y medios digitales" forKey:[NSNumber numberWithInt:902652031]];
    [categorySpain setObject:@"Cocina, bebida y hospitalidad" forKey:[NSNumber numberWithInt:902613031]];

    [categorySpain setObject:@"Policíaca, negra y suspense" forKey:[NSNumber numberWithInt:902685031]];
    [categorySpain setObject:@"Fantasía, terror y ciencia ficción" forKey:[NSNumber numberWithInt:1349107031]];
    [categorySpain setObject:@"Ciencias, tecnología y medicina" forKey:[NSNumber numberWithInt:902503031]];
    
    [countriesDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"https://webservices.amazon.es/onca/soap?Service=AWSECommerceService",@"url",categorySpain, @"category", nil] forKey:@"Spain"];
    
    
    
    NSMutableDictionary *categoryFrance =[[NSMutableDictionary alloc] init];
    
    [categoryFrance setObject:@"Art, Musique et Cinéma" forKey:[NSNumber numberWithInt:301144]];
    [categoryFrance setObject:@"Bandes dessinées et Humour" forKey:[NSNumber numberWithInt:301133]];
    
    [categoryFrance setObject:@"Entreprise et Bourse" forKey:[NSNumber numberWithInt:301135]];
    
    [categoryFrance setObject:@"Jeunesse" forKey:[NSNumber numberWithInt:301137]];
    [categoryFrance setObject:@"Manga" forKey:[NSNumber numberWithInt:302004]];
    [categoryFrance setObject:@"Informatique et Internet" forKey:[NSNumber numberWithInt:301131]];
    [categoryFrance setObject:@"Cuisine et Vins" forKey:[NSNumber numberWithInt:302050]];
    
    [categoryFrance setObject:@"Policier et Suspense" forKey:[NSNumber numberWithInt:301134]];
    [categoryFrance setObject:@"Scolaire et Parascolaire" forKey:[NSNumber numberWithInt:301146]];
    [categoryFrance setObject:@"Sciences, Techniques et Médecine" forKey:[NSNumber numberWithInt:301141]];
    
    [countriesDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"https://webservices.amazon.fr/onca/soap?Service=AWSECommerceService",@"url",categoryFrance, @"category", nil] forKey:@"France"];
    
    
    NSMutableDictionary *categoryJapan =[[NSMutableDictionary alloc] init];
    
    [categoryJapan setObject:@"アート・建築・デザイン" forKey:[NSNumber numberWithInt:466294]];
    [categoryJapan setObject:@"人文・思想" forKey:[NSNumber numberWithInt:571582]];
    
    [categoryJapan setObject:@"ビジネス・経済" forKey:[NSNumber numberWithInt:466282]];
    
    [categoryJapan setObject:@"絵本・児童書" forKey:[NSNumber numberWithInt:466306]];
    [categoryJapan setObject:@"コミック・ラノベ" forKey:[NSNumber numberWithInt:466280]];
    [categoryJapan setObject:@"コンピュータ" forKey:[NSNumber numberWithInt:466298]];
    [categoryJapan setObject:@"暮らし・健康・子育て" forKey:[NSNumber numberWithInt:466304]];
    
    [categoryJapan setObject:@"文学・評論　" forKey:[NSNumber numberWithInt:466284]];
    [categoryJapan setObject:@"医学・薬学・看護学・歯科学" forKey:[NSNumber numberWithInt:492166]];
    [categoryJapan setObject:@"スポーツ・アウトドア" forKey:[NSNumber numberWithInt:2400471051]];
    
    [countriesDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"https://webservices.amazon.co.jp/onca/soap?Service=AWSECommerceService",@"url",categoryJapan, @"category", nil] forKey:@"Japan"];
    
    
    NSMutableDictionary *categoryItaly =[[NSMutableDictionary alloc] init];
    
    [categoryItaly setObject:@"Fotografia" forKey:[NSNumber numberWithInt:508761031]];
    [categoryItaly setObject:@"Biografie, diari e memorie" forKey:[NSNumber numberWithInt:508714031]];
    
    [categoryItaly setObject:@"Impresa, strategia e gestione" forKey:[NSNumber numberWithInt:508789031]];
    
    [categoryItaly setObject:@"Libri per bambini e ragazzi" forKey:[NSNumber numberWithInt:508715031]];
    [categoryItaly setObject:@"Fumetti e manga" forKey:[NSNumber numberWithInt:508784031]];
    [categoryItaly setObject:@"Informatica, Web e Digital Media" forKey:[NSNumber numberWithInt:508733031]];
    [categoryItaly setObject:@"Cucina" forKey:[NSNumber numberWithInt:508822031]];
    
    [categoryItaly setObject:@"Gialli e Thriller" forKey:[NSNumber numberWithInt:508771031]];
    [categoryItaly setObject:@"Fantasy" forKey:[NSNumber numberWithInt:508772031]];
    [categoryItaly setObject:@"Libri universitari e professionali" forKey:[NSNumber numberWithInt:2007176031]];
    
    [countriesDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"https://webservices.amazon.it/onca/soap?Service=AWSECommerceService",@"url",categoryItaly, @"category", nil] forKey:@"Italy"];
    
    
    NSMutableDictionary *categoryUK =[[NSMutableDictionary alloc] init];
    
    [categoryUK setObject:@"Art, Architecture & Photography" forKey:[NSNumber numberWithInt:91]];
    [categoryUK setObject:@"Health, Family & Lifestyle" forKey:[NSNumber numberWithInt:74]];
    
    [categoryUK setObject:@"Business, Finance & Law" forKey:[NSNumber numberWithInt:68]];
    
    [categoryUK setObject:@"Children's Books" forKey:[NSNumber numberWithInt:69]];
    [categoryUK setObject:@"Comics & Graphic Novels" forKey:[NSNumber numberWithInt:274081]];
    [categoryUK setObject:@"Computing & Internet" forKey:[NSNumber numberWithInt:71]];
    [categoryUK setObject:@"Food & Drink" forKey:[NSNumber numberWithInt:66]];
    
    [categoryUK setObject:@"Crime, Thrillers & Mystery" forKey:[NSNumber numberWithInt:72]];
    [categoryUK setObject:@"Science Fiction & Fantasy" forKey:[NSNumber numberWithInt:56]];
    [categoryUK setObject:@"Scientific, Technical & Medical" forKey:[NSNumber numberWithInt:564334]];
    
    [countriesDict setObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:@"https://webservices.amazon.co.uk/onca/soap?Service=AWSECommerceService",@"url",categoryUK, @"category", nil] forKey:@"UK"];
    
    self.menu =  [countriesDict allKeys];
    
    
      
    
    [self.slidingViewController setAnchorLeftRevealAmount:275.0f];
    self.slidingViewController.underRightWidthLayout = ECFullWidth;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [self.menu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.menu objectAtIndex:indexPath.row]];
    
    cell.textLabel.textAlignment=NSTextAlignmentRight;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if(oldCell)
    {
        oldCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (newCell.accessoryType == UITableViewCellAccessoryNone) {
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        oldCell=newCell;
        
    }else {
        newCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    
    NSString *countryName = [NSString stringWithFormat:@"%@", [self.menu objectAtIndex:indexPath.row]];
    
      
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    
    if(appDelegate.amazonPagerViewController){
        
      NSMutableDictionary *dict=  [countriesDict objectForKey:countryName];
               
      LeftAmazonMenuViewController *leftAMVC= (LeftAmazonMenuViewController*) appDelegate.amazonPagerViewController.slidingViewController.underLeftViewController;
        
        leftAMVC.countryNames = countryName;
        
                
        NSLog(@"menu: %@",leftAMVC.menu);

        
        [leftAMVC.catagoryDict removeAllObjects];
        
        [leftAMVC.catagoryDict addEntriesFromDictionary:[dict objectForKey:@"category"]];
        
                
       // NSLog(@"leftAMVC.catagoryDict: %@",leftAMVC.catagoryDict);
        NSLog(@"[leftAMVC.catagoryDict:allKeys ] %@",[leftAMVC.catagoryDict allKeys]);
        
       // [leftAMVC.menu arrayByAddingObjectsFromArray:[leftAMVC.catagoryDict allKeys]];
        leftAMVC.menu =[NSMutableArray arrayWithArray:[leftAMVC.catagoryDict allKeys]];
        NSLog(@"menu: %@",leftAMVC.menu);

        
        [leftAMVC.tableView reloadData];
        
        leftAMVC.url=[dict objectForKey:@"url"];
        
        
        
        /*
        AmazonPagerViewController *amazonPagerViewController = (AmazonPagerViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"amazonPager"];
        
        self.delegate=amazonPagerViewController;
        
        NSNumber *key=  [self.menu objectAtIndex:indexPath.row];
        NSString *value=[leftAMVC.catagoryDict objectForKey:key];
        //[self.delegate didSelectedMenuItemWithTitle:value andCategoryId:key andUrl:self.url];
        
        [self.delegate didSelectedMenuItemWithTitle:value andCategoryId:key andUrl:self.url]; */
            
    }
    
    
   // UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self.slidingViewController
     anchorTopViewOffScreenTo:ECLeft
     animations:nil
     onComplete:^{
         CGRect frame = self.slidingViewController.topViewController.view.frame;
         self.slidingViewController.topViewController = appDelegate.amazonPagerViewController;
         self.slidingViewController.topViewController.view.frame = frame;
         [self.slidingViewController resetTopView];
         
         
         
     }];
    
   // self.delegate=appDelegate.amazonPagerViewController;

    
//    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
//        CGRect frame = self.slidingViewController.topViewController.view.frame;
//        self.slidingViewController.topViewController = appDelegate.amazonPagerViewController;
//        self.slidingViewController.topViewController.view.frame = frame;
//        [self.slidingViewController resetTopView];
    
        
        
//        NSNumber *key=  [self.menu objectAtIndex:indexPath.row];
//        NSString *value=[catagoryDict objectForKey:key];
//        [self.delegate didSelectedMenuItemWithTitle:value andCategoryId:key];
        
        
        
        
   // }];
    
}



- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section==0) return @"                                         Countries";
    else return nil;
}

@end
