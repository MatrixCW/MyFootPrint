//
//  MFPLoginViewController.m
//  MyFootPrint
//
//  Created by Angel on 13-7-27.
//  Copyright (c) 2013年 Angel. All rights reserved.
//

#import "MFPLoginViewController.h"
#import <BDSocialLogin/BDSocialLoginSDK.h>
#import "MFPQueryGeolocation.h"
@interface MFPLoginViewController ()

@end

@implementation MFPLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.renrenLoginButton addTarget:self action:@selector(renrenLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.sinaWeiboLoginButton addTarget:self action:@selector(weiboLogin) forControlEvents:UIControlEventTouchUpInside];
    
    self.userInfo = [NSMutableDictionary dictionaryWithCapacity:3];
    

    [MFPQueryGeolocation getGeolocation:CGPointMake(30, 104)];

        
}


-(void)getUserInfoWithPlatformType:(NSString *)platformType
{
    [BDSocialLoginSDK getUserInfoWithPlatformType:platformType result:^(BD_SOCIAL_RESULT requestResult, NSString *platformType, id response, NSError *error) {
        if (requestResult == BD_SOCIAL_SUCCESS) {
            NSDictionary *userInfo = (NSDictionary *)response;
            NSEnumerator *enumerator = [userInfo keyEnumerator];
            NSString *key = nil;
            NSMutableString *textStr = [NSMutableString stringWithFormat:@"返回结果:\n"];
            
            while ((key = [enumerator nextObject])) {
                
                [textStr appendFormat:@"%@ = %@\n",key,[userInfo objectForKey:key]];
                
                
                
                if([key isEqualToString:@"mainurl"]){
                    NSString *bigAvatar = [userInfo objectForKey:key];
                    
                    if([self.currentLoginPlatform isEqualToString:kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO])
                        bigAvatar = [bigAvatar stringByReplacingOccurrencesOfString:@"/50/" withString:@"/180/"];
                    
                    [self.userInfo setObject:bigAvatar forKey:@"main_url"];
                    
                }
                
                if([key isEqualToString:@"tinyurl"]){
                    
                    [self.userInfo setObject:[userInfo objectForKey:key] forKey:@"tiny_url"];
                
                }
                
                if([key isEqualToString:@"username"]){
                    
                    [self.userInfo setObject:[userInfo objectForKey:key] forKey:@"user_name"];
                }
                if([key isEqualToString:@"media_uid"]){
                    
                    NSString *prefix;
                    
                    if([self.currentLoginPlatform isEqualToString:kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO])
                        prefix = @"wb";
                    else
                        if([self.currentLoginPlatform isEqualToString:kBD_SOCIAL_LOGIN_PLATFORM_RENREN])
                            prefix = @"rr";
                    
                    NSString *userID = [NSString stringWithFormat:@"%@_%@",prefix,[userInfo objectForKey:key]];
                    
                    [self.userInfo setObject:userID forKey:@"media_uid"];
                }
            }
            
            [self writeToTextFile:self.userInfo];
            [self goToNextStage];
     
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:[NSString stringWithFormat:@"%@获取信息失败\n error code:%d;\n error message:%@",platformType,error.code,[error localizedDescription]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            NSLog(@"%@获取信息失败\n error code:%d;\n error message:%@",platformType,error.code,[error localizedDescription]);
        }
    }];
}


-(void) writeToTextFile:(NSDictionary*)fileToSave{
    
    NSFileManager *myFileManager = [NSFileManager defaultManager] ;
    
    if([myFileManager fileExistsAtPath:USER_INFO_STORING_PATH])
        [myFileManager removeItemAtPath:USER_INFO_STORING_PATH error:Nil];
    
    [fileToSave writeToFile:USER_INFO_STORING_PATH atomically:NO];
}


-(void)authorizeWithPlatformType:(NSString *)platformType
{
    [BDSocialLoginSDK authorizeWithPlatformType:platformType result:^(BD_SOCIAL_RESULT requestResult, NSString *platformType, id response, NSError *error) {
        if (requestResult == BD_SOCIAL_SUCCESS) {
            NSDictionary *authResponse = (NSDictionary *)response;
            NSMutableString *textStr = [NSMutableString stringWithFormat:@"返回结果:\n"];
            NSDictionary *userInfo = [authResponse objectForKey:@"userInfo"];
            [textStr appendFormat:@"%@",[self outputDictionary:userInfo]];
            
            [textStr appendFormat:@"access_token = %@\n",[authResponse objectForKey:@"access_token"]];
            [textStr appendFormat:@"expire_in = %@\n",[authResponse objectForKey:@"expire_in"]];
                    
        } else if (requestResult == BD_SOCIAL_CANCEL) {
            NSLog(@"%@授权取消",platformType);
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"授权失败" message:[NSString stringWithFormat:@"%@授权失败\n error code:%d;\n error message:%@",platformType,error.code,[error localizedDescription]] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            NSLog(@"%@授权失败\n error code:%d;\n error message:%@",platformType,error.code,[error localizedDescription]);
        }
    }];
}



- (NSMutableString *)outputDictionary:(NSDictionary *)dic
{
    
    NSEnumerator *enumerator = [dic keyEnumerator];
    NSString *key = nil;
    NSMutableString *output = [NSMutableString stringWithFormat:@""];
    
    while (key = [enumerator nextObject]) {
        
        
        
        
        
        if ([[dic objectForKey:key] isKindOfClass:[NSDictionary class]]) {
            NSDictionary *subDic = [dic objectForKey:key];
            NSEnumerator *subEnumerator = [subDic keyEnumerator];
            NSString *subKey = nil;
            [output appendFormat:@"%@ = {\n",key];
            while (subKey = [subEnumerator nextObject]) {
                [output appendFormat:@"%@ = %@\n",subKey,[subDic objectForKey:subKey] ];
            }
            [output appendFormat:@"}\n"];
            
            
            continue;
        }
        
        if ([[dic objectForKey:key] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *subDic in [dic objectForKey:key]) {
                NSEnumerator *subEnumerator = [subDic keyEnumerator];
                NSString *subKey = nil;
                [output appendFormat:@"%@ = {\n",key];
                while (subKey = [subEnumerator nextObject]) {
                    [output appendFormat:@"%@ = %@\n",subKey,[subDic objectForKey:subKey] ];
                }
                [output appendFormat:@"}\n"];
            }
            
            
            continue;
        }
        
        [output appendFormat:@"%@ = %@\n",key,[dic objectForKey:key] ];
        
        
        
    }
    
    return output;
}

- (void)renrenLogin {
    
    [self clear];
    
    self.currentLoginPlatform = kBD_SOCIAL_LOGIN_PLATFORM_RENREN;
    
    NSString *platformType = [NSString stringWithFormat:kBD_SOCIAL_LOGIN_PLATFORM_RENREN];
    
    if ([BDSocialLoginSDK isAccessTokenValidWithPlatformType:platformType]) {
        [self getUserInfoWithPlatformType:platformType];
    } else {
        [self authorizeWithPlatformType:platformType];
    }
     

    
}

- (void)weiboLogin {
    
    [self clear];
    
    self.currentLoginPlatform = kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO;
    
    NSString *platformType = [NSString stringWithFormat:kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO];
    
    if ([BDSocialLoginSDK isAccessTokenValidWithPlatformType:platformType]) {
        [self getUserInfoWithPlatformType:platformType];
    } else {
        [self authorizeWithPlatformType:platformType];
    }
     
    
}

-(void)goToNextStage{
    [self performSegueWithIdentifier:SEGUE_FROM_LOGIN_TO_UPLOADING sender:self];
}

-(void)clear{
    
    self.currentLoginPlatform = Nil;
    [self.userInfo removeAllObjects];
}

- (void)deleteAllAuthorizeInfo
{
    [BDSocialLoginSDK clearAllAuthorizeInfo];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
