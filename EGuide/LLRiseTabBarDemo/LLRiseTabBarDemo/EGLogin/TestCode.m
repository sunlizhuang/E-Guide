//
//  TestCode.m
//  LLRiseTabBarDemo
//
//  Created by zhuangzhuang on 2018/7/28.
//  Copyright © 2018年 melody. All rights reserved.
//

#import "TestCode.h"
#import "zhuceSuccess.h"
@interface TestCode ()

@end

@implementation TestCode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sureButton:(UIButton *)sender {
    
    zhuceSuccess *zs = [[zhuceSuccess alloc]init];
    [self presentViewController:zs animated:YES completion:nil];
}
@end

