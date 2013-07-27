//
//  BDSocialLoginSDK.h
//  BDSocialLoginSDK
//
//  Created by xiawenhai on 13-6-13.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BDSocialEventHandler.h"
#import "BDSocialLoginMacroDef.h"
#import "BDSocialLoginTheme.h"

/**
 * BDSocialLoginSDK是百度社会化登录组件的主要功能类，提供了第三方平台授权信息管理、获取用户信息及本地账号系统绑定等接口，登录平台包括新浪微博，腾讯微博，QQ空间，人人网，开心网，百度账号等。
 * 另外，BDSocialLoginSDK还提供了UI定制的接口。为了使得登录UI与开发者的应用风格保持一直，开发者可以通过BDSocialLoginTheme方法，对页面进行样式的定制，实现非常简便。
 */

@interface BDSocialLoginSDK : NSObject

/** @name 初始化&销毁 */
/**
 *	@brief	注册应用,此方法在应用启动时调用一次
 *  @discussion 支持的平台标识包括：
 *  kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQZONE
 *  kBD_SOCIAL_LOGIN_PLATFORM_KAIXIN
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_RENREN
 *  kBD_SOCIAL_LOGIN_PLATFORM_BAIDU
 *  平台标识可以参看BDSocialLoginMacroDef.h文件中的定义。
 *
 *	@param 	appKey      应用Key
 *	@param 	platforms   平台类型列表
 */
+ (void)registerApiKey:(NSString *)apiKey andSupportPlatforms:(NSArray *)platforms;

/**
 *	@brief	使用新浪微博客户端的SSO功能，需要调用此方法注册新浪微博的应用ID
 *
 *	@param 	appid      新浪微博应用的id
 */
+ (void)enableSinaWeiboSSOWithAppId:(NSString *)appId;

/**
 *	@brief	使用QQ客户端的SSO功能，需要调用此方法注册QQ的应用ID
 *
 *	@param 	appid      QQ应用的id
 */
+ (void)enableQQSSOWithAppId:(NSString *)appId;

/**
 *	@brief 释放登录组件使用的内存资源
 */
+(void)destroy;

/** @name 授权信息管理 */
/**
 *	@brief	返回授权信息是否有效
 *  @discussion 支持的平台标识包括：
 *  kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQZONE
 *  kBD_SOCIAL_LOGIN_PLATFORM_KAIXIN
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_RENREN
 *  kBD_SOCIAL_LOGIN_PLATFORM_BAIDU
 *  平台标识可以参看BDSocialLoginMacroDef.h文件中的定义。
 *
 *	@param 	platformType   平台类型
 *  @return 如果AccessToken是有效的返回YES,否则返回NO.
 */
+ (BOOL)isAccessTokenValidWithPlatformType:(NSString *)platformType;

/**
 *	@brief	清除单个平台授权信息
 *
 *	@param 	platformType   平台类型
 */
+ (void)clearAuthorizeInfoWithPlatformType:(NSString *)platformType;

/**
 *	@brief	清楚所有账户授权信息
 *
 */
+ (void)clearAllAuthorizeInfo;

/**
 *	@brief	授权并获取用户信息
 *  @discussion 支持的平台标识包括：
 *  kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQZONE
 *  kBD_SOCIAL_LOGIN_PLATFORM_KAIXIN
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_RENREN
 *  kBD_SOCIAL_LOGIN_PLATFORM_BAIDU
 *  平台标识可以参看BDSocialLoginMacroDef.h文件中的定义。
 *
 *	@param 	platformType    平台类型
 *	@param 	result          授权返回事件处理
 */
+ (void)authorizeWithPlatformType:(NSString *)platformType result:(BDSocialEventHandler)result;

