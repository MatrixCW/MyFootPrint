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

#define UPLOAD_PHOTO_VC_BG @"upload_bg.png"
#define FOOT_PRINT_BUTTON_SIZE 55
#define FOOT_PRINT_BUTTON_RADIUS 70
#define MFPBaseURLString @"www.friendoc.com.cn:3000/api"
@interface MFPConstants : NSObject

@end
