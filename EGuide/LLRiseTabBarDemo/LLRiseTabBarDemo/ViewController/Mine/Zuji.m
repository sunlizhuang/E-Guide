//
//  Zuji.m
//  LLRiseTabBarDemo
//
//  Created by zhuangzhuang on 2018/7/30.
//  Copyright © 2018年 melody. All rights reserved.
//

#import "Zuji.h"

@interface Zuji ()

@end

@implementation Zuji

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

- (IBAction)zujiButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
