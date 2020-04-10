//
//  DataBase.h
//  QinlingNovel
//
//  Created by zhu dongwei on 2019/12/29.
//  Copyright © 2019 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataBase : NSObject

+ (instancetype)sharedDataBase;

#pragma mark - DbKeyValue
/**
 *  添加 DbKeyValue
 *
 */
- (void)addKeyValue:(DbKeyValue *)keyValue;
/**
 *  删除 DbKeyValue
 *
 */
- (void)deleteKeyValue:(DbKeyValue *)keyValue;
/**
 *  更新 DbKeyValue
 *
 */
//- (void)updateKeyValue:(DbKeyValue *)keyValue;

- (DbKeyValue *)getKeyValue:(NSString*)key;

- (NSArray *)getKeyValuesFrom:(int)start to:(int)end;

- (NSArray *)getKeyValuesStringFrom:(int)start to:(int)end;

-(NSArray*)getKeyValuesWith:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
