//
//  MFPFootPrintViewController.h
//  MyFootPrint
//
//  Created by Chen Zeyu on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALRadialMenu.h"
@interface MFPFootPrintViewController : UIViewController<ALRadialMenuDelegate>
@property (weak, nonatomic) IBOutlet UIButton *footPrintButton;
- (IBAction)footPrintButtonPressed:(id)sender;
- (IBAction)shareButtonPressed:(id)sender;
- (IBAction)cameraButtonPressed:(id)sender;
@property (strong, nonatomic) ALRadialMenu *footPrintMenu;
@property (weak, nonatomic) IBOutlet UIImageView *background;
- (void)lightUpMapWithArray:(NSArray *)traveledProvince;
@end
