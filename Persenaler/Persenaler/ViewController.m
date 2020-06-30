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

#import "ZDWUtility.h"
#import "ImageRecordCell.h"
#import "SearchViewController.h"
#import "InputViewController.h"
#import "ItemDetailViewController.h"
#import "SearchResultsController.h"
#import <MJRefresh/MJRefresh.h>
#import "NewFolderViewController.h"
#import "FolderViewController.h"

@interface ViewController ()<UISearchControllerDelegate, UISearchBarDelegate>
{
    UIView *bottomView;
    
}

@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) SearchResultsController *resultsController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    //[self receiveNotiAction];
    [self loadNextPage];
    [self.shuKucollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    self.layout.headerReferenceSize = CGSizeMake(ZDWSCREEN_WIDTH, 50.0f);  //设置headerView大小
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveServerNotiAction) name:@"serverRunning" object:nil];
    [self.bottomView addSubview:self.newFunctionView];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //[self.dataSource migrationDb];
    
}






-(void)initView{
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
//    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(goToSearchAction)];
//
    //UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: target:self action:@selector(goToSearchAction)];
////    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(goToSearchAction)];
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"more"] style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
    self.navigationItem.rightBarButtonItem = moreItem;//@[searchItem,settingItem];
    
    //初始化 SearchController
    {
        self.resultsController = [[SearchResultsController alloc] init];
        
        self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsController];
        self.searchController.searchResultsUpdater = self.resultsController;
        self.searchController.delegate = self;
        self.searchController.searchBar.delegate = self;
        //self.searchController.searchBar.prompt = @"xxxksdfjkslflsd";
        self.searchController.obscuresBackgroundDuringPresentation = YES; //搜索时，背景色半透明
        self.searchController.hidesNavigationBarDuringPresentation = YES; //搜索时，隐藏导航栏
        
        self.navigationItem.searchController = self.searchController; //iOS11 后，可以放在导航栏
        
        //self.navigationItem.hidesSearchBarWhenScrolling = NO; //刚开始显示
        self.definesPresentationContext = YES;//解决搜索时iOS13以下系统点哪都没反应的问题
    }
    
}

-(void)receiveNotiAction{
    [super receiveNotiAction];

}
-(NewFunctionView*)newFunctionView{
    if (!_newFunctionView) {
        _newFunctionView = [[NewFunctionView alloc] initWithFrame:self.bottomView.bounds];
        [_newFunctionView.addTxtBtn addTarget:self action:@selector(addTextAction) forControlEvents:UIControlEventTouchUpInside];
        [_newFunctionView.addImgBtn addTarget:self action:@selector(addPhotoAction) forControlEvents:UIControlEventTouchUpInside];
//        [_newFunctionView.addAudioBtn addTarget:self action:@selector(addAudioAction) forControlEvents:UIControlEventTouchUpInside];
//        [_newFunctionView.addVideoBtn addTarget:self action:@selector(addVideoAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [_newFunctionView updateViewFunctionState:VS_HomeList];
    [_newFunctionView.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    [_newFunctionView.folderBtn addTarget:self action:@selector(newFolderAction) forControlEvents:UIControlEventTouchUpInside];
    return _newFunctionView;
}


#pragma mark action method

-(void)longPressAction:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded) {
        return;
    }
    CGPoint p = [gestureRecognizer locationInView:self.shuKucollectionView];

    NSIndexPath *indexPath = [self.shuKucollectionView indexPathForItemAtPoint:p];
    if (indexPath == nil){
        NSLog(@"couldn't find index path");
    } else {
        DbKeyValue *keyValue = [self.currentDataArr objectAtIndex:indexPath.row];
        NSLog(@"===========%@",keyValue.value);
        UICollectionViewCell *cell = [self.shuKucollectionView cellForItemAtIndexPath:indexPath];
        [cell setSelected:YES];
        [self itemSetingAction:keyValue withIndexPath:indexPath];
    }
}

