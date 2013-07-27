//
//  MFPConstants.h
//  MyFootPrint
//
//  Created by Angel on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_INFO_STORING_PATH \
[NSString stringWithFormat:@"\%@%@", \
[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"/userInfo.txt"]\


@interface MFPConstants : NSObject

@end
