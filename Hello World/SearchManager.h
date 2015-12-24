//
//  SearchManager.h
//  Hello World
//
//  Created by Andrey Buksha on 24.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchManager : NSObject

-(void)getSearchResults:(NSString *)URLstr completionBlock:
(void (^)(NSDictionary *))completionBlock;

@end
