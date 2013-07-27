//
//  BDSocialLoginTheme.h
//  BDSocialLoginSDK
//
//  Created by xiawenhai on 13-6-13.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * BDSocialLoginTheme是授权页面的主题类，可以通过它生成属于自己应用风格的主题。
 */

@interface BDSocialLoginTheme : NSObject

@property (nonatomic,readonly)UIImage *headerImage;
@property (nonatomic,readonly)UIColor *headerTitleColor;
@property (nonatomic,readonly)UIImage *goBackImage;

/** @name 构造主题 */
/**
 *	@brief	生成一个主题对象
 */
+(BDSocialLoginTheme *)newTheme;

/** @name 设置主题 */
/**
 *	@brief	设置Header的主题风格
 *
 *	@param 	backgroundImage     header的背景图片
 *	@param 	headerTitleColor    header上标题的文本颜色
 *  @param 	goBackImage         返回Button的图片
 */
-(void)setHeaderThemeWithBackgroundImage:(UIImage *)backgroundImage
                        headerTitleColor:(UIColor *)headerTitleColor
                             goBackImage:(UIImage *)goBackImage;

@end
