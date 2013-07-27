//
//  MFPQueryGeolocation.m
//  MyFootPrint
//
//  Created by Angel on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPQueryGeolocation.h"
#import "AFNetworking.h"

@implementation MFPQueryGeolocation

-(void)getGeolocation:(CGPoint)coordinates {
    
    NSString *queryUrl = [NSString stringWithFormat:@"http://api.map.baidu.com/geocoder?location=%f,%f&output=json&key=", coordinates.x,coordinates.y];
    NSURL *url = [NSURL URLWithString:queryUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSString *queryStatus = [JSON objectForKey:@"status"];
                                                        
                                                        if([queryStatus isEqualToString:@"OK"]){
                                                            
                                                            NSDictionary* queryResults = [JSON objectForKey:@"result"];
                                                            NSDictionary* addressComponent = [queryResults objectForKey:@"addressComponent"];
                                                                
                                                            
                                                            NSString *city = [addressComponent objectForKey:@"city"];
                                                            NSString *province = [addressComponent objectForKey:@"province"];
                                                            
                                                            NSString *finalResult = [NSString stringWithFormat:@"%@,%@",province,city];
                                                            
                                                            NSLog(@"%@",finalResult);
                                                            [self.myDelegate copyQueryResults:finalResult];
                                                            
                                                            

                                                            
                                                        }
                                                        else{
                                                            
                                                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"location service failed" message:@"please check your network, or try later" delegate:Nil cancelButtonTitle:@"got it" otherButtonTitles:Nil, nil];
                                                            
                                                            [alert show];
                                                            
                                                            [self.myDelegate copyQueryResults:Nil];
                                                            
                                                        }
                                                        
                        
                                                    }
     
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                                                     message:[NSString stringWithFormat:@"%@",error]
                                                                                                    delegate:nil
                                                                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
                                                        [av show];
                                                        
                                                        [self.myDelegate copyQueryResults:Nil];
                                                    }];
    
    
    [operation start];
}


@end
