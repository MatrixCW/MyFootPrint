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

@end

@implementation MFPUploadPhotoViewController{
    NSMutableArray *assetGroups;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UIImage *backgroundImage = [UIImage imageNamed:UPLOAD_PHOTO_VC_BG];
    UIImageView *backGroundView = [[UIImageView alloc] initWithImage:backgroundImage];
    self.view = backGroundView;
    
    //[self selectPhoto:Nil];
    assetGroups = [[NSMutableArray alloc] init];
    
    MFPQueryGeolocation *tempQuery  = [[MFPQueryGeolocation alloc] init];
    
    
    void (^assetEnumerator)
    (ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            CLLocation *tempLocation = (CLLocation*)[result valueForProperty:ALAssetPropertyLocation];
            [tempQuery getGeolocation:CGPointMake(tempLocation.coordinate.latitude, tempLocation.coordinate.longitude)];
        }
    };
    
    void (^assetGroupEnumerator)(ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop){
        
        if(group != nil) {
            NSLog(@"hahahahahaha");
            [group enumerateAssetsUsingBlock:assetEnumerator];
        }
    };
    
    
                                         
                                         
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    NSUInteger groupTypes = ALAssetsGroupAll;
                                         
    [library enumerateGroupsWithTypes:groupTypes
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {NSLog(@"A problem occurred");}];
}

- (void)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
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
