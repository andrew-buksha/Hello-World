//
//  SearchResult.m
//  Hello World
//
//  Created by Andrey Buksha on 24.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

-(instancetype)initWithDictionary: (NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        NSString *imgLink =
        dictionary[@"link"];
        if(imgLink) {
            _imgLink = imgLink;
        }
        
        NSString *imageName =
        dictionary[@"snippet"];
        if(imageName) {
            _imageName = imageName;
        }
    }
    return self;
}
@end
