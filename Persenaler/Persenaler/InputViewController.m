//
//  InputViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/15.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "InputViewController.h"
#import "ZDWUtility.h"
#import "FolderViewController.h"
//#import <IQKeyboardManager/IQKeyboardManager.h>


@interface InputViewController (){
    
    UIButton *saveBtn;
}

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [DataSource sharedDataSource];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    _textView.font = [UIFont systemFontOfSize:13];
    
    [self.view addSubview:_textView];
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    
    if(self.editKeyValue){
        UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(moreAction)];
        //self.navigationItem.rightBarButtonItem = moreItem;
        
        self.navigationItem.rightBarButtonItems = @[saveItem,moreItem];
    }
    else{
        self.navigationItem.rightBarButtonItem = saveItem;
    }
    

    
    
    if (self.editKeyValue) {
        self.textView.text = self.editKeyValue.value;
    }
}

-(void)moreAction{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *selectAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //[self deleteAction:keyValue withIndexPath:indexPath];
        [self.dataSource deleteKeyValue:self.editKeyValue];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"refetchData" object:nil];
        [alert dismissViewControllerAnimated:YES completion:^{
            [self.navigationController popViewControllerAnimated:YES];
        } ];
        
    }];

    UIAlertAction *moveAction = [UIAlertAction actionWithTitle:@"移动" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        DbKeyValue *moveItem = self.editKeyValue;//[self.currentDataArr objectAtIndex:indexPath.row];
        FolderViewController *folderVc = [FolderViewController new];
        folderVc.moveKeyValue = moveItem;
        //folderVc.fromKeyValue = self.fromKeyValue;
        
        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:folderVc];
        [self presentViewController:navVC animated:YES completion:^{
            
        }];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alert addAction:selectAction];
    [alert addAction:moveAction];
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)saveAction{
    
    if ([self.textView.text length] < 1) {
        return;
    }
    
    if (self.editKeyValue) {
        self.editKeyValue.value = self.textView.text;
        [self.dataSource updateKeyValue:self.editKeyValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
        
//        [self dismissViewControllerAnimated:YES completion:^{
//
//        }];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    if (self.fromKeyValue) {
        
        DbKeyValue * keyValue = [DbKeyValue new];
        keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
        keyValue.value = self.textView.text;
        keyValue.createTime =[DbKeyValue getCurrentTime];
        keyValue.type = VT_SUB_TEXT;
        //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
        NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
        [propertyDic setValue:@"" forKey:@"markcolor"];
        [propertyDic setValue:@"" forKey:@"markstr"];
        keyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
        keyValue.search = keyValue.value;
        [self.dataSource addRecord:keyValue];
        
        if (self.fromKeyValue.type == VT_TEXT) {
            self.fromKeyValue.type = VT_ROOT_TEXT;
            [self.dataSource updateKeyValue:self.fromKeyValue];
        }
        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
        SubRecord *subRecord = [SubRecord new];
        subRecord.rootKey = self.fromKeyValue.key;
        subRecord.subKey = subItem.key;
        subRecord.createTime = subItem.createTime;
        
        [self.dataSource addSubRecord:subRecord];
        
        
        NSMutableDictionary *fromPropertyDic = [NSMutableDictionary dictionary];
        [fromPropertyDic setValue:@"" forKey:@"markcolor"];
        [fromPropertyDic setValue:@"" forKey:@"markstr"];
        [fromPropertyDic setValue:subItem.key forKey:@"latestsubkey"];
        self.fromKeyValue.property = [ZDWUtility convertStringFromDic:fromPropertyDic];
        [self.dataSource updateKeyValue:self.fromKeyValue];
    }
    else{
        DbKeyValue * keyValue = [DbKeyValue new];
        keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
        keyValue.value = self.textView.text;
        keyValue.createTime =[DbKeyValue getCurrentTime];
        keyValue.type = VT_TEXT;
        //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
        NSMutableDictionary *propertyDic = [NSMutableDictionary dictionary];
        [propertyDic setValue:@"" forKey:@"markcolor"];
        [propertyDic setValue:@"" forKey:@"markstr"];
        keyValue.property = [ZDWUtility convertStringFromDic:propertyDic];
        keyValue.search = keyValue.value;
        [self.dataSource addRecord:keyValue];
    }
    

    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
    
//    [self dismissViewControllerAnimated:YES completion:^{
//
//    }];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
