//
//  MFPUploadPhotoViewController.h
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-27.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//


@protocol displayImagesDataSource <NSObject>

-(NSArray*) imagesToDisplay;

@end


#import <UIKit/UIKit.h>
#import "MFPQueryGeolocation.h"
#import "MFPImageCell.h"
#import "MFPDisplayImageViewController.h"
#import "MFPMyVisitedProvinces.h"



@interface MFPUploadPhotoViewController : UIViewController<QueryGeoInfoFinished,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,displayImagesDataSource>

@property UIImageView *selectedImage;
@property int count;
@property int currentProcessingIndex;
@property NSMutableArray *alAssetsArray;
@property NSMutableArray *queriedGeoData;
@property NSMutableDictionary *provincesAndPhotos;
@property (weak, nonatomic) IBOutlet UICollectionView *displayProvinces;
@property NSInteger currentSelectedProvinces;

@end
