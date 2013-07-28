//
//  MFPUploadPhotoViewController.m
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-27.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import "MFPUploadPhotoViewController.h"
#import "MFPConstants.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CLLocation.h>
#import <QuartzCore/QuartzCore.h>

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
    
    return self.provincesAndPhotos.count;
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MFPImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DisplayImageCell" forIndexPath:indexPath];
    NSArray *keys = [self.provincesAndPhotos allKeys];
    NSString *provinceName = [keys objectAtIndex:indexPath.row];
    
    ALAsset *displayAsset = [(NSMutableArray*)[self.provincesAndPhotos objectForKey:provinceName] objectAtIndex:0];
    UIImage *image = [self imageForAsset:displayAsset];
    
    cell.imagePreviewView.image = image;
    
    cell.nameTag.text = [self removeRedudentStrin:provinceName];
    
    return cell;
}

-(UIImage*) imageForAsset:(ALAsset*) aAsset{
	
	ALAssetRepresentation *rep;
	
	rep = [aAsset defaultRepresentation];
    
	return [UIImage imageWithCGImage:[rep fullResolutionImage]];
}

/*- (UICollectionReusableView *)collectionView:
 (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
 {
 return [[UICollectionReusableView alloc] init];
 }*/

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"haha");
    self.currentSelectedProvinces = indexPath.row;
    NSLog(@"%i",indexPath.row);
    [self performSegueWithIdentifier:@"SEGUE_TO_SHOW_PHOTOS" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([segue.identifier isEqualToString:@"SEGUE_TO_SHOW_PHOTOS"])
        if([segue.destinationViewController isKindOfClass:[MFPDisplayImageViewController class]]){
            MFPDisplayImageViewController* segueVC = (MFPDisplayImageViewController*)segue.destinationViewController;
            segueVC.myDelegate = self;
            
        }
}


#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(100, 100);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if([collectionView numberOfItemsInSection:section == 1])
       return UIEdgeInsetsMake(30, 30, 20, 30);
    else
       return UIEdgeInsetsMake(30, 10, 20, 30);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5; // This is the minimum inter item spacing, can be more
}

- (void)addShadowToView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.shadowColor = [UIColor blackColor].CGColor;
    view.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    view.layer.shadowOpacity = 0.5f;
}

-(NSString *)removeRedudentStrin:(NSString*)str{
    
    NSString *temp = [[str componentsSeparatedByString:@","] objectAtIndex:0];
    
    if(temp)
        str = temp;
    
    str = [str stringByReplacingOccurrencesOfString:@"自治区" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"特别行政区" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"省" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"壮族" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"回族" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"维吾尔族" withString:@""];
    
    return str;
    
    
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


-(NSArray*) imagesToDisplay{
    
    NSArray* keys = [self.provincesAndPhotos allKeys];
    NSString *key = [keys objectAtIndex:self.currentSelectedProvinces];
    
    return [NSArray arrayWithArray:[self.provincesAndPhotos objectForKey:key]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
