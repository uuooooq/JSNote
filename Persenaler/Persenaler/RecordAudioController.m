//
//  RecordAudioController.m
//  Persenaler
//
//  Created by zhu dongwei on 2020/6/2.
//  Copyright © 2020 zhu dongwei. All rights reserved.
//

#import "RecordAudioController.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ZDWUtility.h"
#import "Waver.h"
#import "DataSource.h"

@interface RecordAudioController (){
    
    //int audioTime;
}

@property(nonatomic,strong)AVAudioRecorder * audioRecorder;
@property (nonatomic,strong)UIView *windowTopRecorderView;
@property (nonatomic,strong)UILabel *windowTopRecorderLabel;
@property(nonatomic,strong)UIButton *startBtn;
@property(nonatomic,strong)UITextField *audioNameTf;
@property(nonatomic,assign)long audioTime;
@property(nonatomic,strong)UIButton *saveBtn;
@property(nonatomic,strong)NSTimer *timer;


@end

@implementation RecordAudioController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    [self initAudioRecorder];
    self.audioTime = 0;
    
    _startBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 20,
                                                           self.view.frame.size.height -60-40,
                                                           40,
                                                           40)];//CGRectMake(10, 80, 40, 40)];
    [_startBtn setImage:[UIImage imageNamed:@"audiostart"] forState:UIControlStateNormal];
    [_startBtn addTarget:self action:@selector(startRecordNotice) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startBtn];
    
    _windowTopRecorderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, ZDWSCREEN_WIDTH-20, 30)];
    _windowTopRecorderLabel.textColor = [UIColor whiteColor];
    _windowTopRecorderLabel.textAlignment = NSTextAlignmentCenter;
    _windowTopRecorderLabel.font = [UIFont systemFontOfSize:15];
    _windowTopRecorderLabel.text = @"00:00";
    [self.view addSubview:_windowTopRecorderLabel];
    
    [self initWaveView];
}

-(void)initWaveView{
    Waver * waver = [[Waver alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.bounds)/2.0 - 50.0, CGRectGetWidth(self.view.bounds), 100.0)];
    
    __block AVAudioRecorder *weakRecorder = self.audioRecorder;
    
    waver.waverLevelCallback = ^(Waver * waver) {
        
        [weakRecorder updateMeters];
        
        CGFloat normalizedValue = pow (10, [weakRecorder averagePowerForChannel:0] / 40);
        
        waver.level = normalizedValue;
        
    };
    [self.view addSubview:waver];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_timer) {
        NSLog(@"================= stop timer");
        [self.timer invalidate];
    }

}

-(void)initAudioRecorder{
    //创建录音文件保存路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    path = [path stringByAppendingFormat:@"/audio.caf"];
    NSURL *url = [NSURL URLWithString: path];
    //创建录音格式设置***************************
    //LinearPCM 是iOS的一种无损编码格式,但是体积较为庞大
    //录音设置
    NSMutableDictionary *recordSettings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [recordSettings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [recordSettings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [recordSettings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    //线性采样位数
    //[recordSettings setValue :[NSNumber numberWithInt:16] forKey: AVLinearPCMBitDepthKey];
    //音频质量,采样质量
    [recordSettings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    //***************************
    //创建录音机
    NSError *error=nil;
    self.audioRecorder=[[AVAudioRecorder alloc]initWithURL:url settings:recordSettings error:&error];
    //如果要监控声波则必须设置为YES
    self.audioRecorder.meteringEnabled=YES;
}
-(void)audioRecordPause{
    if (self.audioRecorder.isRecording) {
        [self.audioRecorder pause];
    }else{
        [self.audioRecorder record];
    }
}



#pragma mark -- 录音开始
- (void)startRecordNotice{
    if ([self.audioRecorder isRecording]) {
        [self recorderFinish:[UIButton new]];
        return;
    }
    else{
        self.audioTime = 0;
        [UIView animateWithDuration:0.5 animations:^{
            [self.startBtn setImage:[UIImage imageNamed:@"audiostop"] forState:UIControlStateNormal];
        }];
    }
    // 删掉录音文件
    [self.audioRecorder deleteRecording];
    //创建音频会话对象
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置category
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    if (![self.audioRecorder isRecording]){
        // 首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        [self.audioRecorder record];
        
        typeof(self) __weak weakSelf = self;
        if (@available(iOS 10.0, *)) {
            [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                NSLog(@"=========== timer fire");
                if (weakSelf.audioRecorder.isRecording) {
                    weakSelf.audioTime = @(weakSelf.audioRecorder.currentTime).integerValue;
                    weakSelf.windowTopRecorderLabel.text = [NSString stringWithFormat:@"%@ %lu:%02ld",@"正在录制",weakSelf.audioTime/60,weakSelf.audioTime%60];
                    weakSelf.timer = timer;
                }
                else{
                    [timer invalidate];
                    weakSelf.timer = nil;
                }

            }];
        } else {
            // Fallback on earlier versions
        }
    }
}

-(void)recorderFinish:(UIButton *)sender{
    NSLog(@"=============== recorderfinish");
    [self.audioRecorder stop];
    [UIView animateWithDuration:0.5 animations:^{
        [self.startBtn setImage:[UIImage imageNamed:@"audiostart"] forState:UIControlStateNormal];
    }];
    self.windowTopRecorderLabel.text = [NSString stringWithFormat:@"%@ %lu:%02ld",@"录制完成",self.audioTime/60,self.audioTime%60];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *tempPath = [documentDirectory stringByAppendingFormat:@"/audio.caf"];
    NSString *audioPath = [documentDirectory stringByAppendingFormat:@"/%f.caf",[[NSDate date] timeIntervalSince1970]];
    [[NSData dataWithContentsOfFile:tempPath] writeToFile:audioPath atomically:YES];
    
    NSMutableDictionary *extCategoryDic = [NSMutableDictionary dictionary];
    [extCategoryDic setObject:AUDIO forKey:@"type"];
    [extCategoryDic setObject:[NSNumber numberWithLong:self.audioTime] forKey:@"audiotime"];
    DbKeyValue * keyValue = [DbKeyValue new];
    keyValue.key = [NSString stringWithFormat:@"%d",[DbKeyValue getCurrentTime]];
    keyValue.value = [audioPath lastPathComponent];
    keyValue.createTime =[DbKeyValue getCurrentTime];
    keyValue.type = VT_AUDIO;
    //keyValue.extCategory = [ZDWUtility convertStringFromDic:extCategoryDic];
    [[DataSource sharedDataSource] addRecord:keyValue];
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI更新代码
        [[NSNotificationCenter defaultCenter] postNotificationName:@"receiveData" object:nil];
    });
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}


@end
