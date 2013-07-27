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

+ (void)getGeolocation:(CGPoint)coordinates {
    
    NSString *queryUrl = [NSString stringWithFormat:@"http://api.map.baidu.com/geocoder?location=%f,%f&output=json&key=", coordinates.x,coordinates.y];
    NSURL *url = [NSURL URLWithString:queryUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        NSString *parsed = [JSON objectForKey:@"status"];
                                                        for(NSDictionary* dict in parsedResults){
                                                            
                                                        }
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


@end
