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
    
    [self.shuKucollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.shuKucollectionView.backgroundColor = [UIColor whiteColor];
    
    //self.shuKucollectionView.collectionViewLayout = UICollectionViewFlowLayout;
    
    [self.view addSubview: self.shuKucollectionView];
    
    
    bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
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

    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    BaseRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BaseRecordCell" forIndexPath:indexPath];
    DbKeyValue *keyValue = [self.dataSource.recordArr objectAtIndex:indexPath.row];
    [cell updateRecord:keyValue];
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    //return 100;//[self.shuku.novels count];
    return [self.dataSource.recordArr count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    //
    int screenWidth = screenFrame.size.width;
    
    return CGSizeMake(screenWidth, 40);
}

@end
