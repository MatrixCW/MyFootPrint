//
//  MFPFriendListTableCell.h
//  MyFootPrint
//
//  Created by Angel on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFPFriendListTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *recentActivity;
@property (weak, nonatomic) IBOutlet UILabel *newestActivity;

@end
