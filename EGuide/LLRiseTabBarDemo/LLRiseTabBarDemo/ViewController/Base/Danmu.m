//
//  Danmu.m
//  LLRiseTabBarDemo
//
//  Created by zhuangzhuang on 2018/9/16.
//  Copyright © 2018年 melody. All rights reserved.
//

#import "Danmu.h"
#import "BarrageHeader.h"
#import "NSSafeObject.h"
#import "BarrageSpriteUtility.h"
#import "UIImage+Barrage.h"
@interface Danmu ()<ARSCNViewDelegate>
{
    BarrageRenderer * _renderer;
    NSTimer * _timer;
    NSInteger _index;
}
@property (nonatomic,strong) IBOutlet ARSCNView *sceneView;

@end

@implementation Danmu

- (void)viewDidLoad
{
    [super viewDidLoad];
    _index = 0;
    _renderer = [[BarrageRenderer alloc]init];
    [_renderer setSpeed:1.0f];
    [_danmuView addSubview:_renderer.view];
    _danmuView.backgroundColor = [UIColor clearColor];
    _renderer.view.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.sceneView.delegate = self;
    self.sceneView.showsStatistics = YES;
    
    // [self.view sendSubviewToBack:_renderer.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];
    [self.sceneView.session runWithConfiguration:configuration];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}
- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _array = [NSArray arrayWithObjects:@"我来测试一下",@"易导游功能不错",@"比赛专用",@"浙大海宁校区挺漂亮的！",@"到此一游！！",@"发来贺电",@"还好",@"我来测试下弹幕功能",@"前方高能预警",@"留言墙测试",nil];
    NSSafeObject * safeObj = [[NSSafeObject alloc]initWithObject:self withSelector:@selector(autoSendBarrage)];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:safeObj selector:@selector(excute) userInfo:nil repeats:YES];
}

- (void)viewWillLayoutSubviews
{
    [_renderer.view setNeedsLayout];
}

- (void)dealloc
{
    [_renderer stop];
}

#pragma mark - Action
- (IBAction)start:(id)sender
{
    [_renderer start];
}
- (IBAction)stop:(id)sender
{
    [_renderer stop];
}
- (IBAction)pause:(id)sender
{
    [_renderer pause];
}
- (IBAction)resume:(id)sender
{
    [_renderer start];
}
- (IBAction)send:(id)sender
{
    [self manualSendBarrage];
}
- (IBAction)faster:(id)sender
{
    CGFloat speed = _renderer.speed + 0.5;
    if (speed >= 10) {
        speed = 10.0f;
    }
    _renderer.speed = speed;
}
- (IBAction)slower:(id)sender
{
    CGFloat speed = _renderer.speed - 0.5;
    if (speed <= 0.5f) {
        speed = 0.5;
    }
    _renderer.speed = speed;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)autoSendBarrage
{
    [_renderer receive:[self floatTextSpriteDescriptorWithDirection:2]];
    [_renderer receive:[self walkTextSpriteDescriptorWithDirection:1]];
    //  [_renderer receive:[self floatImageSpriteDescriptorWithDirection:1]];
    //   [_renderer receive:[self walkImageSpriteDescriptorWithDirection:2]];
    //  [_renderer receive:[self defaultSpriteDescriptor]];
}

- (void)manualSendBarrage
{
    [_array arrayByAddingObject:[NSString stringWithFormat:@"%@",_textfield.text]];
    
    for (int i = 0;i<_array.count;i++){
        NSLog(@"%@",[_array objectAtIndex:i]);
    }
    
    [_renderer start];
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = @"BarrageWalkTextSprite";
    [descriptor.params setObject:[NSString stringWithFormat:_textfield.text,(long)_index++] forKey:@"text"];
    [descriptor.params setObject:@(20.0f) forKey:@"fontSize"];
    [descriptor.params setObject:[UIColor whiteColor] forKey:@"textColor"];
    [descriptor.params setObject:[UIColor whiteColor] forKey:@"borderColor"];
    [descriptor.params setObject:[UIColor clearColor] forKey:@"backgroundColor"];
    [descriptor.params setObject:@(1) forKey:@"borderWidth"];
    [descriptor.params setObject:@(100 * (double)random()/RAND_MAX+50) forKey:@"speed"];
    [descriptor.params setObject:@(1) forKey:@"direction"];
    [_renderer receive:descriptor];
}

