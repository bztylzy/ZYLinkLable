//
//  ViewController.m
//  可以点击的label
//
//  Created by lizongyao on 2019/5/25.
//  Copyright © 2019 lizongyao. All rights reserved.
//

#import "ViewController.h"
#import "ZYLinkLabel.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    ZYLinkLabel *lab = [[ZYLinkLabel alloc] initWithFrame:CGRectMake(16, 100, self.view.bounds.size.width - 32, 80) text:@"登录即同意《注册协议》和协议二《协议二》" font:[UIFont systemFontOfSize:15] textAlignment:(NSTextAlignmentLeft) textColor:[UIColor blackColor] linkStrings:@[@"《注册协议》",@"《协议二》"] linkColor:[UIColor redColor]];
    [lab setLinkBlock:^(NSInteger index) {
        NSLog(@"%ld",(long)index);
    }];
    lab.userInteractionEnabled = YES;
    [self.view addSubview:lab];
    // Do any additional setup after loading the view.
}



@end
