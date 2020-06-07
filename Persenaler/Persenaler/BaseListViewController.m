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

@interface BaseListViewController ()<TZImagePickerControllerDelegate>{
    FullsizeImageView *fullImageView;
}

@end

@implementation BaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.dataSource = [DataSource sharedDataSource];
    fullImageView = [[FullsizeImageView alloc] initWithFrame:self.navigationController.view.bounds];
    [fullImageView.closeBtn addTarget:self action:@selector(dismissFullImageView) forControlEvents:UIControlEventTouchUpInside];
    [self createCollectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiAction) name:@"receiveData" object:nil];
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
    self.shuKucollectionView.backgroundColor = [UIColor whiteColor];
    
    //self.shuKucollectionView.collectionViewLayout = UICollectionViewFlowLayout;
    
    [self.view addSubview: self.shuKucollectionView];
    [self.bottomView addSubview:self.newFunctionView];
}

-(UIView*)bottomView{
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ZDWSCREEN_HEIGHT-50, ZDWSCREEN_WIDTH, 50)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomView];
        
    }
    return _bottomView;
}

-(NewFunctionView*)newFunctionView{
    if (!_newFunctionView) {
        _newFunctionView = [[NewFunctionView alloc] initWithFrame:self.bottomView.bounds];
        [_newFunctionView.addTxtBtn addTarget:self action:@selector(addTextAction) forControlEvents:UIControlEventTouchUpInside];
        [_newFunctionView.addImgBtn addTarget:self action:@selector(addPhotoAction) forControlEvents:UIControlEventTouchUpInside];
        [_newFunctionView.addAudioBtn addTarget:self action:@selector(addAudioAction) forControlEvents:UIControlEventTouchUpInside];
        [_newFunctionView.addVideoBtn addTarget:self action:@selector(addVideoAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _newFunctionView;
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
    
    if (keyValue.type == VT_IMG) {
        return CGSizeMake(screenWidth, screenWidth+30);
    }
    if (keyValue.type == VT_VIDEO) {
        return CGSizeMake(screenWidth, screenWidth+30);
    }
    
    if (keyValue.type == VT_TEXT) {
        return [BaseRecordCell caculateCurrentSize:keyValue.value];
    }
    if (keyValue.type == VT_AUDIO) {
        return CGSizeMake(screenWidth, 50);
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
        case VT_IMG:
        {
            ImageRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            cell.fullsizeBtn.tag = indexPath.row;
            [cell.fullsizeBtn addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //[cell. addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        case VT_VIDEO:
        {
            ImageRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            cell.fullsizeBtn.tag = indexPath.row;
            [cell.fullsizeBtn addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //[cell. addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
        case VT_AUDIO:
        {
            AudioRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AudioRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            
        default:
            return nil;
            break;
    }
    
    //return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self didSelectionCell:indexPath];
}


#pragma mark action


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
    
    [self presentViewController:[InputViewController new] animated:YES completion:^{
        
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
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        
        for (int i=0; i < [photos count]; i++) {
            
            [self copyImageInfoAndInsertToDb:[assets objectAtIndex:i] withImage:[photos objectAtIndex:i] withExtCategoryDic:nil withType:VT_IMG];

        }
        

    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

-(void)moreAction{
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
        keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
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
    [self.navigationController.view addSubview:fullImageView];
}

-(void)dismissFullImageView{
    [fullImageView removeFromSuperview];
}


@end
