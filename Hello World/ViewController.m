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

@interface ViewController ()
@property(strong) SearchResult *searchResult;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *URL = [NSURL URLWithString:@"https://www.googleapis.com/customsearch/v1?q=cats&key=AIzaSyByc6VWmFBcRFlm8xEz8dqTCqkU9ZboNH4&cx=014527755851884370933:ycblgxqutq4&searchType=image"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URL.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dictArr = responseObject;
        
        self.searchResults = [[NSMutableArray alloc] init];
        
        for(NSDictionary* item in dictArr[@"items"]) {
            SearchResult* currentResult = [[SearchResult alloc]
            initWithDictionary:item];
            [self.searchResults addObject:currentResult];
            [self.tableView reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        NSLog(@"Error: %@", error);
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
    
    cell.imageNameLbl.text = searchResult.imageName;
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
