//
//  LLSameCityViewController.h
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLBaseViewController.h"
#import <MapKit/MapKit.h>

@interface LLSameCityViewController : LLBaseViewController
@property (weak, nonatomic) IBOutlet UIView *work;
- (IBAction)canting:(UIButton *)sender;
- (IBAction)zhusu:(UIButton *)sender;
- (IBAction)gouwu:(UIButton *)sender;
- (IBAction)cesuo:(UIButton *)sender;
- (IBAction)tingchewei:(UIButton *)sender;
- (IBAction)chongdingwei:(UIButton *)sender;
- (IBAction)LIuyan:(UIButton *)sender;


@end
