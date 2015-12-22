//
//  CustomCell.h
//  Hello World
//
//  Created by Andrey Buksha on 21.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *searchResultImage;
@property (weak, nonatomic) IBOutlet UILabel *imageNameLbl;

@end
