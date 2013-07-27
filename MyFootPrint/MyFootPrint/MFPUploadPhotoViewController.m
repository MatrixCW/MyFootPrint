//
//  MFPUploadPhotoViewController.m
//  MyFootPrint
//
//  Created by Angel on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPUploadPhotoViewController.h"
#import "MFPConstants.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CLLocation.h>

@interface MFPUploadPhotoViewController ()

@property ALAssetsLibrary* myLibrary;

@end

@implementation MFPUploadPhotoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //UIImage *backgroundImage = [UIImage imageNamed:UPLOAD_PHOTO_VC_BG];
    //UIImageView *backGroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    //self.view = backGroundView;
    
    //[self selectPhoto:Nil];
    self.alAssetsArray = [[NSMutableArray alloc] init];
    self.queriedGeoData = [[NSMutableArray alloc] init];
    self.provincesAndPhotos = [[NSMutableDictionary alloc] initWithCapacity:34];
    self.count = 0;
    self.currentProcessingIndex = 0;
    [self.displayProvinces registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    void (^assetEnumerator)
    (ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            
            if([result valueForProperty:ALAssetTypePhoto] && [result valueForProperty:ALAssetPropertyLocation] != Nil){
                self.count++;
                NSLog(@"%i",self.count);
                [self.alAssetsArray addObject:result];
                
            }
            
        }
    };
    
    void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop){
        
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
        }
        else{
            
            [self getPhotoGeoData];
        }
    };
    
    
                                         
                                         
    self.myLibrary = [[ALAssetsLibrary alloc] init];
    NSUInteger groupTypes = ALAssetsGroupAll;
                                         
    [self.myLibrary enumerateGroupsWithTypes:groupTypes
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {NSLog(@"A problem occurred");}];
    
}

-(void)getPhotoGeoData{
    
    if(self.currentProcessingIndex >= self.alAssetsArray.count){
        [self loadImages];
        return;
    }
    
    MFPQueryGeolocation *geoInfoQuerier = [[MFPQueryGeolocation alloc] init];
    geoInfoQuerier.myDelegate = self;
    ALAsset *currentProcessingAsset = [self.alAssetsArray objectAtIndex:self.currentProcessingIndex];
    CLLocation *tempLocation = (CLLocation*)[currentProcessingAsset valueForProperty:ALAssetPropertyLocation];
    [geoInfoQuerier getGeolocation:CGPointMake(tempLocation.coordinate.latitude, tempLocation.coordinate.longitude)];
    
    
}

-(void)loadImages{
    
    assert(self.alAssetsArray.count == self.queriedGeoData.count);
    
    for(int i = 0; i < self.alAssetsArray.count;i++){
        NSString *province = [self.queriedGeoData objectAtIndex:i];
        
        if([self.provincesAndPhotos objectForKey:province] == Nil){
            NSMutableArray *array = [NSMutableArray array];
            [array addObject:[self.alAssetsArray objectAtIndex:i]];
            [self.provincesAndPhotos setObject:array forKey:province];
        }
        else{
            NSMutableArray *array = [self.provincesAndPhotos objectForKey:province];
            [array addObject:[self.alAssetsArray objectAtIndex:i]];
        }
    }
    
    NSLog(@"%@",self.alAssetsArray);
    [self showProvincesInTableView];
}


-(void)showProvincesInTableView{
    
    self.displayProvinces.delegate = self;
    self.displayProvinces.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    
    return cell;
    
}

/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(80, 80);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(30, 30, 30, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5; // This is the minimum inter item spacing, can be more
}

//-(CGSize)col
-(void)copyQueryResults:(NSString*)result{
    
    if(result == Nil){
        [self.alAssetsArray removeObjectAtIndex:self.currentProcessingIndex];
        
    }
    else{
        self.currentProcessingIndex ++;
        [self.queriedGeoData addObject:result];
        
    }
    [self getPhotoGeoData];
}


-(void)getChinaProvinces{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.selectedImage.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
