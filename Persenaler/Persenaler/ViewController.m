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

@interface ViewController ()
{
    
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
    
    self.shuKucollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    
    self.shuKucollectionView.delegate = self;
    self.shuKucollectionView.dataSource = self;
//    [self.shuKucollectionView registerClass:[ShukuHomeListCell class] forCellWithReuseIdentifier:@"ShukuHomeListCell"];
    [self.shuKucollectionView registerClass:[BaseRecordCell class] forCellWithReuseIdentifier:@"BaseRecordCell"];
    
    [self.shuKucollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    self.shuKucollectionView.backgroundColor = [UIColor whiteColor];
    
    //self.shuKucollectionView.collectionViewLayout = UICollectionViewFlowLayout;
    
    [self.view addSubview: self.shuKucollectionView];
    
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
