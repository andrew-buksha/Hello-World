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
    
    NSString *URLstr = [NSString stringWithFormat:@"%@q=cats%@%@", BASE_URL, API_KEY, FORMAT];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager GET:URLstr parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSDictionary *dictArr = responseObject;
//        
//

//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask * task, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
