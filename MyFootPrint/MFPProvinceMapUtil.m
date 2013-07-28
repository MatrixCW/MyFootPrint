//
//  MFPProvinceMapUtil.m
//  MyFootPrint
//
//  Created by Chen Zeyu on 13-7-28.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPProvinceMapUtil.h"

@implementation MFPProvinceMapUtil

static NSMutableDictionary *myDict;

+ (NSMutableDictionary *)provinceMap{
    myDict = [[NSMutableDictionary alloc] init];
    [myDict setObject:@"10" forKey:@"甘肃"];
    [myDict setObject:@"11" forKey:@"宁夏"];
    [myDict setObject:@"12" forKey:@"陕西"];
    [myDict setObject:@"13" forKey:@"湖北"];
    [myDict setObject:@"14" forKey:@"湖南"];
    [myDict setObject:@"15" forKey:@"江西"];
    [myDict setObject:@"16" forKey:@"海南"];
    [myDict setObject:@"17" forKey:@"广西"];
    [myDict setObject:@"18" forKey:@"广东"];
    [myDict setObject:@"19" forKey:@"台湾"];
    [myDict setObject:@"1" forKey:@"天津"];
    [myDict setObject:@"2" forKey:@"北京"];
    [myDict setObject:@"20" forKey:@"福建"];
    [myDict setObject:@"21" forKey:@"浙江"];
    [myDict setObject:@"22" forKey:@"江苏"];
    [myDict setObject:@"23" forKey:@"安徽"];
    [myDict setObject:@"24" forKey:@"河南"];
    [myDict setObject:@"25" forKey:@"山东"];
    [myDict setObject:@"26" forKey:@"山西"];
    [myDict setObject:@"27" forKey:@"河北"];
    [myDict setObject:@"28" forKey:@"辽宁"];
    [myDict setObject:@"29" forKey:@"吉林"];
    [myDict setObject:@"30" forKey:@"内蒙古"];
    [myDict setObject:@"31" forKey:@"黑龙江"];
    [myDict setObject:@"3" forKey:@"重庆"];
    [myDict setObject:@"4" forKey:@"西藏"];
    [myDict setObject:@"5" forKey:@"新疆"];
    [myDict setObject:@"6" forKey:@"云南"];
    [myDict setObject:@"7" forKey:@"青海"];
    [myDict setObject:@"8" forKey:@"贵州"];
    [myDict setObject:@"9" forKey:@"四川"];
    [myDict setObject:@"32" forKey:@"澳门"];
    [myDict setObject:@"33" forKey:@"香港"];
    [myDict setObject:@"34" forKey:@"上海"];
    return myDict;
}

@end
