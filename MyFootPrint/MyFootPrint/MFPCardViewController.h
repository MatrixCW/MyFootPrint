//
//  MFPCardViewController.h
//  MyFootPrint
//
//  Created by Chen Zeyu on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
@interface MFPCardViewController : UIViewController<iCarouselDataSource, iCarouselDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *cardView;

@end
