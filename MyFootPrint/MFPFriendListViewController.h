//
//  MFPFriendListViewController.h
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-28.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFPFriendListViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property NSMutableArray *thumbs;
@property NSMutableArray *names;
@property NSMutableArray *footprint;
@property int currentIndex;
@property (weak, nonatomic) IBOutlet UILabel *friendListHeader;
- (IBAction)addButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end
