//
//  SearchResultOffline+CoreDataProperties.h
//  Hello World
//
//  Created by Андрей Букша on 30.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SearchResultOffline.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultOffline (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *imgTitle;
@property (nullable, nonatomic, retain) NSData *serachResultImage;
@property (nullable, nonatomic, retain) NSString *imageLink;

@end

NS_ASSUME_NONNULL_END
