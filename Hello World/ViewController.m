//
//  ViewController.m
//  Hello World
//
//  Created by Andrey Buksha on 21.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "SearchResult.h"
#import "Constants.h"
#import "SearchManager.h"
#import "FullScreenVC.h"
#import "UIImageView+AFNetworking.h"
#import "AppDelegate.h"
#import "SearchResultOffline.h"

@interface ViewController ()
@property(strong) SearchResult *searchResult;
@end

@implementation ViewController


NSMutableArray *offlineResults;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self connected];
}

-(void)viewDidAppear:(BOOL)animated {
    [self fetchAndSetResults];
}

-(void)fetchAndSetResults {
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"SearchResultOffline"];
    
    NSError *error;
    
    offlineResults = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CustomCell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    SearchResult *searchResult = (self.searchResults)[indexPath.row];
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSError *error;
    
    if (![[offlineResults valueForKey:@"imageLink"] containsObject:searchResult.imgLink]) {
        SearchResultOffline *searchResultOffline = [NSEntityDescription insertNewObjectForEntityForName:@"SearchResultOffline" inManagedObjectContext:context];
        searchResultOffline.imgTitle = searchResult.imageName;
        searchResultOffline.imageLink = searchResult.imgLink;
        [searchResultOffline setSerachResultImage:UIImageJPEGRepresentation(cell.searchResultImage.image, 1.0)];
        if (![context save:&error]) {
            NSLog(@"Could not save: %@", error);
        }
        
        [self fetchAndSetResults];
    }
    
    [cell configureCellWithSearchResult:searchResult];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self performSegueWithIdentifier:@"goToFullscreen" sender:nil];
    FullScreenVC *controller = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([FullScreenVC class])];
    SearchResult *searchResult = (self.searchResults)[indexPath.row];
    
    controller.imgLink = searchResult.imgLink;
    
    [self.navigationController pushViewController:controller animated:YES];
}

//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier  isEqual: @"goToFullscreen"]) {
//        FullScreenVC *fullscreenVC = segue.destinationViewController;
//        if (fullscreenVC) {
//            
//        }
//    }
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

-(BOOL)connected {
    __block BOOL reachable;
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"No internet connection");
                reachable = NO;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi");
                reachable = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"Mobile network");
                reachable = YES;
                break;
            default:
                NSLog(@"Unknown network status");
                reachable = NO;
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return reachable;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 250) animated:true];
    self.tableViewTopConstraint.constant = 250;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
    self.tableViewTopConstraint.constant = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)searchBtnPressed:(id)sender {
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [app managedObjectContext];
    NSError *error;
    
    if (offlineResults.count > 0) {
        for (int x = 0; x < offlineResults.count; x++) {
            NSManagedObject *offlineResult = (NSManagedObject *)[offlineResults objectAtIndex:x];
            
            [context deleteObject:offlineResult];
            
            if (![offlineResult.managedObjectContext save:&error]) {
                NSLog(@"Cannot delete: %@", error.localizedDescription);
            }
        }
    } else {
        NSLog(@"Already empty");
    }
    
    NSString *searchTxt = self.searchTxtField.text;
    
    if (searchTxt  && ![searchTxt  isEqual: @""]) {
        NSString *formattedTxt = [searchTxt stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSString *URLstr = [NSString stringWithFormat:@"%@q=%@%@%@", BASE_URL ,formattedTxt, API_KEY, FORMAT];
        
        SearchManager *searchManager = [[SearchManager alloc] init];
        
        [searchManager getSearchResults:URLstr completionBlock:
         ^(NSDictionary * items) {
             self.searchResults = [[NSMutableArray alloc] init];
             for(NSDictionary* item in items[@"items"]) {
                 SearchResult* currentResult = [[SearchResult alloc]
                                                initWithDictionary:item];
                 [self.searchResults addObject:currentResult];
             }
             [self.tableView reloadData];
         }];
    }
}

@end
