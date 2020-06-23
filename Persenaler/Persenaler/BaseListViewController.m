//
//  BaseListViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/15.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "BaseListViewController.h"
#import "InputViewController.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "FullsizeImageView.h"
#import "RecordAudioController.h"
#import "AudioRecordCell.h"
#import "VideoRecordCell.h"
#import <MJRefresh/MJRefresh.h>


@interface BaseListViewController ()<TZImagePickerControllerDelegate>{
    FullsizeImageView *fullImageView;
    MJRefreshAutoNormalFooter * footer;
}

@end

@implementation BaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPageNum = 1;
    self.currentPageContentNum = 20;
    _loadPageTime = 0;
    //self.dataSource = [DataSource sharedDataSource];
    fullImageView = [[FullsizeImageView alloc] initWithFrame:self.navigationController.view.bounds];
    [fullImageView.closeBtn addTarget:self action:@selector(dismissFullImageView) forControlEvents:UIControlEventTouchUpInside];
    [self createCollectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateWithNewData) name:@"receiveData" object:nil];
    
    // long press gesture action
//    UILongPressGestureRecognizer *lpgr =  [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//    lpgr.delegate = self;
//    lpgr.delaysTouchesBegan = YES;
//    [self.shuKucollectionView addGestureRecognizer:lpgr];
}

-(DataSource*)dataSource{
    if (_dataSource == nil) {
        _dataSource = [DataSource sharedDataSource];
    }
    return _dataSource;
}

- (void)createCollectionView{
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGRect collectonFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    
    self.shuKucollectionView = [[UICollectionView alloc] initWithFrame:collectonFrame collectionViewLayout:_layout];
    
    
//    [self.shuKucollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//
    self.shuKucollectionView.delegate = self;
    self.shuKucollectionView.dataSource = self;
    //    [self.shuKucollectionView registerClass:[ShukuHomeListCell class] forCellWithReuseIdentifier:@"ShukuHomeListCell"];
    [self.shuKucollectionView registerClass:[BaseRecordCell class] forCellWithReuseIdentifier:@"BaseRecordCell"];
    [self.shuKucollectionView registerClass:[ImageRecordCell class] forCellWithReuseIdentifier:@"ImageRecordCell"];
    [self.shuKucollectionView registerClass:[AudioRecordCell class] forCellWithReuseIdentifier:@"AudioRecordCell"];
    [self.shuKucollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.shuKucollectionView registerClass:[VideoRecordCell class] forCellWithReuseIdentifier:@"VideoRecordCell"];
    [self.shuKucollectionView registerClass:[FolderRecordCell class] forCellWithReuseIdentifier:@"FolderRecordCell"];
    self.shuKucollectionView.backgroundColor = [UIColor whiteColor];
    
    //self.shuKucollectionView.collectionViewLayout = UICollectionViewFlowLayout;
    __weak __typeof(self) weakSelf = self;
   footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
             // UI更新代码
             //[[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
            [weakSelf loadNextPage];
            [weakSelf.shuKucollectionView.mj_footer endRefreshing];
         });
    }];
//    [footer setTitle:@"下拉显示更多数据" forState:MJRefreshStateIdle];
//    [footer setTitle:@"没有数据了" forState:MJRefreshStateNoMoreData];
    self.shuKucollectionView.mj_footer = footer;
    
    
//    self.shuKucollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        // 增加5条假数据
////        for (int i = 0; i<5; i++) {
////            [weakSelf.colors addObject:MJRandomColor];
////        }
//
//        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [weakSelf.shuKucollectionView reloadData];
////
////            // 结束刷新
////            [weakSelf.shuKucollectionView.mj_footer endRefreshing];
////        });
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // UI更新代码
//            //[[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
//            [weakSelf loadNextPage];
//             [weakSelf.shuKucollectionView.mj_footer endRefreshing];
//        });
//    }];
    
    [self.view addSubview: self.shuKucollectionView];
    
}

-(UIView*)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ZDWSCREEN_HEIGHT-50, ZDWSCREEN_WIDTH, 50)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomView];
        
    }
    return _bottomView;
}



-(UILabel*)promtLbl{
    if (!_promtLbl) {
        _promtLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, ZDWSCREEN_WIDTH-20, 20)];
    }
    return _promtLbl;
}

-(void)receiveNotiAction{

    //[weakSelf.shuKucollectionView reloadData];
    //[self.dataSource loadRecord];
    [self.currentDataArr removeAllObjects];
    [self.currentDataArr addObjectsFromArray:self.dataSource.recordArr];
    [self.shuKucollectionView reloadData];

}



-(void)didSelectionCell:(NSIndexPath*)indexPath{
    
    NSLog(@"应在子类中实现");
}

