//
//  MFPCardViewController.m
//  MyFootPrint
//
//  Created by Chen Zeyu on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPCardViewController.h"

@interface MFPCardViewController (){
    NSArray *items;
}

@end

@implementation MFPCardViewController

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
    self.cardView.delegate = self;
    self.cardView.dataSource = self;
    items = [NSArray arrayWithObjects:@"1",@"2",@"3",@"4", nil];
    self.cardView.type = iCarouselTypeRotary;
    [self.cardView reloadData];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark iCarousel methods

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    NSLog(@"number of %d", items.count);
    return [items count];
    
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:self.cardView.bounds];
        UIImage *image = [UIImage imageNamed:@"addthis500.png"];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
        imgView.frame = view.bounds;
        [view addSubview:imgView];
        view.contentMode = UIViewContentModeCenter;
        view.frame = self.cardView.bounds;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [items objectAtIndex:index];
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1f;
    }
    return value;
}

#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = [items objectAtIndex:index];
    NSLog(@"Tapped view number: %@", item);
}

@end
