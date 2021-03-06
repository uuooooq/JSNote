//
//  ItemDetailViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/18.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "InputViewController.h"
#import "AudioDetailCell.h"
#import "AudioRecordCell.h"
#import "TextDetailCell.h"
#import "VideoRecordCell.h"
#import "NewFolderViewController.h"
#import "FolderViewController.h"
#import "CreateFolderViewController.h"



@interface ItemDetailViewController ()<AVAudioPlayerDelegate,UIDocumentPickerDelegate>{
    UIButton *playBtn;
}

@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBar.prefersLargeTitles = NO;
    [self initView];
    //[self receiveNotiAction];
    self.currentPageContentNum = 100;
    //[self.currentDataArr addObject:self.fromKeyValue];
    [self loadNextPage];
    [self.shuKucollectionView registerClass:[AudioDetailCell class] forCellWithReuseIdentifier:@"AudioDetailCell"];
    [self.shuKucollectionView registerClass:[TextDetailCell class] forCellWithReuseIdentifier:@"TextDetailCell"];
    [self.shuKucollectionView registerClass:[TextDetailCell class] forCellWithReuseIdentifier:@"VideoRecordCell"];
    [self.bottomView addSubview:self.newFunctionView];

}

-(NewFunctionView*)newFunctionView{
    if (!_newFunctionView) {
        _newFunctionView = [[NewFunctionView alloc] initWithFrame:self.bottomView.bounds];
        [_newFunctionView.addTxtBtn addTarget:self action:@selector(addTextAction) forControlEvents:UIControlEventTouchUpInside];
        [_newFunctionView.addImgBtn addTarget:self action:@selector(addPhotoAction) forControlEvents:UIControlEventTouchUpInside];
//        [_newFunctionView.addAudioBtn addTarget:self action:@selector(addAudioAction) forControlEvents:UIControlEventTouchUpInside];
//        [_newFunctionView.addVideoBtn addTarget:self action:@selector(addVideoAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    if (self.fromKeyValue.type == VT_ROOT || self.fromKeyValue.type == VT_TEXT || self.fromKeyValue.type == VT_SUB_ROOT) {
        [_newFunctionView updateViewFunctionState:VS_ItemDetail_Text];
        //[_newFunctionView.copyyBtn addTarget:self action:@selector(copyAction) forControlEvents:UIControlEventTouchUpInside];
        [_newFunctionView.folderBtn addTarget:self action:@selector(newFolderAction) forControlEvents:UIControlEventTouchUpInside];
    }
    else if(self.fromKeyValue.type == VT_IMG){
        [_newFunctionView updateViewFunctionState:VS_ItemDetail_Img];
        [_newFunctionView.saveBtn addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
    }
//    [_newFunctionView.searchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
    return _newFunctionView;
}


-(void)receiveNotiAction{
    
    //[weakSelf.shuKucollectionView reloadData];
    //[self.dataSource loadRecord];
//    [self.currentDataArr removeAllObjects];
//
//    [self.currentDataArr addObject:self.fromKeyValue];
//    [self.shuKucollectionView reloadData];
//    //NSArray *tmpGroups = [self.dataSource getKeyValueGroups:self.fromKeyValue.key];//[self.dataSource getKeyValueGroups:[NSString stringWithFormat:@"%d",self.fromKeyValue.kvid]];
//
//    NSArray *tmpGroups = [self.dataSource getSubRecordsWith:self.fromKeyValue.key];
//    if ([tmpGroups count] > 0) {
//        for (DbKeyValue *item in tmpGroups) {
//
////            DbKeyValue* keyValue = [DbKeyValue new];
////            keyValue.kvid = item.subID;
////            keyValue.value = item.subValue;
////            keyValue.type = item.subType;
////            keyValue.createTime = [DbKeyValue getCurrentTime];
//            [self.currentDataArr addObject:item];
//        }
//
//    }
    
    //NSArray* tmpSubRecords = [self.dataSource getNewSubRecordsWith:self.fromKeyValue. withRootKey:<#(nonnull NSString *)#>];
    

    
    //[self.newFunctionView updateViewFunctionState:];
    
}


-(void)loadNextPage{
    
    
//    NSArray *arr = [self.dataSource getSubRecordsWith:self.fromKeyValue.key from:((self.currentPageNum-1)*self.currentPageContentNum) to:self.currentPageNum*self.currentPageContentNum];//getRecordsObjFrom:((self.currentPageNum-1)*self.currentPageContentNum) to:self.currentPageNum*self.currentPageContentNum];
    
    
    NSArray* arr = [self.dataSource getSubRecordsWith:self.fromKeyValue.key pageNumWith:self.currentPageContentNum pageWith:self.loadPageTime];
    if (arr && [arr count]>0) {
        if (self.currentPageNum == 1) {
            [self.currentDataArr removeAllObjects];
        }
        [self.currentDataArr addObjectsFromArray:arr];
        self.currentPageNum = self.currentPageNum + 1;
        [self.shuKucollectionView reloadData];
        
        DbKeyValue *lastValue = [self.currentDataArr firstObject];
        self.loadPageTime = lastValue.createTime;
    }
    else{
        //[self.shuKucollectionView.mj_footer setState:MJRefreshStateNoMoreData];
    }
    if ([arr count]<self.currentPageContentNum) {
        [self noMoreData];
    }

}

-(void)updateWithNewData{
    
    int tmpCreateTime = 0;
    
    if ([self.currentDataArr count]>0) {
        DbKeyValue *item = [self.currentDataArr firstObject];
        tmpCreateTime = item.createTime;
    }

    NSArray *arr = [self.dataSource getNewSubRecordsWithCreateTime:tmpCreateTime withRootKey:self.fromKeyValue.key];
    if (arr && [arr count]>0) {
        for (DbKeyValue* item in arr) {
            [self.currentDataArr insertObject:item atIndex:0];
        }
        
    }
    [self.shuKucollectionView reloadData];
    
}

-(void)initView{
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    
}

//-(void)setFromKeyValue:(DbKeyValue*)keyValue{
//
//}

-(void)setFromKeyValue:(DbKeyValue *)fromKeyValue{
    
    _fromKeyValue = fromKeyValue;
    //[self receiveNotiAction];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark action

-(void)showText:(DbKeyValue*)editKeyValue{
    
    InputViewController *inputVc = [InputViewController new];
    inputVc.editKeyValue = editKeyValue;
    inputVc.fromKeyValue = self.fromKeyValue;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:inputVc];
//    nav.modalPresentationStyle = UIModalPresentationFullScreen;
//    [self.navigationController presentViewController:nav animated:YES completion:^{
//
//    }];
     [self.navigationController pushViewController:inputVc animated:YES];
    
}

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

    UIAlertAction *moveAction = [UIAlertAction actionWithTitle:@"移动" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DbKeyValue *moveItem = [self.currentDataArr objectAtIndex:indexPath.row];
        FolderViewController *folderVc = [FolderViewController new];
        folderVc.moveKeyValue = moveItem;
        //folderVc.fromKeyValue = self.fromKeyValue;
        
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:folderVc];
        [self presentViewController:navVC animated:YES completion:^{
            
        }];
    }];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"保存到相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //[self deleteAction:keyValue withIndexPath:indexPath];
        [self savePhotoAction:keyValue];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:selectAction];
    //if (keyValue.type == VT_SUB_IMG || keyValue.type == VT_SUB_TEXT) {
        [alert addAction:moveAction];
    //}
    if (keyValue.type == VT_SUB_IMG || keyValue.type == VT_IMG) {
        [alert addAction:saveAction];
    }
    if (keyValue.type == VT_SUB_IMG) {
        UIAlertAction *markAction = [UIAlertAction actionWithTitle:@"文字备注" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            DbKeyValue *editItem = [self.currentDataArr objectAtIndex:indexPath.row];
            [self showPhotoTextEditView:editItem withIndexPath:indexPath];
        }];
        [alert addAction:markAction];
    }
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)copyAction{
    
//    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//    pasteboard.string = self.fromKeyValue.value;
//
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"已经拷贝到剪贴板中" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alertVC addAction:cancelAction];
//    [self presentViewController:alertVC animated:YES completion:nil];
    
    /*
     支持的文件类型
     尝试将这个设置成一个空数组 验证效果。会很快明白这个设置是干嘛用的
     */
    NSArray *types = @[@"public.content",@"public.text",@"public.source-code",@"public.image",@"public.audiovisual-content",@"com.adobe.pdf",@"com.apple.keynote.key",@"com.microsoft.word.doc",@"com.microsoft.execl.xls",@"com.microsoft.powerpoint.ppt"];
    
    UIDocumentPickerViewController *vc = [[UIDocumentPickerViewController alloc]initWithDocumentTypes:types inMode:UIDocumentPickerModeOpen];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)newFolderAction{
    
//    NewFolderViewController *newFolderVc = [NewFolderViewController new];
////    newFolderVc.isSubItem = YES;
//    newFolderVc.fromKeyValue = self.fromKeyValue;
////    [self presentViewController:newFolderVc animated:YES completion:^{
////
////    }];
//
//    //NewFolderViewController *newFolder = [NewFolderViewController new];
//     UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:newFolderVc];
//
//     [self presentViewController:nav animated:YES completion:^{
//
//     }];
    
    CreateFolderViewController *addFolderVc = [CreateFolderViewController new];
    //addPhotoVc.editKeyValue = keyvalue;
    addFolderVc.fromKeyValue = self.fromKeyValue;
    STPopupController *popupController = [[STPopupController alloc] initWithRootViewController:addFolderVc];
    popupController.containerView.layer.cornerRadius = 4;
    [popupController presentInViewController:self];
}

