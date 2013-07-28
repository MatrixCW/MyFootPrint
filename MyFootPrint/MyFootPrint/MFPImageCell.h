//
//  MFPImageCell.h
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-28.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFPImageCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imagePreviewView;

@property (weak, nonatomic) IBOutlet UILabel *nameTag;

@end
