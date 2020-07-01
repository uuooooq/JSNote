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
#import "FolderRecordCell.h"
#import "TextRecordCell.h"
//#import "ItemDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseListViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UICollectionView *shuKucollectionView;
@property(nonatomic,strong) DataSource *dataSource;
@property(nonatomic,strong) NSMutableArray *currentDataArr;
@property(nonatomic,strong) UIView *bottomView;
@property(nonatomic,strong) UILabel *promtLbl;

@property(nonatomic,strong) UICollectionViewFlowLayout *layout;
@property(nonatomic,assign) BOOL isDetailPage;
@property(nonatomic,assign) uint currentPageNum;
@property(nonatomic,assign) uint currentPageContentNum;
@property(nonatomic,assign) int loadPageTime;

-(void)receiveNotiAction;
-(void)updateWithNewData;
-(void)didSelectionCell:(NSIndexPath*)indexPath;
-(void)addAction;
-(void)addTextAction;
-(void)moreAction;
-(void)searchAction;
-(void)addPhotoAction;
-(void)copyAction;
-(void)saveAction;
-(void)longPressAction:(UILongPressGestureRecognizer *)gestureRecognizer;
-(void)itemSetingAction:(DbKeyValue*)keyValue withIndexPath:(NSIndexPath*)indexPath;

-(void)addPhotoStepNext:(DbKeyValue*)keyValue;
-(void)fusizeBtnClick:(UIButton*)btn;
-(void)showFullImageSizeView:(NSString*)imgName;

-(void)deleteAction:(DbKeyValue*)deleteItem withIndexPath:(NSIndexPath*)indexPath;

-(void)noMoreData;

-(void)showText:(DbKeyValue*)editKeyValue;

-(void)refreshView;

-(void)refetchData;

-(void)showPhotoTextEditView:(DbKeyValue*)keyvalue withIndexPath:(NSIndexPath*)indexPath;



@end

NS_ASSUME_NONNULL_END