//-(void)saveAction{
//    NSString* filePath = [ZDWUtility getImagePath:self.fromKeyValue.value];//[self getImagePath:value.value];
//    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
//    
//}
//
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//
//    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error.description, contextInfo);
//    
//    if (!error) {
//        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"已经保存到相册中" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            
//        }];
//        [alertVC addAction:cancelAction];
//        [self presentViewController:alertVC animated:YES completion:nil];
//    }
//    
//    
//}

-(void)addTextAction{
    
//    InputViewController *inputVC = [InputViewController new];
//    inputVC.fromKeyValue = self.fromKeyValue;
//    //inputVC.isSubItem = YES;
//    [self presentViewController:inputVC animated:YES completion:^{
//
//    }];
    
    [self showText:nil];
}

-(void)addPhotoStepNext:(DbKeyValue*)keyValue{
    //NSLog(@"************* addPhotoStepNext");
    if (self.fromKeyValue) {
        
        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
        SubRecord *subRecord = [SubRecord new];
        subRecord.rootKey = self.fromKeyValue.key;
        subRecord.subKey = subItem.key;
        subRecord.createTime = subItem.createTime;
        
        [self.dataSource addSubRecord:subRecord];
    }
}

-(void)playClickAction:(UIButton*)btn{
    NSLog(@"play click action ===============");
    [self playMusic:btn];
    
    
}

