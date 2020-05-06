//
//  ZDWUtility.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/4/20.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZDWUtility : NSObject

+(NSString*)convertStringFromDic:(NSDictionary*)dic;
+ (NSString*)getImagePath:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
