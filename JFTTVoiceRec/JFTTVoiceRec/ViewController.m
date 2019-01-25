//
//  ViewController.m
//  JFTTVoiceRec
//
//  Created by 黄鹏飞 on 2019/1/24.
//  Copyright © 2019 com.hpf. All rights reserved.
//

#import "ViewController.h"
#import "JFOnlineVoiceRecoTool.h"
#import "DemoUtil.h"
#import "NSString+Distance.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (copy, nonatomic) NSString *voiceId;      // 消息id
@property (copy, nonatomic) NSString *resultPer;    // 当前时间片的结果
@property (assign, nonatomic) NSInteger curIndex;   // 数组当前的index
@property (nonatomic, strong) NSMutableArray *mArr; // 文章数组
@property (nonatomic, strong) NSMutableArray *showArr; // 需要显示的临时数组
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat percent = [@"cen ci xing cai" likePercent:@"qing chi xiang cai"];
    NSLog(@"%f", percent);
}

- (IBAction)startBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if(sender.selected){
        
        self.resultPer = @"";
        [self.showArr removeAllObjects];
        self.curIndex = 0;
        __weak typeof(self) wSelf = self;
        [[JFOnlineVoiceRecoTool shareInstance] startHandler:^(JFTentcentHandler * _Nonnull handler) {
            __strong typeof(self) strongSelf = wSelf;
            // 获取结果的字数，获取inex的字数，
            // 结果截取0-index的字数，如果相等 则显示出来
            // 结果去掉显示出来的文本，和index+1 再次比较
            if(handler.text.length == 0) return ;
            
            NSLog(@"desc: %@, voiceId: %@, text: %@",handler.descMsg,  handler.voiceId, handler.text);
            // 记录下voiceId
            strongSelf.voiceId = handler.voiceId;
            
            // 获取结果文本，文本长度
            NSString *resultStr = [DemoUtil filterIllegalChar:handler.text];
            NSInteger resultLen = resultStr.length;
            
            // 获取当前index(curIndex)
            NSString *curStr = [DemoUtil filterIllegalChar:strongSelf.mArr[strongSelf.curIndex]];
            NSInteger curStrLen = curStr.length;
            
            while(resultLen >= curStrLen){
                NSString *compareText = [resultStr substringWithRange:NSMakeRange(0, curStrLen)];
                NSString *comPY = [DemoUtil convertHZ2PY:compareText];
                NSString *curPY = [DemoUtil convertHZ2PY:curStr];
                NSLog(@"comPY : %@", comPY);
                NSLog(@"curPY : %@", curPY);
                NSLog(@"%f", [comPY likePercent:curPY]);
                if([comPY likePercent:curPY] >= 20.0f){
                    // 显示lable
                    if(strongSelf.curIndex >= strongSelf.mArr.count) break;
                    [strongSelf.showArr addObject:strongSelf.mArr[strongSelf.curIndex]];
                    
                    strongSelf.desLabel.text = [strongSelf getResultText];
                    NSLog(@"%@", strongSelf.desLabel.text);
                    strongSelf.curIndex +=1;
                }
                
                if(strongSelf.curIndex >= strongSelf.mArr.count) break;
                resultStr = [resultStr substringFromIndex:curStrLen];
                resultLen = resultStr.length;
                curStr = [DemoUtil filterIllegalChar:strongSelf.mArr[strongSelf.curIndex]];
                curStrLen = curStr.length;
            }
            
            
        } stateChange:^(VoiceState state) {
            NSLog(@"state : %@", @(state));
        }];
    }else{
        [[JFOnlineVoiceRecoTool shareInstance] stop];
    }
}

- (NSMutableArray *)mArr{
    if(!_mArr){
        _mArr = [NSMutableArray arrayWithCapacity:10];
        [_mArr addObject:@"关关雎鸠，"];
        [_mArr addObject:@"在河之洲。"];
        [_mArr addObject:@"窈窕淑女，"];
        [_mArr addObject:@"君子好逑。"];
        [_mArr addObject:@"参差荇菜，"];
        [_mArr addObject:@"左右流之。"];
        [_mArr addObject:@"窈窕淑女，"];
        [_mArr addObject:@"寤寐求之。"];
        [_mArr addObject:@"求之不得，"];
        [_mArr addObject:@"寤寐思服。"];
        [_mArr addObject:@"悠哉悠哉，"];
        [_mArr addObject:@"辗转反侧。"];
        [_mArr addObject:@"参差荇菜，"];
        [_mArr addObject:@"左右采之。"];
        [_mArr addObject:@"窈窕淑女，"];
        [_mArr addObject:@"琴瑟友之。"];
        [_mArr addObject:@"参差荇菜，"];
        [_mArr addObject:@"左右毛之。"];
        [_mArr addObject:@"窈窕淑女，"];
        [_mArr addObject:@"钟鼓乐之。"];
    }
    return _mArr;
}

- (NSMutableArray *)showArr{
    if(!_showArr){
        _showArr = [NSMutableArray arrayWithCapacity:10];;
    }
    return _showArr;
}

- (NSString *)getResultText{
    if(self.showArr.count == 0) return @"";
    
    NSMutableString *mStr = [NSMutableString stringWithString:@""];
    [self.showArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mStr appendString:obj];
    }];
    
    return mStr;
}
@end
