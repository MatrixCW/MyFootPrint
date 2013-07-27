//
//  MFPrrLoginWebViewController.h
//  MyFootPrint
//
//  Created by Chen Zeyu on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFPLoginViewController.h"

@interface MFPrrLoginWebViewController : UIViewController<UIWebViewDelegate, NSURLConnectionDelegate>

@property id<dismissLoginViewController> myDelegate;
@property (weak, nonatomic) IBOutlet UIWebView *loginView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;

@end
