//
//  Danmu.h
//  LLRiseTabBarDemo
//
//  Created by zhuangzhuang on 2018/9/16.
//  Copyright © 2018年 melody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>
@interface Danmu : UIViewController
- (IBAction)start:(id)sender;
- (IBAction)stop:(id)sender;
- (IBAction)pause:(id)sender;
- (IBAction)resume:(id)sender;
- (IBAction)send:(id)sender;
- (IBAction)faster:(id)sender;
- (IBAction)slower:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *danmuView;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
- (IBAction)back:(UIButton *)sender;
@property (strong,nonatomic) NSArray *array;
@end
