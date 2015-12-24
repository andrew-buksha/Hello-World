//
//  SearchResult.h
//  Hello World
//
//  Created by Andrey Buksha on 24.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject

@property (nonatomic,strong) NSString *imgLink;
@property (nonatomic,strong) NSString *imageName;

-(instancetype)initWithDictionary:
(NSDictionary *)dictionary;

@end
