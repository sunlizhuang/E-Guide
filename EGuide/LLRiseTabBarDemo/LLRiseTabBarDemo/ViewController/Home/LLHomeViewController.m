//
//  LLHomeViewController.m
//  LLRiseTabBarDemo
//
//  Created by Meilbn on 10/18/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "LLHomeViewController.h"
#import "LLTabBarItem.h"
#import "LLTabBar.h"
#import "MLSearchBar.h"
#import "Login.h"
#import "AppDelegate.h"

@interface LLHomeViewController ()

@end

@implementation LLHomeViewController
-(void)viewDidAppear:(BOOL)animated{
    AppDelegate *myDelegate = [[UIApplication sharedApplication]delegate];
    if(myDelegate.isLogin == NO){
    Login *login = [[Login alloc]init];
    [self presentViewController:login animated:YES completion:nil];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    MLSearchBar *searchBar = [[MLSearchBar alloc]initWithFrame:CGRectMake(0, 0, _searchview.frame.size.width, _searchview.frame.size.height) boardColor:[UIColor lightGrayColor] placeholderString:nil];
    // searchBar.boardLineWidth = 3.0;
    [_searchview addSubview:searchBar];
//    NSString *a =@"https://map.baidu.com/mobile/webapp/index/index";
//     NSString *b = [a stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:@"https://map.baidu.com/mobile/webapp/index/index"];
   
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [self.webview loadRequest:request];

    // Do any additional setup after loading the view from its nib.
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

- (IBAction)loginshow:(UIButton *)sender {
}

- (IBAction)button2:(UIButton *)sender {
    
    NSString *a =@"https://map.baidu.com/mobile/webapp/search/search/foo=bar&qt=s&wd=景点&c=167&searchFlag=sort&da_src=indexnearbypg.nearby/center_name=杭州市/?fromhash=1#search/search/foo=bar&qt=s&wd=景点&c=167&searchFlag=sort&da_src=indexnearbypg.nearby&uid=05b4962e48bd2caf40afe6c2&industry=cater&qid=2646235228883474284/showall=1&pos=0&da_ref=listclk&da_qrtp=36&da_adtp=&da_log=&da_adquery=景点&da_adtitle=影&da_adindus=景点%3B外国餐厅&detail_from=list&center_name=杭州市";
    NSString *b = [a stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:b];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    CGRect frame = self.webview.frame;
    frame.origin.y = 220;
    self.webview.frame = frame;
    [self.webview loadRequest:request];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (IBAction)button3:(UIButton *)sender {
//    NSString *a =@"https://map.baidu.com/mobile/webapp/search/search/foo=bar&qt=s&wd=美食&c=167&searchFlag=sort&da_src=indexnearbypg.nearby/center_name=杭州市/?fromhash=1#search/search/foo=bar&qt=s&wd=美食&c=167&searchFlag=sort&da_src=indexnearbypg.nearby&uid=05b4962e48bd2caf40afe6c2&industry=cater&qid=2646235228883474284/showall=1&pos=0&da_ref=listclk&da_qrtp=36&da_adtp=&da_log=&da_adquery=美食&da_adtitle=汉巴味德(百年港湾店)&da_adindus=美食%3B外国餐厅&detail_from=list&center_name=杭州市";
    NSString *a =@"https://map.baidu.com/mobile/webapp/place/caterzt/uid=99aea41ed35b702d97ec84f0&foo=bar&qt=ninf&wd=%E7%BE%8E%E9%A3%9F&c=179&searchFlag=sort&da_src=indexnearbypg.nearby&da_src2=caterztPg&=undefined//?fromhash=1";
    NSString *b = [a stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:b];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    CGRect frame = self.webview.frame;
    frame.origin.y = 220;
    self.webview.frame = frame;
    [self.webview loadRequest:request];
}

- (IBAction)button4:(UIButton *)sender {
    
    NSString *a =@"https://map.baidu.com/mobile/webapp/search/search/foo=bar&qt=s&wd=电影&c=167&searchFlag=sort&da_src=indexnearbypg.nearby/center_name=杭州市/?fromhash=1#search/search/foo=bar&qt=s&wd=电影&c=167&searchFlag=sort&da_src=indexnearbypg.nearby&uid=05b4962e48bd2caf40afe6c2&industry=cater&qid=2646235228883474284/showall=1&pos=0&da_ref=listclk&da_qrtp=36&da_adtp=&da_log=&da_adquery=电影&da_adtitle=影&da_adindus=电影%3B外国餐厅&detail_from=list&center_name=杭州市";
    NSString *b = [a stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:b];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    CGRect frame = self.webview.frame;
    frame.origin.y = 220;
    self.webview.frame = frame;
    [self.webview loadRequest:request];
}

- (IBAction)button5:(UIButton *)sender {
    NSString *a =@"https://map.baidu.com/mobile/webapp/search/search/foo=bar&qt=s&wd=超市&c=167&searchFlag=sort&da_src=indexnearbypg.nearby/center_name=杭州市/?fromhash=1#search/search/foo=bar&qt=s&wd=超市&c=167&searchFlag=sort&da_src=indexnearbypg.nearby&uid=05b4962e48bd2caf40afe6c2&industry=cater&qid=2646235228883474284/showall=1&pos=0&da_ref=listclk&da_qrtp=36&da_adtp=&da_log=&da_adquery=超市&da_adtitle=沃尔玛&da_adindus=超市%3B外国餐厅&detail_from=list&center_name=杭州市";
    NSString *b = [a stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:b];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    CGRect frame = self.webview.frame;
    frame.origin.y = 220;
    self.webview.frame = frame;
    [self.webview loadRequest:request];
}
- (IBAction)button1:(UIButton *)sender {
    NSURL *url = [NSURL URLWithString:@"https://map.baidu.com/mobile/webapp/index/index/?itj=45&wtj=wi&$pubpathUnescape#search/search/foo=bar&qt=s&wd=%E6%99%AF%E7%82%B9&c=218&searchFlag=sort&da_src=indexnearbypg.nearby/center_name=%E6%AD%A6%E6%B1%89%E5%B8%82"];
    // 3.创建Request
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    // 4.加载网页
    [self.webview loadRequest:request];
    CGRect frame = self.webview.frame;
    frame.origin.y = 170;
    self.webview.frame = frame;
}
@end
