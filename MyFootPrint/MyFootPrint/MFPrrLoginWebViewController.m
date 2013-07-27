//
//  MFPrrLoginWebViewController.m
//  MyFootPrint
//
//  Created by Chen Zeyu on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPrrLoginWebViewController.h"
#import "AFJSONRequestOperation.h"
#import "dataUtil.h"
#import "CacheManager.h"
@interface MFPrrLoginWebViewController ()

@end

@implementation MFPrrLoginWebViewController

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
    self.loginView.delegate = self;
    [self.loginView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    NSString *redirectUrlString = @"http://home.friendoc.net/footprint/v1.0/";
    //NSString *authFormatString = @"https://ivle.nus.edu.sg/api/login/?apikey=%@";
    
    NSLog(@"%@", redirectUrlString);
    //NSString *urlString = [NSString stringWithFormat:authFormatString, apikey, redirectUrlString];
    NSURL *url = [NSURL URLWithString:redirectUrlString];
    
    [self.loginView loadRequest:[NSURLRequest requestWithURL:url]];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	NSLog(@"Start Request");
    self.indicator.hidden = NO;
    [self.indicator startAnimating];
    NSString *urlString = request.URL.absoluteString;
	
    [self checkForAccessToken:urlString];
    
    return TRUE;
}

-(void)checkForAccessToken:(NSString *)urlString {
    
    if ([urlString rangeOfString:@"success=1"].location != NSNotFound) {
        NSURL *responseURL = [NSURL URLWithString:urlString];
        NSLog(@"URL:%@",responseURL);
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        AFJSONRequestOperation *operation =
        [AFJSONRequestOperation JSONRequestOperationWithRequest:request
         
                                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                            [self dismissViewControllerAnimated:YES completion:nil];
                                                            
                                                            NSLog(@"Token %@", [JSON objectForKey:@"token"]);
                                                            NSLog(@"uid %@", [JSON objectForKey:@"uid"]);
                                                            [[dataUtil sharedInstance] setToken:[JSON objectForKey:@"token"]];
                                                            [[dataUtil sharedInstance] setUid:[JSON objectForKey:@"uid"]];
                                                        }
         
                                                        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                         message:[NSString stringWithFormat:@"%@",error]
                                                                                                        delegate:nil
                                                                                               cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                            [av show];
                                                        }];
        
        
        [operation start];
        
    }
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"finished lodding");
    [self.indicator stopAnimating];
    self.indicator.hidden = YES;
 }

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"receivedData");
    
    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSMutableString *muid = [NSMutableString stringWithString:newStr];
    [muid replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [muid length])];
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog(@"Connection failed: %@", [error description]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    
    // convert to JSON
    
}


@end
