//
//  FullScreenVC.h
//  Hello World
//
//  Created by Andrey Buksha on 25.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Photos;

@interface FullScreenVC : UIViewController <UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) NSString *imgLink;
- (IBAction)saveBtnPressed:(id)sender;

@end
