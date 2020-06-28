//
//  InputViewController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/5/15.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "InputViewController.h"
#import "ZDWUtility.h"
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
    
    UIBarButtonItem *moreItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];//initWithImage:[UIImage imageNamed:@"保存"] style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = moreItem;//@[searchItem,settingItem];
    
    if (self.editKeyValue) {
        self.textView.text = self.editKeyValue.value;
    }
}

-(void)saveAction{
    
    if ([self.textView.text length] < 1) {
        return;
    }
    
    if (self.editKeyValue) {
        self.editKeyValue.value = self.textView.text;
        [self.dataSource updateKeyValue:self.editKeyValue];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:nil];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        return;
    }
    

    
    //NSMutableDictionary *extCategoryDic = [NSMutableDictionary dictionary];
    //[extCategoryDic setObject:TXT forKey:@"type"];
    DbKeyValue * keyValue = [DbKeyValue new];
    keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
    keyValue.value = self.textView.text;
    keyValue.createTime =[DbKeyValue getCurrentTime];
    keyValue.type = VT_SUB_TEXT;
    //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
    [self.dataSource addRecord:keyValue];
    
    if (self.fromKeyValue) {
        
        if (self.fromKeyValue.type == VT_TEXT) {
            self.fromKeyValue.type = VT_ROOT_TEXT;
            [self.dataSource updateKeyValue:self.fromKeyValue];
        }
//        NSMutableDictionary *groupCategoryDic = [NSMutableDictionary dictionary];
        
//        DbKeyValueGroup *keyValueGroup = [DbKeyValueGroup new];
//        keyValueGroup.createTime = [DbKeyValueGroup getCurrentTime];
//        keyValueGroup.rootID = self.fromKeyValue.kvid;
//        keyValueGroup.rootValue = self.fromKeyValue.value;
//        keyValueGroup.extCategory = [ZDWUtility convertStringFromDic:groupCategoryDic];
//        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
//        keyValueGroup.subID = subItem.kvid;
//        keyValueGroup.subValue = subItem.value;
//        keyValueGroup.rootType = self.fromKeyValue.type;
//        keyValueGroup.subType = keyValue.type;
        DbKeyValue *subItem = [self.dataSource getKeyValue:keyValue.key];
        SubRecord *subRecord = [SubRecord new];
        subRecord.rootKey = self.fromKeyValue.key;
        subRecord.subKey = subItem.key;
        subRecord.createTime = subItem.createTime;
        
        [self.dataSource addSubRecord:subRecord];
    }
    

    
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
