//
//  DbKeyValueGroup.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/18.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum _GroupValueType{
    VTG_ALL = 0,
    VTG_Comment
}GroupValueType;

@interface DbKeyValueGroup : NSObject

@property(nonatomic,assign) int gID;
@property(nonatomic,assign) int rootID;
@property(nonatomic,strong) NSString *rootValue;
@property(nonatomic,assign) ValueType rootType;
@property(nonatomic,assign) int subID;
@property(nonatomic,strong) NSString *subValue;
@property(nonatomic,assign) ValueType subType;
@property(nonatomic,assign) int createTime;
@property(nonatomic,strong) NSString *extCategory; //dictionary <-> json string
@property(nonatomic,assign) GroupValueType type;

+(int)getCurrentTime;

@end

NS_ASSUME_NONNULL_END
