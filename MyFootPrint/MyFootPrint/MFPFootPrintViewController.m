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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
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
}

#pragma - radial menu delegate methods
- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)footMenu{
    return 4;
}

- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu {
	return 60;
}

- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu {
	return 180;
}

- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index {
    if (index == 1) {
        return [UIImage imageNamed:@"dribbble"];
    } else if (index == 2) {
        return [UIImage imageNamed:@"email"];
    } else if (index == 3) {
        return [UIImage imageNamed:@"facebook500"];
    } else if (index == 4) {
        return [UIImage imageNamed:@"email"];
    }
	
	return nil;
}

- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index {
    [self.footPrintMenu itemsWillDisapearIntoButton:self.footPrintButton];
    if (index == 1) {
        NSLog(@"email");
    } else if (index == 2) {
        NSLog(@"google+");
    } else if (index == 3) {
        NSLog(@"facebook");
    } else if (index == 4) {
        NSLog(@"facebook");
    }
    
}
@end
