//
//  MFPFriendListViewController.h
//  MyFootPrint
//
//  Created by Angel on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFPFriendListViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *friendListHeader;
- (IBAction)addButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchField;

@end
