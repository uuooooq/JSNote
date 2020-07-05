//
//  Record.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/16.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _ValueType{
    VT_ALL = 0,
    VT_TEXT,
    VT_IMG,
    VT_VIDEO,
    VT_AUDIO,
    VT_ROOT_TEXT = 10,
    VT_ROOT_IMG,
    VT_ROOT_VIDEO,
    VT_ROOT_AUDIO,
    VT_SUB_TEXT = 20,
    VT_SUB_IMG,
    VT_SUB_VIDEO,
    VT_SUB_AUDIO
}ValueType;

NS_ASSUME_NONNULL_BEGIN

@interface Record : NSObject

@property(nonatomic,assign) int kvid;
@property(nonatomic,strong) NSString *key;
@property(nonatomic,strong) NSString *value;
@property(nonatomic,assign) int createTime;
@property(nonatomic,assign) ValueType type;

@end

NS_ASSUME_NONNULL_END
