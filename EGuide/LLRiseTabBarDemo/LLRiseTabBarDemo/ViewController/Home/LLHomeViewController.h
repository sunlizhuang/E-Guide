//
//  LLHomeViewController.h
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLBaseViewController.h"

@interface LLHomeViewController : LLBaseViewController
- (IBAction)button1:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webview;
- (IBAction)loginshow:(UIButton *)sender;
- (IBAction)button2:(UIButton *)sender;
- (IBAction)button3:(UIButton *)sender;
- (IBAction)button4:(UIButton *)sender;
- (IBAction)button5:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *Webview;
@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (weak, nonatomic) IBOutlet UIView *searchview;

@end
