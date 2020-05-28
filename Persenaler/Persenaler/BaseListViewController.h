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

NS_ASSUME_NONNULL_BEGIN

@interface BaseListViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *shuKucollectionView;
@property(nonatomic,strong) DataSource *dataSource;
@property(nonatomic,strong) NSMutableArray *currentDataArr;

-(void)receiveNotiAction;

-(void)didSelectionCell:(NSIndexPath*)indexPath;
-(void)addAction;
-(void)addTextAction;

-(void)addPhotoStepNext:(DbKeyValue*)keyValue;
-(void)fusizeBtnClick:(UIButton*)btn;

@end

NS_ASSUME_NONNULL_END
