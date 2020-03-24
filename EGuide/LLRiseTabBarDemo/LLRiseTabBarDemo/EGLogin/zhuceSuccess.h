//
//  zhuceSuccess.h
//  LLRiseTabBarDemo
//
//  Created by zhuangzhuang on 2018/9/14.
//  Copyright © 2018年 melody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface zhuceSuccess : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *pwdsure;
- (IBAction)Loginnow:(UIButton *)sender;

@end
