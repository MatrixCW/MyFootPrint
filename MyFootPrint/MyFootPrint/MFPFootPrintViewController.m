//
//  MFPFootPrintViewController.m
//  MyFootPrint
//
//  Created by Chen Zeyu on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPFootPrintViewController.h"
#import "dataUtil.h"
#import "CacheManager.h"
#import "MFPConstants.h"
#import "AFJSONRequestOperation.h"
#import "MFPAPIClient.h"
#define BLUE_PROVINCE @"%@blue"
#import "TRStringExtensions.h"
#import "MFPMyVisitedProvinces.h"
#import "MFPProvinceMapUtil.h"

#define CREATE_USER_URL @"http://www.friendoc.com.cn:3000/api/rrlogin.json?rrid=%@&name=%@&thumbnail=%@&token=%@"
@interface MFPFootPrintViewController ()

@end

@implementation MFPFootPrintViewController

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
    self.footPrintMenu = [[ALRadialMenu alloc] init];
    self.footPrintMenu.delegate = self;
    
    NSArray *visitedprovinces = [MFPMyVisitedProvinces returnVisitedProvinces];
    
    if(visitedprovinces){
        NSMutableArray *provincesCode = [NSMutableArray array];
        NSDictionary *dict = [MFPProvinceMapUtil provinceMap];

        for(NSString * str in visitedprovinces){
            
            NSLog(@"%@",str);
            NSString *code = [dict objectForKey:str];
            [provincesCode addObject:code];
            
            [self lightUpMapWithArray:provincesCode];
            
        }
    }
    
    
        
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    NSString *rrid = [[dataUtil sharedInstance] rrid];
    NSString *name = [[dataUtil sharedInstance] name];
    NSString *token = [[dataUtil sharedInstance] token];
    NSString *thumbnail = [[dataUtil sharedInstance] thumbnail];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:CREATE_USER_URL,rrid,name,thumbnail,token] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",url);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:url] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@kkkkkk",JSON);
        [[dataUtil sharedInstance] setUid:[JSON objectForKey:@"id"]];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }];
    if(![[dataUtil sharedInstance] uid])
        [operation start];
    if (![[dataUtil sharedInstance] isLoggedIn]){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        NSLog(@"logged in!");
        UINavigationController* navVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
        [self presentViewController:navVC animated:YES completion:^{
        }];
    }
}

- (IBAction)footPrintButtonPressed:(id)sender {
    [self.footPrintMenu buttonsWillAnimateFromButton:sender withFrame:self.footPrintButton.frame inView:self.view];
    UIButton *button = (UIButton *)sender;
    button.userInteractionEnabled = YES;
}

- (IBAction)shareButtonPressed:(id)sender {
    if(self.footPrintMenu.buttonsAreShown)
        [self.footPrintMenu itemsWillDisapearIntoButton:self.footPrintButton];
}

- (IBAction)cameraButtonPressed:(id)sender {
    if(self.footPrintMenu.buttonsAreShown)
        [self.footPrintMenu itemsWillDisapearIntoButton:self.footPrintButton];
}

#pragma - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)footMenu{
    return 4;
}

- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu {
	return FOOT_PRINT_BUTTON_RADIUS;
}

- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu {
	return 180;
}

- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index {
    if (index == 1) {
        return [UIImage imageNamed:@"setting"];
    } else if (index == 2) {
        return [UIImage imageNamed:@"postcardcase"];
    } else if (index == 3) {
        return [UIImage imageNamed:@"postcard"];
    } else if (index == 4) {
        return [UIImage imageNamed:@"friends"];
    }
	
	return nil;
}

- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
    [self.footPrintMenu itemsWillDisapearIntoButton:self.footPrintButton];
    if (index == 1) {
        NSLog(@"logout");
        [[dataUtil sharedInstance] logout];
        [self viewDidAppear:YES];
        
    } else if (index == 2) {
        [self performSegueWithIdentifier:@"SEGUE_TO_CARD_VC" sender:self];
        NSLog(@"google+");
    } else if (index == 3) {
        NSLog(@"facebook");
        [self performSegueWithIdentifier:@"SEGUE_TO_EDIT_CARD_VC" sender:self];
        
    } else if (index == 4) {
        [self performSegueWithIdentifier:@"SEGUE_TO_FRIEND_LIST_VC" sender:self];
        NSLog(@"facebook");
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    if ([touch view].tag == 0 && self.footPrintMenu.buttonsAreShown) {

        [self.footPrintMenu itemsWillDisapearIntoButton:self.footPrintButton];
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)lightUpMapWithArray:(NSArray *)traveledProvince{
    for(NSString *s in traveledProvince){
        UIImage *province = [UIImage imageNamed:[NSString stringWithFormat:BLUE_PROVINCE,s]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:province];
        imgView.frame = CGRectMake(0, 0, 320, 480);
        
        //imgView.frame = self.background.frame;
        //NSLog(@"width%f, height%f",imgView.frame.origin.x,imgView.frame.origin.y);
        //NSLog(@"widtfafah%f, height%f",self.background.frame.size.width,self.background.frame.origin.y);
        
        [self.view addSubview:imgView];
    }
}

- (void)checkUID{
    NSString *rrid = [[dataUtil sharedInstance] rrid];
    NSString *name = [[dataUtil sharedInstance] name];
    NSString *token = [[dataUtil sharedInstance] token];
    NSString *thumbnail = [[dataUtil sharedInstance] thumbnail];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:CREATE_USER_URL,rrid,name,thumbnail,token]];
    [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:url] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@",JSON);
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }];
    
}
@end
