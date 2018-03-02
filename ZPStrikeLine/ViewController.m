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
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
