//
//  BaseListViewController.h
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/15.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseRecordCell.h"
#import "DataSource.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "ZDWUtility.h"
#import "BaseRecordCell.h"
#import "ImageRecordCell.h"
#import "DbKeyValue.h"
#import "NewFunctionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseListViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *shuKucollectionView;
@property(nonatomic,strong) DataSource *dataSource;
@property(nonatomic,strong) NSMutableArray *currentDataArr;
@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UILabel *promtLbl;

@property(nonatomic,strong) UICollectionViewFlowLayout *layout;

-(void)receiveNotiAction;

-(void)didSelectionCell:(NSIndexPath*)indexPath;
-(void)addAction;
-(void)addTextAction;
-(void)moreAction;
-(void)searchAction;
-(void)addPhotoAction;
-(void)copyAction;

-(void)addPhotoStepNext:(DbKeyValue*)keyValue;
-(void)fusizeBtnClick:(UIButton*)btn;
-(void)showFullImageSizeView:(NSString*)imgName;

@end

NS_ASSUME_NONNULL_END
