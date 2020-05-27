//
//  ItemDetailViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/18.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "InputViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    NSLog(@"******************************** ");
    

}


-(void)receiveNotiAction{
    NSLog(@"******************************** receiveNotiAction");
    //[weakSelf.shuKucollectionView reloadData];
    //[self.dataSource loadRecord];
    [self.currentDataArr removeAllObjects];

    [self.currentDataArr addObject:self.fromKeyValue];
    [self.shuKucollectionView reloadData];
    NSArray *tmpGroups = [self.dataSource getKeyValueGroups:[NSString stringWithFormat:@"%d",self.fromKeyValue.kvid]];
    if ([tmpGroups count] > 0) {
        for (DbKeyValueGroup *item in tmpGroups) {
            NSLog(@"================== %@",item.subValue);
            DbKeyValue* keyValue = [DbKeyValue new];
            keyValue.kvid = item.subID;
            keyValue.value = item.subValue;
            keyValue.type = item.subType;
            keyValue.createTime = [DbKeyValue getCurrentTime];
            [self.currentDataArr addObject:keyValue];
        }
    }
    
}

-(void)initView{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAction)];
    
}

//-(void)setFromKeyValue:(DbKeyValue*)keyValue{
//
//}

-(void)setFromKeyValue:(DbKeyValue *)fromKeyValue{
    
    _fromKeyValue = fromKeyValue;
    [self receiveNotiAction];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)addTextAction{
    
    InputViewController *inputVC = [InputViewController new];
    inputVC.fromKeyValue = self.fromKeyValue;
    
    [self presentViewController:inputVC animated:YES completion:^{
        
    }];
    
}

-(void)addPhotoStepNext:(DbKeyValue*)keyValue{
    //NSLog(@"************* addPhotoStepNext");
    if (self.fromKeyValue) {
        NSMutableDictionary *groupCategoryDic = [NSMutableDictionary dictionary];
        
        DbKeyValueGroup *keyValueGroup = [DbKeyValueGroup new];
        keyValueGroup.createTime = [DbKeyValueGroup getCurrentTime];
        keyValueGroup.rootID = self.fromKeyValue.kvid;
        keyValueGroup.rootValue = self.fromKeyValue.value;
        keyValueGroup.extCategory = [ZDWUtility convertStringFromDic:groupCategoryDic];
        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
        keyValueGroup.subID = subItem.kvid;
        keyValueGroup.subValue = subItem.value;
        keyValueGroup.rootType = self.fromKeyValue.type;
        keyValueGroup.subType = keyValue.type;
        
        [self.dataSource addRecordGroup:keyValueGroup];
    }
}

@end
