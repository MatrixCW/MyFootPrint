//
//  MFPQueryGeolocation.h
//  MyFootPrint
//
//  Created by Cui Wei on 13-7-27.
//  Copyright (c) 2013年 Cui Wei. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol QueryGeoInfoFinished

-(void)copyQueryResults:(NSString*)result;

@end


@interface MFPQueryGeolocation : NSObject

-(void)getGeolocation:(CGPoint)coordinates;
@property id<QueryGeoInfoFinished> myDelegate;
@end
