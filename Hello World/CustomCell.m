//
//  CustomCell.m
//  Hello World
//
//  Created by Andrey Buksha on 21.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import "CustomCell.h"
#import "SearchResult.h"

@implementation CustomCell

- (void)awakeFromNib {
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)configureCellWithSearchResult: (SearchResult *) searchResult {
    self.imageNameLbl.text = searchResult.imageName;
}

@end
