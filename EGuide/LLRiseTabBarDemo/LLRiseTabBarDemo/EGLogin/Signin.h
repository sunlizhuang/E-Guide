//
//  Signin.h
//  EGuide
//
//  Created by zhuangzhuang on 2018/7/14.
//  Copyright © 2018年 applesun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Signin : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *text1;
- (IBAction)button1:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *buttonMessage;
- (IBAction)ButtonSend:(UIButton *)sender;
- (IBAction)buttonDelete:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *phonenumber;
@end
