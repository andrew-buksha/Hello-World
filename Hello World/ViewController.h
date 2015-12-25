//
//  ViewController.h
//  Hello World
//
//  Created by Andrey Buksha on 21.12.15.
//  Copyright © 2015 Andrey Buksha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MaterialTextField.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (weak, nonatomic) IBOutlet MaterialTextField *searchTxtField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)searchBtnPressed:(id)sender;


@end

