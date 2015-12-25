//
//  SearchManager.m
//  Hello World
//
//  Created by Andrey Buksha on 24.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import "SearchManager.h"
#import "Constants.h"
#import "AFNetworking.h"

@implementation SearchManager

-(void)getSearchResults:(NSString *)URLstr completionBlock:
(void (^)(NSDictionary *))completionBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:URLstr parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (responseObject) {
            completionBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * task, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
