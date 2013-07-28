//
//  MFPFriendFootPrintViewController.h
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-28.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFPFriendFootPrintViewController : UIViewController
@property NSArray *footprint;
@property NSString *label;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)backButtonPressed:(id)sender;

@end
