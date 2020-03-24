//
//  Login.m
//  EGuide
//
//  Created by zhuangzhuang on 2018/7/14.
//  Copyright © 2018年 applesun. All rights reserved.
//

#import "Login.h"
#import "AppDelegate.h"
#import "Signin.h"
@interface Login ()

@end

@implementation Login

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _text2.secureTextEntry = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
// Dispose of any resources that can be recreated.
-(IBAction)button2:(UIButton*)sender{
    Signin *si = [[Signin alloc]init];
    [self presentViewController:si animated:YES completion:nil];
}
- (IBAction)buttonDelet:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)button1:(UIButton *)sender{
    if([_text1.text isEqualToString:@""]||[_text2.text isEqualToString:@""]){
        NSLog(@"请输入信息");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"用户名密码不能为空"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
        [alert show];
    }else{
        AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
        myDelegate.isLogin =YES;
        [self dismissViewControllerAnimated:YES completion:nil];}
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
