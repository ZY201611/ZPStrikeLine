//
//  ViewController.m
//  ZPStrikeLine
//
//  Created by 松 on 2018/3/2.
//  Copyright © 2018年 zcs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //下划线
    NSString *market = @"￥50.50 原价：￥100元";
    
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",market]];
    
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10]range:NSMakeRange(0, 1)];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15]range:NSMakeRange(1, 2)];
    [aString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10]range:NSMakeRange(3, 3)];
    [aString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 7)];
    
    [aString setAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(7,aString.length - 7)];
    
    _label.attributedText = aString;
    
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.frame = CGRectMake(self.view.bounds.size.width / 2 - 50, self.view.bounds.size.height * 2 / 3, 100, 30);
    [btn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(handleAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
}

- (void)handleAction:(UIButton *)sender {
    [self startTime:sender];
}

- (void)startTime:(UIButton *)sender {
    __block int timeout=60; //倒计时时间
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [sender setTitle:[NSString stringWithFormat:@"发送中(%@秒)",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
