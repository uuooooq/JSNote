//
//  ZDWUtility.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/4/20.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define ZDWSCREEN_WIDTH  ([UIScreen mainScreen].bounds.size.width)
#define ZDWSCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


NS_ASSUME_NONNULL_BEGIN

@interface ZDWUtility : NSObject

+(NSString*)convertStringFromDic:(NSDictionary*)dic;
+ (NSString*)getImagePath:(NSString *)name;

+(CGFloat)getLabelHight:(NSString*)currentStr withWidth:(CGFloat)currentWidth;

+(NSMutableAttributedString*)getLabelAttributeString:(NSString*)value;

+ (void)copyBigFileFromPath:(NSString*)fromPath;

+(NSMutableAttributedString*)getLabelAttributeString:(NSString*)currentStr withFontSize:(UIFont*)foneSize;
+(CGFloat)getLabelHight:(NSString*)currentStr withWidth:(CGFloat)currentWidth withFontSize:(UIFont*)foneSize;

@end

NS_ASSUME_NONNULL_END
