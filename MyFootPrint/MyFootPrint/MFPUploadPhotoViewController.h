//
//  MFPUploadPhotoViewController.h
//  MyFootPrint
//
//  Created by Angel on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFPQueryGeolocation.h"

@interface MFPUploadPhotoViewController : UIViewController<QueryGeoInfoFinished,UICollectionViewDelegate,UICollectionViewDataSource>

@property UIImageView *selectedImage;
@property int count;
@property int currentProcessingIndex;
@property NSMutableArray *alAssetsArray;
@property NSMutableArray *queriedGeoData;
@property NSMutableDictionary *provincesAndPhotos;
@property (weak, nonatomic) IBOutlet UICollectionView *displayProvinces;

@end