-(void)itemSetingAction:(DbKeyValue*)keyValue withIndexPath:(NSIndexPath*)indexPath{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteAction:keyValue withIndexPath:indexPath];
    }];
    UIAlertAction *editAction = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *moveAction = [UIAlertAction actionWithTitle:@"移动" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        DbKeyValue *moveItem = [self.currentDataArr objectAtIndex:indexPath.row];
        FolderViewController *folderVc = [FolderViewController new];
        folderVc.moveKeyValue = moveItem;
        //folderVc.fromKeyValue = nil;
        
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:folderVc];
        [self presentViewController:navVC animated:YES completion:^{
            
        }];
        
    }];
    UIAlertAction *colorAction = [UIAlertAction actionWithTitle:@"标记颜色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:selectAction];
    [alert addAction:editAction];
    [alert addAction:moveAction];
    [alert addAction:colorAction];
    if (keyValue.type == VT_IMG || keyValue.type == VT_SUB_IMG) {
        UIAlertAction *markAction = [UIAlertAction actionWithTitle:@"标记文字" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            DbKeyValue *editItem = [self.currentDataArr objectAtIndex:indexPath.row];
            [self showPhotoTextEditView:editItem withIndexPath:indexPath];
        }];
        [alert addAction:markAction];
    }
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)loadNextPage{
    
    
//    NSArray *arr = [self.dataSource getRecordsObjFrom:((self.currentPageNum-1)*self.currentPageContentNum) to:self.currentPageNum*self.currentPageContentNum];
//    if (arr && [arr count]>0) {
//        [self.currentDataArr addObjectsFromArray:arr];
//        self.currentPageNum = self.currentPageNum + 1;
//        [self.shuKucollectionView reloadData];
//    }
//    else{
//        [self noMoreData];
//    }
    
    NSArray* arr = [self.dataSource getKeyValuesPageNumWith:self.currentPageContentNum pageWith:self.loadPageTime];
    //NSArray* arr = [self.dataSource getSubRecordsWith:self.fromKeyValue.key pageNumWith:self.currentPageContentNum pageWith:self.loadPageTime];
    if (arr && [arr count]>0) {
        [self.currentDataArr addObjectsFromArray:arr];
        self.currentPageNum = self.currentPageNum + 1;
        [self.shuKucollectionView reloadData];
        
        DbKeyValue *lastValue = [self.currentDataArr lastObject];
        self.loadPageTime = lastValue.createTime;
    }
    else{
        //[self.shuKucollectionView.mj_footer setState:MJRefreshStateNoMoreData];
    }
    if ([arr count]<self.currentPageContentNum) {
        [self noMoreData];
    }

}

-(void)newFolderAction{
    
    NewFolderViewController *newFolder = [NewFolderViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newFolder];
    
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

-(void)updateWithNewData{
    
    int tmpCreateTime = 0;
    
    if ([self.currentDataArr count]>0) {
        DbKeyValue *item = [self.currentDataArr objectAtIndex:0];
        tmpCreateTime = item.createTime;
    }

    NSArray *arr = [self.dataSource getNewRecordsWithCreateTime:tmpCreateTime];
    if (arr && [arr count]>0) {
        for (DbKeyValue* item in arr) {
            [self.currentDataArr insertObject:item atIndex:0];
        }
        [self.shuKucollectionView reloadData];
    }
    
}


-(void)searchAction{
    [self.navigationItem.searchController.searchBar becomeFirstResponder];
}

-(void)receiveServerNotiAction{
//    self.searchController.searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(0, 20);
//    self.searchController.searchBar.prompt = @"xxxksdfjkslflsd";//[self.serverHeadler getAddr];
    self.promtLbl.text = [NSString stringWithFormat:@"网页访问: %@",[self.serverHeadler getAddr]];
}

-(void)goSettingAction{
    [self.navigationController pushViewController:[SearchViewController new] animated:YES];
}

-(void)goToSearchAction{
    
    [self.navigationController pushViewController:[SearchViewController new] animated:YES];
}

-(void)moreAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *settingAction = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:selectAction];
    [alert addAction:settingAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    [headerView addSubview:self.promtLbl];
    return headerView;
}

