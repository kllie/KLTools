//
//  UIImage+KLExtend.m
//  KLTools
//
//  Created by neville on 2018/5/18.
//  Copyright © 2018年 developer. All rights reserved.
//

#import "UIImage+KLExtend.h"

@implementation UIImage (KLExtend)

- (NSString *)base64String:(CGFloat)compressionQuality {
    return [UIImageJPEGRepresentation(self, compressionQuality) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (NSString *)base64String:(CGFloat)compressionQuality options:(NSDataBase64EncodingOptions)options {
    return [UIImageJPEGRepresentation(self, compressionQuality) base64EncodedStringWithOptions:options];
}

#pragma mark - obsoleted methods

- (UIImage *)thumbnailImage:(CGSize)maxSize {
    if (self == nil) {
        return nil;
    }
    
    CGSize oldSize = self.size;
    if (oldSize.width * oldSize.height < maxSize.width * maxSize.height) {
        return self;
    }
    // 缩放比例
    float scale = sqrt((maxSize.width * maxSize.height) / (oldSize.width * oldSize.height));

    CGSize newSize = CGSizeMake(oldSize.width * scale, oldSize.height * scale);
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImage;

//    if (self.size.width < maxSize.width && self.size.height < maxSize.height) {
//        return self;
//    }
//
//    NSInteger ks = 0;
//    if (self.size.width > self.size.height) {
//        ks = (self.size.width) / maxSize.width;
//    } else {
//        ks = (self.size.height) / maxSize.height;
//    }
//    CGSize size = CGSizeMake(self.size.width / ks, self.size.height / ks);
//
//    UIGraphicsBeginImageContext(size);
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    [self drawInRect:rect];
//    UIImage *thumb = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return thumb;
    
//    CGFloat oldScale = 3;
//    if (oldSize.height / oldSize.width > 2) {
//        // 长图(竖向)
//    } else if (oldSize.width / oldSize.height > 2) {
//        // 长图(横向)
//    } else {
//        // 正常图
//    }
}

@end
