//
//  BDSocialLoginMacroDef.h
//  BDSocialLoginSDK
//
//  Created by xiawenhai on 13-6-13.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#ifndef BDSocialLoginSDK_BDSocialLoginMacro_h
#define BDSocialLoginSDK_BDSocialLoginMacro_h

/**
 *	@brief	平台类型
 */
//新浪微博
#define kBD_SOCIAL_LOGIN_PLATFORM_SINAWEIBO         @"sinaweibo"
//QQ空间
#define kBD_SOCIAL_LOGIN_PLATFORM_QQZONE            @"qqdenglu"
//开心网
#define kBD_SOCIAL_LOGIN_PLATFORM_KAIXIN            @"kaixin"
//QQ微博
#define kBD_SOCIAL_LOGIN_PLATFORM_QQWEIBO           @"qqweibo"
//人人网
#define kBD_SOCIAL_LOGIN_PLATFORM_RENREN            @"renren"
//百度账号
#define kBD_SOCIAL_LOGIN_PLATFORM_BAIDU           @"baidu"


/**
 *	@brief	组件错误码定义
 */
//sdk未被初始化
#define BD_SOCIAL_LOGIN_LOCAL_ERRORCODE_UNINITIALIZED            1000
//无网络错误
#define BD_SOCIAL_LOGIN_LOCAL_ERRORCODE_NONETWORK                1001
//无效Token错误
#define BD_SOCIAL_LOGIN_LOCAL_ERRORCODE_INVALID_TOKEN            1002
//参数错误
#define BD_SOCIAL_LOGIN_LOCAL_ERRORCODE_INVALID_PARAM            1003


/**
 *	@brief	授权错误码定义
 */
//未知错误
#define BD_SOCIAL_LOGIN_AUTHORIZE_ERRORCODE_UNKNOWN                     1
//服务暂时不可用
#define BD_SOCIAL_LOGIN_AUTHORIZE_ERRORCODE_SERVICE_UNAVAILABLE         2
//调用次数过于频繁
#define BD_SOCIAL_LOGIN_AUTHORIZE_ERRORCODE_REQUEST_FREQUENTLY          3
//第三方开放平台出错
#define BD_SOCIAL_LOGIN_AUTHORIZE_ERRORCODE_THIRD_PLATFORM              4
//没有权限访问数据
#define BD_SOCIAL_LOGIN_AUTHORIZE_ERRORCODE_NO_PERMISSION               6
//参数缺失错误
#define BD_SOCIAL_LOGIN_AUTHORIZE_ERRORCODE_MISSING_PARAM              100
//登录会话已经过期
#define BD_SOCIAL_LOGIN_AUTHORIZE_ERRORCODE_SESSION_EXPIRE_IN          111

/**
 *	@brief	API错误码定义
 */
//未知错误
#define BD_SOCIAL_LOGIN_API_ERRORCODE_UNKNOWN                     1
//服务暂时不可用
#define BD_SOCIAL_LOGIN_API_ERRORCODE_SERVICE_UNAVAILABLE         2
//第三方开放平台服务不可用
#define BD_SOCIAL_LOGIN_API_ERRORCODE_THIRD_PLATFORM              3
//接口调用次数已经达到上限
#define BD_SOCIAL_LOGIN_API_ERRORCODE_LIMIT_REACHED               4
//请求来自未认证的IP
#define BD_SOCIAL_LOGIN_API_ERRORCODE_UNAUTHORIZED_IP             5
//无权限访问该用户数据
#define BD_SOCIAL_LOGIN_API_ERRORCODE_NO_PERMISSION               6
//请求参数无效
#define BD_SOCIAL_LOGIN_API_ERRORCODE_INVALID_PARAM              100
//API KEY无效
#define BD_SOCIAL_LOGIN_API_ERRORCODE_INVALID_APIKEY             101
//请求参数过多
#define BD_SOCIAL_LOGIN_API_ERRORCODE_PARAM_TOOLONG              102
//无效Token
#define BD_SOCIAL_LOGIN_API_ERRORCODE_INVALID_TOKEN              110
//Token过期
#define BD_SOCIAL_LOGIN_API_ERRORCODE_EXPIRED_TOKEN              111
//社会化账户已经绑定本地账号系统
#define BD_SOCIAL_LOGIN_API_ERRORCODE_SOCIAL_UID_ALREADY_BINDED          210
//社会化账户尚未绑定本地账号系统
#define BD_SOCIAL_LOGIN_API_ERRORCODE_SOCIAL_UID_NOT_BINDED          211

#endif
