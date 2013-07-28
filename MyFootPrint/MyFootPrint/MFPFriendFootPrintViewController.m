//
//  MFPFriendFootPrintViewController.m
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-28.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import "MFPFriendFootPrintViewController.h"
#import "MFPConstants.h"
#define BLUE_PROVINCE @"%@blue"
@interface MFPFriendFootPrintViewController ()

@end

@implementation MFPFriendFootPrintViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = self.label;
    [self lightUpMapWithArray:self.footprint];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonPressed:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)lightUpMapWithArray:(NSArray *)traveledProvince{
    for(NSString *s in traveledProvince){
        UIImage *province = [UIImage imageNamed:[NSString stringWithFormat:BLUE_PROVINCE,s]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:province];
        imgView.frame = self.view.bounds;
        
        //imgView.frame = self.background.frame;
        //NSLog(@"width%f, height%f",imgView.frame.origin.x,imgView.frame.origin.y);
        //NSLog(@"widtfafah%f, height%f",self.background.frame.size.width,self.background.frame.origin.y);
        
        [self.view addSubview:imgView];
    }
}

@end
