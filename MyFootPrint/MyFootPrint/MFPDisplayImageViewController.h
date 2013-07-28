//
//  MFPDisplayImageViewController.h
//  MyFootPrint
//
//  Created by Angel on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFPUploadPhotoViewController.h"
#import "MFPDisplayAllImageCell.h"

@interface MFPDisplayImageViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)addButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *imageDisplayArea;

@property id<displayImagesDataSource> myDelegate;

@end
