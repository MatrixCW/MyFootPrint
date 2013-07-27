//
//  MFPDisplayImageViewController.m
//  MyFootPrint
//
//  Created by Angel on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPDisplayImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface MFPDisplayImageViewController ()

@property NSMutableArray *imageArray;

@end

@implementation MFPDisplayImageViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.imageArray = [NSMutableArray array];
    
    for(ALAsset *asset in [self.myDelegate imagesToDisplay]){
        UIImage *img = [self imageForAsset:asset];
        [self.imageArray addObject:img];
    }
    self.imageDisplayArea.dataSource = self;
    self.imageDisplayArea.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.imageArray.count;
    
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MFPDisplayAllImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectImageCell" forIndexPath:indexPath];
        
    cell.imageView.image = [self.imageArray objectAtIndex:indexPath.row];
    
    NSLog(@"here image ratio %f",cell.imageView.image.size.width/cell.imageView.image.size.height);
    
    cell.selected = NO;
    
    cell.checkView.hidden = YES;
    
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
    MFPDisplayAllImageCell *cell = (MFPDisplayAllImageCell*)[collectionView cellForItemAtIndexPath:indexPath];
    
    if(cell.cellSelected){
        
        cell.cellSelected = NO;
        cell.checkView.hidden = YES;
        
    }
    else{
        
        cell.cellSelected = YES;
        cell.checkView.hidden = NO;
        
    }
}



#pragma mark – UICollectionViewDelegateFlowLayout

// 1
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    UIImage *toDisplay = [self.imageArray objectAtIndex:indexPath.row];
    
    
    if(toDisplay.size.width/toDisplay.size.height < 1)
       return CGSizeMake(200, 300);
    else
        return CGSizeMake(300, 200);
}

/*
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    if([collectionView numberOfItemsInSection:section == 1])
        return UIEdgeInsetsMake(30, 30, 20, 30);
    else
        return UIEdgeInsetsMake(30, 10, 20, 30);
}
 */

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5; // This is the minimum inter item spacing, can be more
}

- (IBAction)backButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (IBAction)addButtonPressed:(id)sender {
}
@end
