//
//  LLMineViewController.h
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLBaseViewController.h"

@interface LLMineViewController : LLBaseViewController<UITableViewDataSource,UITabBarDelegate>
- (IBAction)shuaxin:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *setView;
- (IBAction)hyzxButton:(UIButton *)sender;
- (IBAction)xzqButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *Setusername;
- (IBAction)changegrxx:(UIButton *)sender;

@end