//- (BarrageDescriptor *)defaultSpriteDescriptor
//{
//    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
//    descriptor.spriteName = @"BarrageSprite";
//    [descriptor.params setObject:[UIColor blueColor] forKey:@"backgroundColor"];
//    [descriptor.params setObject:@(100 * (double)random()/RAND_MAX+50) forKey:@"speed"];
//    [descriptor.params setObject:[NSValue valueWithCGSize:CGSizeMake(50, 30)] forKey:@"mandatorySize"];
//    return descriptor;
//}

/// 生成精灵描述
- (BarrageDescriptor *)walkTextSpriteDescriptorWithDirection:(NSInteger)direction
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = @"BarrageWalkTextSprite";
    [descriptor.params setObject:[NSString stringWithFormat:[NSString stringWithFormat:[_array objectAtIndex:(_index)%(_array.count)]],(long)_index++] forKey:@"text"];
    [descriptor.params setObject:@(20.0f) forKey:@"fontSize"];
    [descriptor.params setObject:[UIColor whiteColor] forKey:@"textColor"];
    [descriptor.params setObject:@(100 * (double)random()/RAND_MAX+100) forKey:@"speed"];
    [descriptor.params setObject:@(direction) forKey:@"direction"];
    return descriptor;
}

/// 生成精灵描述
- (BarrageDescriptor *)floatTextSpriteDescriptorWithDirection:(NSInteger)direction
{
    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
    descriptor.spriteName = @"BarrageFloatTextSprite";
    [descriptor.params setObject:[NSString stringWithFormat:@"",(long)_index++] forKey:@"text"];
    [descriptor.params setObject:@(12.0f) forKey:@"fontSize"];
    [descriptor.params setObject:@(1) forKey:@"borderWidth"];
    [descriptor.params setObject:[UIColor purpleColor] forKey:@"textColor"];
    [descriptor.params setObject:@(100 * (double)random()/RAND_MAX+50) forKey:@"speed"];
    [descriptor.params setObject:@(3) forKey:@"duration"];
    [descriptor.params setObject:@(direction) forKey:@"direction"];
    return descriptor;
}

/// 生成精灵描述
//- (BarrageDescriptor *)walkImageSpriteDescriptorWithDirection:(NSInteger)direction
//{
//    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
//    descriptor.spriteName = @"BarrageWalkImageSprite";
//    [descriptor.params setObject:[[UIImage imageNamed:@"avatar"]barrageImageScaleToSize:CGSizeMake(40, 20.0f)] forKey:@"image"];
//    [descriptor.params setObject:@(1) forKey:@"borderWidth"];
//    [descriptor.params setObject:@(100 * (double)random()/RAND_MAX+50) forKey:@"speed"];
//    [descriptor.params setObject:@(3) forKey:@"duration"];
//    [descriptor.params setObject:@(direction) forKey:@"direction"];
//    return descriptor;
//}

///// 生成精灵描述
//- (BarrageDescriptor *)floatImageSpriteDescriptorWithDirection:(NSInteger)direction
//{
//    BarrageDescriptor * descriptor = [[BarrageDescriptor alloc]init];
//    descriptor.spriteName = @"BarrageFloatImageSprite";
//    [descriptor.params setObject:[[UIImage imageNamed:@"avatar"]barrageImageScaleToSize:CGSizeMake(40, 20.0f)] forKey:@"image"];
//    [descriptor.params setObject:@(1) forKey:@"borderWidth"];
//    [descriptor.params setObject:@(100 * (double)random()/RAND_MAX+50) forKey:@"speed"];
//    [descriptor.params setObject:@(3) forKey:@"duration"];
//    [descriptor.params setObject:@(direction) forKey:@"direction"];
//    return descriptor;
//}

- (IBAction)back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
