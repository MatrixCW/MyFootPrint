//
//  MFPDisplayAllImageCell.h
//  MyFootPrint
//
//  Created by Angel on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFPDisplayAllImageCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *checkView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property BOOL cellSelected;
@property int imageOrientation; //0 portrait, 1 landscape
@end
