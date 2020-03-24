//
//  Gerenxinxi.m
//  LLRiseTabBarDemo
//
//  Created by zhuangzhuang on 2018/7/30.
//  Copyright © 2018年 melody. All rights reserved.
//

#import "Gerenxinxi.h"
#import "AppDelegate.h"
@interface Gerenxinxi ()

@end

@implementation Gerenxinxi

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)sure:(UIButton *)sender {
    if([_textname.text isEqualToString:@""]){}else{
        AppDelegate *mydelegate = [[UIApplication sharedApplication]delegate];
        mydelegate.Ausername = _textname.text;
        [self dismissViewControllerAnimated:YES completion:nil];}
}
@end
