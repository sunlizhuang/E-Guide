//
//  Gerenxinxi.h
//  LLRiseTabBarDemo
//
//  Created by zhuangzhuang on 2018/7/30.
//  Copyright © 2018年 melody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Gerenxinxi : UIViewController
- (IBAction)back:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *textname;
@property (weak, nonatomic) IBOutlet UITextField *textphone;
@property (weak, nonatomic) IBOutlet UITextField *textemail;
@property (weak, nonatomic) IBOutlet UITextField *textpwd;
- (IBAction)sure:(UIButton *)sender;

@end
