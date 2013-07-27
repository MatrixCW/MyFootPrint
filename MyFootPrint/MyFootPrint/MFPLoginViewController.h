//
//  MFPLoginViewController.h
//  MyFootPrint
//
//  Created by Angel on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFPConstants.h"


@protocol dismissLoginViewController <NSObject>

-(void)dismissModalLoginViewController;

@end

@interface MFPLoginViewController : UIViewController<UIWebViewDelegate,dismissLoginViewController>

@property (weak, nonatomic) IBOutlet UIButton *renrenLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *sinaWeiboLoginButton;

@property UIWebView *rrLogin;
@property NSString *currentLoginPlatform;

@property NSMutableDictionary *userInfo;

@end
