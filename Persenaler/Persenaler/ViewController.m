//
//  ViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/2/23.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "ViewController.h"
#import "BaseRecordCell.h"
#import "DataSource.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import "ZDWUtility.h"
#import "ImageRecordCell.h"

@interface ViewController ()<TZImagePickerControllerDelegate>
{
    UIView *bottomView;
    
}

@property(nonatomic,strong) DataSource *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [DataSource sharedDataSource];
//    [self.dataSource loadRecord];
    [self initView];
    //[self initHttpServer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiAction) name:@"receiveData" object:nil];
}


-(void)receiveNotiAction{
    
    //[weakSelf.shuKucollectionView reloadData];
    //[self.dataSource loadRecord];
    [self.shuKucollectionView reloadData];
    
}



-(void)initView{
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGRect collectonFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-50);
    
    self.shuKucollectionView = [[UICollectionView alloc] initWithFrame:collectonFrame collectionViewLayout:layout];
    
    self.shuKucollectionView.delegate = self;
    self.shuKucollectionView.dataSource = self;
//    [self.shuKucollectionView registerClass:[ShukuHomeListCell class] forCellWithReuseIdentifier:@"ShukuHomeListCell"];
    [self.shuKucollectionView registerClass:[BaseRecordCell class] forCellWithReuseIdentifier:@"BaseRecordCell"];
    [self.shuKucollectionView registerClass:[ImageRecordCell class] forCellWithReuseIdentifier:@"ImageRecordCell"];
    [self.shuKucollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.shuKucollectionView.backgroundColor = [UIColor whiteColor];
    
    //self.shuKucollectionView.collectionViewLayout = UICollectionViewFlowLayout;
    
    [self.view addSubview: self.shuKucollectionView];
    
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-60, self.view.frame.size.width, 60)];
    bottomView.backgroundColor = [UIColor lightGrayColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    [btn setTitle:@"图片" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(addPhotoAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bottomView addSubview:btn];

    [self.view addSubview:bottomView];
    
    
}

#pragma mark action method
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
                [extCategoryDic setObject:@"img" forKey:@"type"];
                
                DbKeyValue * keyValue = [DbKeyValue new];
                keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
                keyValue.value = currentImgName;
                keyValue.createTime =[DbKeyValue getCurrentTime];
                keyValue.type = VT_IMG;
                keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
                [self.dataSource addRecord:keyValue];
                //[weakSelf.dataSource addRecord:keyValue];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
            }
        }
        

    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (NSString*)getImagePath:(NSString *)name {

    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);

    NSString *docPath = [path objectAtIndex:0];

    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *finalPath = [docPath stringByAppendingPathComponent:name];

    [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键
    return finalPath;

}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    
    DbKeyValue *keyValue = [self.dataSource.recordArr objectAtIndex:indexPath.row];
    
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
            return cell;
        }
            
        default:
            return nil;
            break;
    }
    
    //return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //return 100;//[self.shuku.novels count];
    return [self.dataSource.recordArr count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DbKeyValue *keyValue = [self.dataSource.recordArr objectAtIndex:indexPath.row];
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    int screenWidth = screenFrame.size.width;
    
    if (keyValue.type == VT_IMG) {
        return CGSizeMake(screenWidth, screenWidth+10*2);
    }

    return CGSizeMake(screenWidth, 60);
    
}

@end
