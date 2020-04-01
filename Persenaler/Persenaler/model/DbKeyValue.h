//
//  DbKeyValue.h
//  QinlingNovel
//
//  Created by zhu dongwei on 2020/1/1.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DbKeyValue : NSObject

@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *value;
@property(nonatomic,assign) int createTime;
@property(nonatomic,strong) NSString *extCategory;

+(int)getCurrentTime;

@end

NS_ASSUME_NONNULL_END