-(NSMutableArray*)currentDataArr{
    if (!_currentDataArr) {
        _currentDataArr = [NSMutableArray array];
    }
    return _currentDataArr;
}


#pragma mark - Collection delegate

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //return 100;//[self.shuku.novels count];
    return [self.currentDataArr count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DbKeyValue *keyValue = [self.currentDataArr objectAtIndex:indexPath.row];
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    int screenWidth = screenFrame.size.width;
    
    if (keyValue.type == VT_IMG || keyValue.type == VT_SUB_IMG) {
        return CGSizeMake(screenWidth, screenWidth);
    }
    if (keyValue.type == VT_VIDEO || keyValue.type == VT_SUB_VIDEO) {
        return CGSizeMake(screenWidth, screenWidth);
    }
    
    if (keyValue.type == VT_TEXT || keyValue.type == VT_SUB_TEXT) {
        return [BaseRecordCell caculateCurrentSize:keyValue.value];
    }
    if (keyValue.type == VT_AUDIO || keyValue.type == VT_SUB_AUDIO) {
        return CGSizeMake(screenWidth, 50);
    }
    
    
    if (keyValue.type == VT_ROOT_TEXT) {
        return CGSizeMake(screenWidth, 80);
    }

    return CGSizeMake(screenWidth, 60);
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    
    DbKeyValue *keyValue = [self.currentDataArr objectAtIndex:indexPath.row];
    
    switch (keyValue.type) {
        case VT_TEXT:
        {
            BaseRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            break;
        case VT_ROOT_TEXT:
        {
            FolderRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FolderRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            break;
        case VT_IMG:
        {
            ImageRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            cell.fullsizeBtn.tag = indexPath.row;
            [cell.fullsizeBtn addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //[cell. addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
        case VT_VIDEO:
        {
            VideoRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            return cell;
        }
            break;
        case VT_AUDIO:
        {
            AudioRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AudioRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            break;
        case VT_SUB_TEXT:
        {
            BaseRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            break;
        case VT_SUB_IMG:
        {
            ImageRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            cell.fullsizeBtn.tag = indexPath.row;
            [cell.fullsizeBtn addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //[cell. addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
        case VT_SUB_VIDEO:
        {
            VideoRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            return cell;
        }
            break;
        case VT_SUB_AUDIO:
        {
            AudioRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AudioRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            break;
        default:
        {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
            return cell;
        }
            //return nil;
            break;
    }
    
    //return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self didSelectionCell:indexPath];
}


#pragma mark action


//-(void)longPressAction:(UILongPressGestureRecognizer *)gestureRecognizer{
//    
//    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
//        return;
//    }
//    CGPoint p = [gestureRecognizer locationInView:self.shuKucollectionView];
//
//    NSIndexPath *indexPath = [self.shuKucollectionView indexPathForItemAtPoint:p];
//    if (indexPath == nil){
//        NSLog(@"couldn't find index path");
//    } else {
//        // get the cell at indexPath (the one you long pressed)
////        UICollectionViewCell* cell =
////        [self.shuKucollectionView cellForItemAtIndexPath:indexPath];
//        // do stuff with the cell
//        
//        DbKeyValue *item = [self.currentDataArr objectAtIndex:indexPath.row];
//        NSLog(@"click cell at index : %ld value:%@",indexPath.row,item.value);
//    }
//}

-(void)loadNextPage{
    
    
}

-(void)noMoreData{
    [self.shuKucollectionView.mj_footer setState:MJRefreshStateNoMoreData];
    [footer setTitle:@"已无更多数据" forState:MJRefreshStateIdle];
}

-(void)updateWithNewData{
    
//    int tmpCreateTime = 0
//
//    if ([self.currentDataArr count] >0) {
//        DbKeyValue *tmpItem = [];
//    }
//
//    NSArray *arr = [self.dataSource getNewRecordsWithCreateTime:];
    
}

-(void)saveAction{
    
}


-(void)addAction{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"选择类型"
                                   message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"图片" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self addPhotoAction];
    }];
    UIAlertAction* defaultAction1 = [UIAlertAction actionWithTitle:@"文字" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {
        [self addTextAction];
    }];
    UIAlertAction* defaultAction2 = [UIAlertAction actionWithTitle:@"故事线" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];
     
    [alert addAction:defaultAction];
    [alert addAction:defaultAction1];
    [alert addAction:defaultAction2];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)addTextAction{
    InputViewController *inputVc = [InputViewController new];
    if (self.isDetailPage) {
        inputVc.isSubItem = YES;
    }
    else{
        inputVc.isSubItem = NO;
    }
    [self presentViewController:inputVc animated:YES completion:^{
        
    }];
    
}
-(void)addPhotoAction{
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.allowTakeVideo = NO;
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingVideo = NO;
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    
    ValueType vt;
    if (self.isDetailPage) {
        vt = VT_SUB_IMG;
    }
    else{
        vt = VT_IMG;
    }
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        
        for (int i=0; i < [photos count]; i++) {
            
            [self copyImageInfoAndInsertToDb:[assets objectAtIndex:i] withImage:[photos objectAtIndex:i] withExtCategoryDic:nil withType:vt];

        }
        

    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

-(void)moreAction{
    NSLog(@"在子类中实现");
}

-(void)searchAction{
    NSLog(@"在子类中实现");
}

-(void)copyAction{
    NSLog(@"在子类中实现");
}

-(void)copyImageInfoAndInsertToDb:(PHAsset *)currentAsset
                        withImage:(UIImage*)currentImg
               withExtCategoryDic:(NSMutableDictionary*)extCategoryDic
                         withType:(ValueType)type{
    
    UIImage * tmpImg = currentImg;
    NSString *currentImgName = [currentAsset valueForKey:@"filename"] ;
    NSData *imagedata=UIImagePNGRepresentation(tmpImg);
    NSString *newImageName=[self getImagePath:currentImgName];
    BOOL result =  [imagedata writeToFile:newImageName options:NSAtomicWrite error:nil];//[imagedata writeToFile:rootDir atomically:YES];
    NSLog(@"===============  %@",newImageName);
    if (result == YES) {
        NSLog(@"保存成功");
        if (!extCategoryDic) {
            extCategoryDic = [NSMutableDictionary dictionary];
            [extCategoryDic setObject:IMG forKey:@"type"];
        }
        
        DbKeyValue * keyValue = [DbKeyValue new];
        keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
        keyValue.value = currentImgName;
        keyValue.createTime =[DbKeyValue getCurrentTime];
        keyValue.type = type;
        //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
        [self.dataSource addRecord:keyValue];
        
        [self addPhotoStepNext:keyValue];
        //[weakSelf.dataSource addRecord:keyValue];
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
        });
    }
}

-(void)addVideoAction{
    NSLog(@"************* addVideoAction");
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.allowTakeVideo = YES;
    imagePickerVc.allowTakePicture = NO;
    imagePickerVc.allowPickingImage = NO;
    imagePickerVc.allowPickingVideo = YES;
    
    [imagePickerVc setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *asset) {
        
        [[TZImageManager manager] getVideoOutputPathWithAsset:asset presetName:AVAssetExportPresetHighestQuality success:^(NSString *outputPath) {
            // NSData *data = [NSData dataWithContentsOfFile:outputPath];
            NSLog(@"视频导出到本地完成,沙盒路径为:%@",outputPath);
            // Export completed, send video here, send by outputPath or NSData
            // 导出完成，在这里写上传代码，通过路径或者通过NSData上传
            
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            //全局队列+异步任务
            dispatch_async(queue, ^{
                [ZDWUtility copyBigFileFromPath:outputPath];
                NSMutableDictionary *extCategoryDic = [NSMutableDictionary dictionary];
                [extCategoryDic setObject:VIDEO forKey:@"type"];
                [extCategoryDic setObject:[outputPath lastPathComponent] forKey:@"filename"];
                [self copyImageInfoAndInsertToDb:asset withImage:coverImage withExtCategoryDic:extCategoryDic withType:VT_VIDEO];
                NSLog(@"%@",[NSThread currentThread]);
            });
            
            
            //[ZDWUtility copyBigFileFromPath:outputPath];
        } failure:^(NSString *errorMessage, NSError *error) {
            NSLog(@"视频导出失败:%@,error:%@",errorMessage, error);
        }];
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

-(void)addAudioAction{
    NSLog(@"************* addAudioAction");
    
    [self.navigationController presentViewController:[RecordAudioController new] animated:YES completion:^{
        
    }];
    
}

-(void)addPhotoStepNext:(DbKeyValue*)keyValue{
    NSLog(@"************* addPhotoStepNext");
}

- (NSString*)getImagePath:(NSString *)name {

    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);

    NSString *docPath = [path objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *finalPath = [docPath stringByAppendingPathComponent:name];

    [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键
    return finalPath;

}

-(void)fusizeBtnClick:(UIButton*)btn{
    
    DbKeyValue *keyValue = [self.currentDataArr objectAtIndex:btn.tag];
    NSLog(@"fullsize btn click %@",keyValue.value);
    [self showFullImageSizeView:keyValue.value];
}

-(void)showFullImageSizeView:(NSString*)imgName{
    
    [fullImageView showImage:imgName];
    [fullImageView.closeBtn addTarget:self action:@selector(dismissFullImageView) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.view addSubview:fullImageView];
}

-(void)dismissFullImageView{
    [fullImageView removeFromSuperview];
}


@end
