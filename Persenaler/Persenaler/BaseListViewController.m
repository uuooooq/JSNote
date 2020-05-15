//
//  BaseListViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/15.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "BaseListViewController.h"

@interface BaseListViewController ()

@end

@implementation BaseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [DataSource sharedDataSource];
    [self createCollectionView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotiAction) name:@"receiveData" object:nil];
}

- (void)createCollectionView{
    
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
}

-(void)receiveNotiAction{
    
    //[weakSelf.shuKucollectionView reloadData];
    //[self.dataSource loadRecord];
    [self.currentDataArr removeAllObjects];
    [self.currentDataArr addObjectsFromArray:self.dataSource.recordArr];
    [self.shuKucollectionView reloadData];
    
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
        return CGSizeMake(screenWidth, screenWidth+100);
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
            return cell;
        }
            
        default:
            return nil;
            break;
    }
    
    //return cell;
    
}


@end
