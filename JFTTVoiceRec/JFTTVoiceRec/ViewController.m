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

static CGFloat weight = 50.0f;
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (copy, nonatomic) NSString *voiceId;      // 消息id
@property (copy, nonatomic) NSString *resultPer;    // 当前时间片的结果
@property (assign, nonatomic) NSInteger curIndex;   // 数组当前的index
@property (nonatomic, strong) NSMutableArray *mArr; // 文章数组
@property (nonatomic, strong) NSMutableArray *showArr; // 需要显示的临时数组
@property (nonatomic, assign) NSInteger tipCount;
@property (nonatomic, assign) BOOL tipFlag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat percent = [@"cen ci xing cai" likePercent:@"qing chi xiang cai"];
    NSLog(@"%f", percent);
    
//    NSString *text = @"关关雎鸠，在河之洲，窈窕淑女，君子好逑，哈哈";
//    self.desLabel.attributedText = [DemoUtil hightLightForString:text location:NSMakeRange(text.length - 2, 2)];
//    NSLog(@"%@", self.desLabel.text);
}

- (IBAction)startBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if(sender.selected){
        
        self.resultPer = @"";
        self.desLabel.text = @"";
        [self.showArr removeAllObjects];
        self.curIndex = 0;
        self.tipCount = 0;
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
            
            // 获取当前index(curIndex)，
            // 过滤文章当中的标点符号，以便更加准确的对比
            NSString *curStr = [DemoUtil filterIllegalChar:strongSelf.mArr[strongSelf.curIndex]];
            NSInteger curStrLen = curStr.length;
            
            while(resultLen >= curStrLen){
                NSString *compareText = [resultStr substringWithRange:NSMakeRange(0, curStrLen)];
                // 由于腾讯云返回的数据不准确，因而采取将汉字转换成拼音的形式进行对比
                NSString *comPY = [DemoUtil convertHZ2PY:compareText];
                NSString *curPY = [DemoUtil convertHZ2PY:curStr];
                NSLog(@"comPY : %@", comPY);
                NSLog(@"curPY : %@", curPY);
                NSLog(@"%f", [comPY likePercent:curPY]);
                
                // 如果是提示状态则删除最后一条，回归状态
                if(strongSelf.tipFlag){
                    [strongSelf.showArr removeLastObject];
                    strongSelf.tipFlag = NO;
                }
                
                // 由于返回数据不太准确，就算是拼音对比也不准确， 所以如果相似度超过了权重则默认正确
                if([comPY likePercent:curPY] >= weight){
                    
                    if(strongSelf.curIndex >= strongSelf.mArr.count) break;
                    // 正确则增加到显示数组里面
                    [strongSelf.showArr addObject:strongSelf.mArr[strongSelf.curIndex]];
                    
                    // 通过显示数组转换成字符串，显示到label上
                    strongSelf.desLabel.text = [strongSelf getResultText];
                    NSLog(@"%@", strongSelf.desLabel.text);
                    // 每次正确，索引值+1
                    strongSelf.curIndex +=1;
                    
                    // 提示次数， 提示flag
                    strongSelf.tipCount = 0;
                    strongSelf.tipFlag = NO;
                }else{
                    // 错误一次 提示次数++
                    strongSelf.tipCount ++;
                }
                
                // 如果提示次数>=3，则增加提示文本
                if(strongSelf.tipCount >= 3){
                    
                    if(strongSelf.curIndex >= strongSelf.mArr.count) break;
                    
                    NSString *nextStr = [DemoUtil filterIllegalChar:strongSelf.mArr[strongSelf.curIndex]];
                    NSInteger to = nextStr.length>2?2:1;
                    NSString *tip = nextStr.length > 0? [nextStr substringToIndex:to]:@"";
                    // 从下一条数据中增加1-2个字符到显示数组中，注意下次将这条数据从显示数组剔除
                    [strongSelf.showArr addObject:tip];
                    
                    // 富文本，将提示设为灰色
                    NSString *text = [strongSelf getResultText];
                    NSRange range = NSMakeRange(text.length - to, to);
                    strongSelf.desLabel.attributedText = [DemoUtil hightLightForString:text location:range];
                    strongSelf.tipFlag = YES;
                    break;
                }
                
                if(strongSelf.curIndex >= strongSelf.mArr.count) break;
                
                // 递归，为了防止一次性录入太多的句子
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
