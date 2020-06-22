//
//  NewFunctionView.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/29.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbKeyValue.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum _ViewState{
    VS_HomeList = 0,
    VS_ItemDetail_Text,
    VS_ItemDetail_Img
}ViewState;

@interface NewFunctionView : UIView

@property(nonatomic,strong) UIButton * addTxtBtn;
@property(nonatomic,strong) UIButton * addImgBtn;
@property(nonatomic,strong) UIButton * editBtn;
@property(nonatomic,strong) UIButton * copyyBtn;
@property(nonatomic,strong) UIButton * folderBtn;
@property(nonatomic,strong) UIButton * searchBtn;
@property(nonatomic,strong) UIButton * saveBtn;
@property(nonatomic,strong) UIButton * tagBtn;
//@property(nonatomic,strong) UIButton * addFileBtn;
// 添加联系人，添加网页地址，文件


-(void)updateViewFunctionState:(ViewState)viewState;

@end

NS_ASSUME_NONNULL_END
