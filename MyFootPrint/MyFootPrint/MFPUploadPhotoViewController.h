//
//  MFPUploadPhotoViewController.h
//  MyFootPrint
//
//  Created by Angel on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFPQueryGeolocation.h"

@interface MFPUploadPhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property UIImageView *selectedImage;

@end
