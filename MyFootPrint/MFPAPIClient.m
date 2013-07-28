//
//  MFPAPIClient.m
//  MyFootPrint
//
//  Created by Chen Zeyu on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPAPIClient.h"
#import "AFJSONRequestOperation.h"
#import "MFPConstants.h"
@implementation MFPAPIClient

+ (MFPAPIClient *)sharedClient {
    static MFPAPIClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:MFPBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    NSLog(@"fafafafa url %@",url);
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
	[self setDefaultHeader:@"content-type" value:@"application/json"];
    
    return self;
}


@end
