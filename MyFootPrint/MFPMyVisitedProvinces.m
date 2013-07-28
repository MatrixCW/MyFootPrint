//
//  MFPMyVisitedProvinces.m
//  MyFootPrint
//
//  Created by Angel on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPMyVisitedProvinces.h"

@implementation MFPMyVisitedProvinces

static NSArray *myArray;

+(void)copyVisitedProvinces:(NSArray*)array{
    if(!myArray)
        myArray = [NSArray arrayWithArray:array];
}

+(NSArray*)returnVisitedProvinces{
    return myArray;
}
@end
