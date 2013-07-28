//
//  MFPEditCardViewController.h
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-28.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
@interface MFPEditCardViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *userInputField;
- (IBAction)pickCameraRollButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imagePreview;

@property UIImage *selectedImage;
@end