/** @name 取得用户信息 */
/**
 *	@brief	获取用户信息
 *  @discussion 支持的平台标识包括：
 *  kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQZONE
 *  kBD_SOCIAL_LOGIN_PLATFORM_KAIXIN
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_RENREN
 *  kBD_SOCIAL_LOGIN_PLATFORM_BAIDU
 *  平台标识可以参看BDSocialLoginMacroDef.h文件中的定义。
 *
 *	@param 	platformType    平台类型
 *	@param 	result          获取用户信息返回事件处理
 */
+ (void)getUserInfoWithPlatformType:(NSString *)platformType result:(BDSocialEventHandler)result;

/** @name 本地账号体系绑定 */
/**
 *	@brief	自有账号与社会化登录用户进行绑定
 *  @discussion 支持的平台标识包括：
 *  kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQZONE
 *  kBD_SOCIAL_LOGIN_PLATFORM_KAIXIN
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_RENREN
 *  kBD_SOCIAL_LOGIN_PLATFORM_BAIDU
 *  平台标识可以参看BDSocialLoginMacroDef.h文件中的定义。
 *
 *	@param 	platformType    平台类型
 *  @param 	userId          自有账号体系的用户ID
 *  @param 	userName        自有账号体系的用户名
 *  @param 	email           自有账号体系中用户保存的email
 *	@param 	result          绑定返回事件处理
 */
+ (void)bindWithPlatformType:(NSString *)platformType
                      userId:(NSString *)userId
                    userName:(NSString *)userName
                       email:(NSString *)email
                      result:(BDSocialEventHandler)result;

/**
 *	@brief	自有账号与社会化登录用户解除绑定
 *  @discussion 支持的平台标识包括：
 *  kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQZONE
 *  kBD_SOCIAL_LOGIN_PLATFORM_KAIXIN
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_RENREN
 *  kBD_SOCIAL_LOGIN_PLATFORM_BAIDU
 *  平台标识可以参看BDSocialLoginMacroDef.h文件中的定义。
 *
 *	@param 	platformType    平台类型
 *	@param 	result          解除绑定返回事件处理
 */
+ (void)unbindWithPlatformType:(NSString*)platformType result:(BDSocialEventHandler)result;

/**
 *	@brief	获取社会化登录用户的绑定信息
 *  @discussion 支持的平台标识包括：
 *  kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQZONE
 *  kBD_SOCIAL_LOGIN_PLATFORM_KAIXIN
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_RENREN
 *  kBD_SOCIAL_LOGIN_PLATFORM_BAIDU
 *  平台标识可以参看BDSocialLoginMacroDef.h文件中的定义。
 *
 *	@param 	platformType    平台类型
 *	@param 	result          获取绑定信息返回事件处理
 */
+ (void)getBindInfoWithPlatformType:(NSString*)platformType result:(BDSocialEventHandler)result;

/**
 *	@brief	获取自有账号绑定的所有社会化登录用户的绑定信息
 *  @discussion 支持的平台标识包括：
 *  kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQZONE
 *  kBD_SOCIAL_LOGIN_PLATFORM_KAIXIN
 *  kBD_SOCIAL_LOGIN_PLATFORM_QQWEIBO
 *  kBD_SOCIAL_LOGIN_PLATFORM_RENREN
 *  kBD_SOCIAL_LOGIN_PLATFORM_BAIDU
 *  平台标识可以参看BDSocialLoginMacroDef.h文件中的定义。
 *
 *	@param 	platformType    平台类型
 *	@param 	result          获取绑定信息返回事件处理
 */
+ (void)getAllBindUserInfoWithPlatformType:(NSString*)platformType userId:(NSString *)userId result:(BDSocialEventHandler)result;

/** @name 授权UI接口 */
/**
 *	@brief	设置授权界面的主题
 *
 *	@param 	theme     主题
 */
+ (void)setSocialLoginTheme:(BDSocialLoginTheme *)theme;


/** @name 第三方客户端回调处理 */
/**
 *	@brief 处理第三方客户端通过URL启动App时传递的数据
 *
 *	@param 	url         启动App的URL
 */
+(BOOL)handleOpenURL:(NSURL *)url;


@end
