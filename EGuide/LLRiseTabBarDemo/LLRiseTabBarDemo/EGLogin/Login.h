//
//  Login.h
//  EGuide
//
//  Created by zhuangzhuang on 2018/7/14.
//  Copyright © 2018年 applesun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *text1;
@property (weak, nonatomic) IBOutlet UITextField *text2;
- (IBAction)button1:(UIButton *)sender;
- (IBAction)button2:(UIButton *)sender;
- (IBAction)buttonDelet:(UIButton *)sender;
- (IBAction)buttonHelp:(UIButton *)sender;

@end
