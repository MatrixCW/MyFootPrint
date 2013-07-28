//
//  MFPDisplayImageViewController.m
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-28.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import "MFPDisplayImageViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "MFPAPIClient.h"
#import "MFPConstants.h"
#import "dataUtil.h"
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

       return CGSizeMake(160, 240);

    else
        return CGSizeMake(240, 160);
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

- (void)uploadImageWithLat:(double)lat lng:(double)lng img:(UIImage *)img province:(NSInteger)province andCity:(NSInteger)city{
    
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
    [mutableParameters setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    [mutableParameters setObject:[[dataUtil sharedInstance] uid] forKey:@"uid"];
    [mutableParameters setObject:[NSNumber numberWithDouble:lng] forKey:@"lng"];
    [mutableParameters setObject:[NSNumber numberWithDouble:city] forKey:@"city"];
    [mutableParameters setObject:[NSNumber numberWithDouble:province] forKey:@"province"];
    
    NSMutableURLRequest *mutableURLRequest = [[MFPAPIClient sharedClient] multipartFormRequestWithMethod:@"POST" path:@"http://www.friendoc.com.cn:3000/api/photos" parameters:mutableParameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(img, 0.6) name:@"img" fileName:@"image.jpg" mimeType:@"image/jpeg"];
    }];
    
    AFHTTPRequestOperation *operation = [[MFPAPIClient sharedClient] HTTPRequestOperationWithRequest:mutableURLRequest success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSLog(@"!!!yeayeayeayeayeyea");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@", [error description]);
    }
                                         ];
    [[MFPAPIClient sharedClient] enqueueHTTPRequestOperation:operation];
    
}
- (IBAction)addButtonPressed:(id)sender {
    UIImage *img = [UIImage imageNamed:@"facebook500"];
    [self uploadImageWithLat:30 lng:104 img:img province:4 andCity:4];

}


@end
