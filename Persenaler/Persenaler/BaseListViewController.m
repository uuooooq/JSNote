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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGRect collectonFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    
    self.shuKucollectionView = [[UICollectionView alloc] initWithFrame:collectonFrame collectionViewLayout:layout];
    
    layout.headerReferenceSize = CGSizeMake(ZDWSCREEN_WIDTH, 50.0f);  //设置headerView大小
    [self.shuKucollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    self.shuKucollectionView.delegate = self;
    self.shuKucollectionView.dataSource = self;
    //    [self.shuKucollectionView registerClass:[ShukuHomeListCell class] forCellWithReuseIdentifier:@"ShukuHomeListCell"];
    [self.shuKucollectionView registerClass:[BaseRecordCell class] forCellWithReuseIdentifier:@"BaseRecordCell"];
    [self.shuKucollectionView registerClass:[ImageRecordCell class] forCellWithReuseIdentifier:@"ImageRecordCell"];
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
    
    if (keyValue.type == VT_TEXT) {
        return [BaseRecordCell caculateCurrentSize:keyValue.value];
    }

    return CGSizeMake(screenWidth, 180);
    
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
            
        default:
            return nil;
            break;
    }
    
    //return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self didSelectionCell:indexPath];
}
- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    [headerView addSubview:self.promtLbl];
    return headerView;
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

    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        
        for (int i=0; i < [photos count]; i++) {
            PHAsset * currentAsset = [assets objectAtIndex:i];
            UIImage * tmpImg = [photos objectAtIndex:i];
            NSString *currentImgName = [currentAsset valueForKey:@"filename"] ;
            NSData *imagedata=UIImagePNGRepresentation(tmpImg);
            NSString *newImageName=[self getImagePath:currentImgName];
            BOOL result =  [imagedata writeToFile:newImageName options:NSAtomicWrite error:nil];//[imagedata writeToFile:rootDir atomically:YES];
            NSLog(@"=============== %lu  %@",(unsigned long)[photos count],newImageName);
            if (result == YES) {
                NSLog(@"保存成功");
                
                NSMutableDictionary *extCategoryDic = [NSMutableDictionary dictionary];
                [extCategoryDic setObject:IMG forKey:@"type"];
                
                DbKeyValue * keyValue = [DbKeyValue new];
                keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
                keyValue.value = currentImgName;
                keyValue.createTime =[DbKeyValue getCurrentTime];
                keyValue.type = VT_IMG;
                keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
                [self.dataSource addRecord:keyValue];
                
                [self addPhotoStepNext:keyValue];
                //[weakSelf.dataSource addRecord:keyValue];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
            }
        }
        

    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

-(void)addVideoAction{
    NSLog(@"************* addVideoAction");
}

-(void)addAudioAction{
    NSLog(@"************* addAudioAction");
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