//-(void)didSelectionCell:(NSIndexPath*)indexPath{
//    
//    DbKeyValue * tmpKeyValue  = [self.currentDataArr objectAtIndex:indexPath.row];
//    if (tmpKeyValue.type == VT_ROOT || tmpKeyValue.type == VT_SUB_ROOT) {
//        ItemDetailViewController *itemDetailVC = [ItemDetailViewController new];
//        itemDetailVC.fromKeyValue = [self.currentDataArr objectAtIndex:indexPath.row];
//        //itemDetailVC.title = @"详情";
//        itemDetailVC.navigationController.navigationBar.prefersLargeTitles = YES;
//        itemDetailVC.title = itemDetailVC.fromKeyValue.value;
//        //itemDetailVC.navigationController.navigationBar.largeTitleTextAttributes =
//        [self.navigationController.navigationBar setLargeTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.0f],NSFontAttributeName,nil]];
//        itemDetailVC.isDetailPage = YES;
//        [self.navigationController pushViewController:itemDetailVC animated:YES];
//    }
//    else{
//        switch (tmpKeyValue.type) {
//            case VT_IMG:
//            {
//                [self showFullImageSizeView:tmpKeyValue.value];
//            }
//                break;
//            case VT_SUB_IMG:
//            {
//                [self showFullImageSizeView:tmpKeyValue.value];
//            }
//                break;
//            case VT_TEXT:
//            {
//                
//            }
//                break;
//            case VT_SUB_TEXT:
//            {
//                
//            }
//                break;
//                
//            default:
//                break;
//        }
//    }
//
//}
//-(void)addPhotoAction{
//    
//    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
//
//    // You can get the photos by block, the same as by delegate.
//    // 你可以通过block或者代理，来得到用户选择的照片.
//    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        
//        
//        for (int i=0; i < [photos count]; i++) {
//            PHAsset * currentAsset = [assets objectAtIndex:i];
//            UIImage * tmpImg = [photos objectAtIndex:i];
//            NSString *currentImgName = [currentAsset valueForKey:@"filename"] ;
//            NSData *imagedata=UIImagePNGRepresentation(tmpImg);
//            NSString *newImageName=[self getImagePath:currentImgName];
//            BOOL result =  [imagedata writeToFile:newImageName options:NSAtomicWrite error:nil];//[imagedata writeToFile:rootDir atomically:YES];
//            NSLog(@"=============== %lu  %@",(unsigned long)[photos count],newImageName);
//            if (result == YES) {
//                NSLog(@"保存成功");
//                
//                NSMutableDictionary *extCategoryDic = [NSMutableDictionary dictionary];
//                [extCategoryDic setObject:@"img" forKey:@"type"];
//                
//                DbKeyValue * keyValue = [DbKeyValue new];
//                keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
//                keyValue.value = currentImgName;
//                keyValue.createTime =[DbKeyValue getCurrentTime];
//                keyValue.type = VT_IMG;
//                keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
//                [self.dataSource addRecord:keyValue];
//                //[weakSelf.dataSource addRecord:keyValue];
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
//            }
//        }
//        
//
//    }];
//    [self presentViewController:imagePickerVc animated:YES completion:nil];
//    
//}
//
//- (NSString*)getImagePath:(NSString *)name {
//
//    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,  NSUserDomainMask, YES);
//
//    NSString *docPath = [path objectAtIndex:0];
//
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//
//    NSString *finalPath = [docPath stringByAppendingPathComponent:name];
//
//    [fileManager createDirectoryAtPath:[finalPath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];//stringByDeletingLastPathComponent是关键
//    return finalPath;
//
//}

#pragma mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController {
    NSLog(@"%s", __FUNCTION__);
}

- (void)didPresentSearchController:(UISearchController *)searchController {
    NSLog(@"%s", __FUNCTION__);
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    NSLog(@"%s", __FUNCTION__);
}

- (void)didDismissSearchController:(UISearchController *)searchController {
    NSLog(@"%s", __FUNCTION__);
}

- (void)presentSearchController:(UISearchController *)searchController {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"%s", __FUNCTION__);
    return YES;
}

//点键盘的搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"%s", __FUNCTION__);
}


@end
