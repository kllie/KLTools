//
//  UIImage+KLExtend.h
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (KLExtend)

#pragma mark - 图片加密转码 (base64)

/**
 图片加密转码

 @param compressionQuality compression is 0(most)..1(least), options is "NSDataBase64Encoding64CharacterLineLength"
 @return NSString value
 */
- (NSString *)base64String:(CGFloat)compressionQuality;

/**
 图片加密转码

 @param compressionQuality compression is 0(most)..1(least)
 @param options Base 64 Options
 @return NSString value
 */
- (NSString *)base64String:(CGFloat)compressionQuality options:(NSDataBase64EncodingOptions)options;

@end
