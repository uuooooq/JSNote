//
//  SubRecord.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/16.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SubRecord : NSObject

@property(nonatomic,assign) int gID;
@property(nonatomic,strong) NSString *rootKey;
@property(nonatomic,strong) NSString *subKey;
@property(nonatomic,assign) int createTime;

@end

NS_ASSUME_NONNULL_END
