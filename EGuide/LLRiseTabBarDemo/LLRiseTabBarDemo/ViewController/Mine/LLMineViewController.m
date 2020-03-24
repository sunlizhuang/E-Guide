//
//  LLMineViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLMineViewController.h"
#import "VIP.h"
#import "Gerenxinxi.h"
#import "Zuji.h"
#import "Gerenxinxi.h"
#import "AppDelegate.h"
@interface LLMineViewController (){
    UITableView *_tableView;
}

@end

@implementation LLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    AppDelegate *mydelegate = [[UIApplication sharedApplication]delegate];
    //    _Setusername.text = mydelegate.Ausername;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    _setView.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.scrollEnabled =YES;
    [_setView addSubview:_tableView];
    // Do any additional setup after loading the view from its nib.
}
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0?6:1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(void)tableview:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    if(indexPath.section==0){
        switch (indexPath.row) {
            case 0:
                NSLog(@"0");
                break;
            case 1:
                NSLog(@"1");
                break;
            case 2:
                NSLog(@"1");
                break;
            case 3:
                NSLog(@"1");
                break;
            case 4:
                NSLog(@"1");
                break;
            default:
                break;
                
        }
    }else if(indexPath.section==1){
        NSLog(@"退出");
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * str=@"setView";
    
    UITableViewCell * cell=[_tableView dequeueReusableCellWithIdentifier:str];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.section==0) {
            switch (indexPath.row) {
                case 0:
                    cell.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] ;
                    cell.textLabel.text =@"个人信息";
                    break;
                case 1:
                    cell.textLabel.text =@"我的下载";
                    cell.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] ;
                    break;
                case 2:
                    cell.textLabel.text =@"我的消息";
                    cell.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] ;
                    break;
                case 3:
                    cell.textLabel.text =@"打卡记录";
                    cell.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] ;
                    break;
                    
                case 4:
                    cell.textLabel.text=@"关于我们";
                    cell.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] ;
                    break;
                case 5:
                    cell.textLabel.text=@"设置";
                    cell.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1] ;
                    break;
                default:
                    break;
            }
        }else  {
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.textColor = [UIColor redColor];
            cell.textLabel.text =@"                              退出账户";
            
        }
        
        
        
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)hyzxButton:(UIButton *)sender {
    VIP *vip = [[VIP alloc]init];
    [self presentViewController:vip animated:YES completion:nil];
}

- (IBAction)xzqButton:(UIButton *)sender {
    Zuji *zuji = [[Zuji alloc]init];
    [self presentViewController:zuji animated:YES completion:nil];
}

- (IBAction)changegrxx:(UIButton *)sender {
    Gerenxinxi *grxx = [[Gerenxinxi alloc]init];
    [self presentViewController:grxx animated:YES completion:nil];
}
- (IBAction)shuaxin:(UIButton *)sender {
    AppDelegate * mydelegate = [[UIApplication sharedApplication]delegate];
    _Setusername.text = mydelegate.Ausername;
}
@end