#pragma mark -- 播放音频

- (void)playMusic:(UIButton*)btn
{

    if (!self.audioPlayer.isPlaying)
    {

        [self.audioPlayer play];
        //开始计时
        //self.timer.fireDate = [NSDate distantPast];
        [btn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];

    }
    else{
        [self pauseMusic];
        [btn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }

}


- (void)pauseMusic
{

    if (self.audioPlayer.isPlaying)
    {

        [self.audioPlayer pause];
        [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        //暂停定时器
        //self.timer.fireDate = [NSDate distantFuture];

    }

}

- (AVAudioPlayer*)audioPlayer
{
    if (!_audioPlayer) {
        
        NSString *kMusicFile = [ZDWUtility getImagePath:self.fromKeyValue.value];

        //获取本地播放文件路径
        //NSString *path = [[NSBundle mainBundle] pathForResource:kMusicFile ofType:nil];

        NSError *error = nil;

        //初始化播放器 stringByAddingPercentEncodingWithAllowedCharacters
        //_audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] error:&error];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:kMusicFile] error:&error];
        if (error) {
            NSLog(@"=============== error:%@",error.description);
            return nil;
        }
        //是否循环播放
        _audioPlayer.numberOfLoops = 0;

        //把播放文件加载到缓存中（注意：即使在播放之前音频文件没有加载到缓冲区程序也会隐式调用此方法。）
        [_audioPlayer prepareToPlay];

        //设置代理，监听播放状态(例如:播放完成)
        _audioPlayer.delegate = self;


//        // 设置音频会话模式，后台播放
//        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
//        [audioSession setActive:YES error:nil];


        // 添加通知(输出改变通知)  ios 6.0 后
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeChange:) name:AVAudioSessionRouteChangeNotification object:nil];



        if (error) {

            NSAssert(YES,@"音乐初始化过程报错");

        }


    }
    return _audioPlayer;
}

