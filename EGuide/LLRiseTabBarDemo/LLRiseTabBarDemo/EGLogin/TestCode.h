//
//  TestCode.h
//  LLRiseTabBarDemo
//
//  Created by zhuangzhuang on 2018/7/28.
//  Copyright © 2018年 melody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestCode : UIViewController
- (IBAction)back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *sure;
@property (weak, nonatomic) IBOutlet UITextField *yanzhengma;
- (IBAction)sureButton:(UIButton *)sender;

@end
