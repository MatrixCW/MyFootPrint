//
//  MFPLoginViewController.h
//  MyFootPrint
//
//  Created by Angel on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFPConstants.h"


@interface MFPLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *renrenLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *sinaWeiboLoginButton;

@property NSString *currentLoginPlatform;

@property NSMutableDictionary *userInfo;

@end