- (void)routeChange:(NSNotification*)notification
{

    NSDictionary *dic = notification.userInfo;

    int changeReason = [dic[AVAudioSessionRouteChangeReasonKey] intValue];

    //等于AVAudioSessionRouteChangeReasonOldDeviceUnavailable表示旧输出不可用
    if (changeReason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable)
    {
        AVAudioSessionRouteDescription *routeDescription=dic[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription= [routeDescription.outputs firstObject];
        //原设备为耳机则暂停
        if ([portDescription.portType isEqualToString:@"Headphones"])
        {
            //这边必须回调到主线程
            dispatch_async(dispatch_get_main_queue(), ^{

                //self.playOrPause.selected = NO;

            });

            //[self pauseMusic];
        }
    }

}//输出改变通知


#pragma mark - AVAudioPlayer Delegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{

    [playBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];

}

#pragma mark collection delegate overrate


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DbKeyValue *keyValue = [self.currentDataArr objectAtIndex:indexPath.row];
    CGRect screenFrame = [UIScreen mainScreen].bounds;
    int screenWidth = screenFrame.size.width;
    
        if (keyValue.type == VT_IMG) {
            return CGSizeMake(screenWidth, screenWidth);
        }
        
        if (keyValue.type == VT_TEXT) {
            return [TextRecordCell caculateCurrentSize:keyValue.value];
        }
        
        if (keyValue.type == VT_SUB_IMG) {
            return CGSizeMake(screenWidth, screenWidth);
        }
        
        if (keyValue.type == VT_SUB_TEXT) {
            return [TextRecordCell caculateCurrentSize:keyValue.value];
        }
        if (keyValue.type == VT_ROOT) {
            return CGSizeMake(screenWidth, 80);
        }
    if (keyValue.type == VT_SUB_ROOT) {
        return CGSizeMake(screenWidth, 80);
    }
        

//    }
    
    return CGSizeMake(screenWidth, 60);
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    
    
    DbKeyValue *keyValue = [self.currentDataArr objectAtIndex:indexPath.row];
    
    switch (keyValue.type) {
        case VT_TEXT:
        {
            TextRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TextRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            break;
        case VT_IMG:
        {
            ImageRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            //cell.fullsizeBtn.tag = indexPath.row;
            //[cell.fullsizeBtn addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //[cell. addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
        case VT_SUB_TEXT:
        {
            TextRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TextRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            break;
        case VT_SUB_IMG:
        {
            ImageRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            //cell.fullsizeBtn.tag = indexPath.row;
            //[cell.fullsizeBtn addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            //[cell. addTarget:self action:@selector(fusizeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
            break;
        case VT_ROOT:
        {
            FolderRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FolderRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            break;
        case VT_SUB_ROOT:
        {
            FolderRecordCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FolderRecordCell" forIndexPath:indexPath];
            [cell updateRecord:keyValue];
            
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
    
    //return cell;
    
}

//-(void)didSelectionCell:(NSIndexPath*)indexPath{
//    
////    if (indexPath.row == 0) {
////        if (self.fromKeyValue.type == VT_IMG || self.fromKeyValue.type == VT_SUB_IMG) {
////            [self showFullImageSizeView:self.fromKeyValue.value];
////        }
////    }
////    else{
////        ItemDetailViewController *itemDetailVC = [ItemDetailViewController new];
////        itemDetailVC.fromKeyValue = [self.currentDataArr objectAtIndex:indexPath.row];
////        //itemDetailVC.title = @"详情";
////        itemDetailVC.isDetailPage = YES;
////        [self.navigationController pushViewController:itemDetailVC animated:YES];
////    }
//}

#pragma mark -- UIDocumentPickerDelegate
//选取到文件 回调
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls {
    
}
//取消的回调
- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller {
    
}

@end
