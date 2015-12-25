//
//  ViewController.m
//  Hello World
//
//  Created by Andrey Buksha on 21.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "AFNetworking.h"
#import "SearchResult.h"
#import "Constants.h"
#import "SearchManager.h"

@interface ViewController ()
@property(strong) SearchResult *searchResult;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    [cell configureCellWithSearchResult:searchResult];
    return cell;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return true;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 215) animated:true];
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)searchBtnPressed:(id)sender {
    
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
