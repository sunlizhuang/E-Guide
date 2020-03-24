//
//  zhuceSuccess.m
//  LLRiseTabBarDemo
//
//  Created by zhuangzhuang on 2018/9/14.
//  Copyright © 2018年 melody. All rights reserved.
//

#import "zhuceSuccess.h"
#import "Login.h"
#import "AppDelegate.h"
@interface zhuceSuccess ()

@end

@implementation zhuceSuccess

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _pwd.secureTextEntry = YES;
    _pwdsure.secureTextEntry = YES;
    AppDelegate *mydelegate = [[UIApplication sharedApplication]delegate];
    mydelegate.Ausername = _username.text;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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

- (IBAction)Loginnow:(UIButton *)sender {
    
    UIViewController *vc =self.presentingViewController;
    //ReadBookController要跳转的界面
    while (![vc isKindOfClass:[Login class]]) {
        vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}
@end
