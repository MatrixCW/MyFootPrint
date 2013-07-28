//
//  MFPFriendListViewController.m
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-28.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import "MFPFriendListViewController.h"
#import "MFPFriendListTableCell.h"
#import "AFJSONRequestOperation.h"
#import "dataUtil.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "MFPFriendFootPrintViewController.h"
@interface MFPFriendListViewController ()

@property NSMutableArray *friends;

@end

@implementation MFPFriendListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(searchProgressively)
     name:UITextFieldTextDidChangeNotification
     object:self.searchField];
    self.names = [NSMutableArray array];
    self.thumbs = [NSMutableArray array];
    self.footprint = [NSMutableArray array];
    [self queryFriend];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
}

-(void)searchProgressivelyzz{
    
}

- (void)queryFriend{
    //NSString *thumbnail = [[dataUtil sharedInstance] thumbnail];
    NSURL *url = [NSURL URLWithString:[[NSString stringWithFormat:@"http://www.friendoc.com.cn:3000/api/friendDetails/%@.json", [[dataUtil sharedInstance] uid]]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"friend list 11111   %@",url);
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[NSURLRequest requestWithURL:url] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"%@kkkkkk",JSON);
        for(NSDictionary *result in JSON){
            //for(NSDictionary *dic in result){
                NSLog(@"%@",[result objectForKey:@"thumbnail"]);
              [self.names addObject: [result objectForKey:@"name"]];
              [self.thumbs addObject: [result objectForKey:@"thumbnail"]];
              //[self.footprint addObject:[dic objectForKey:@"footprint"]];
            //}
        }
        [self.footprint addObject:[NSArray arrayWithObjects:@"3",@"30",@"20", nil]];
        [self.footprint addObject:[NSArray arrayWithObjects:@"8",@"10",@"15", nil]];
        [self.myTableView reloadData];
        //[[dataUtil sharedInstance] setUid:[JSON objectForKey:@"id"]];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Error: %@", error);
    }];
    [operation start];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    
    
    return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"FriendListIdentifier";
    MFPFriendListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        cell = [[MFPFriendListTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if(self.names.count > 0){
        [cell.avatar setImageWithURL:[NSURL URLWithString:[self.thumbs objectAtIndex:indexPath.row]]];
        cell.name.text = [self.names objectAtIndex:indexPath.row];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.currentIndex = indexPath.row;
    [self performSegueWithIdentifier:@"SEGUE_TO_FRIEND_FP" sender:self];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"SEGUE_TO_FRIEND_FP"]){
        MFPFriendFootPrintViewController *vc = segue.destinationViewController;
        vc.footprint = [self.footprint objectAtIndex:self.currentIndex];
        NSString *name = [self.names objectAtIndex:0];
        NSString *label = [NSString stringWithFormat:@"%@的足迹",name];
        vc.label = label;
    }
}
- (IBAction)addButtonPressed:(id)sender {
}
@end
