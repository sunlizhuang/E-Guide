//
//  Signin.m
//  EGuide
//
//  Created by zhuangzhuang on 2018/7/14.
//  Copyright © 2018年 applesun. All rights reserved.
//

#import "Signin.h"
#import "TestCode.h"
#import "AFNetworking.h"
@interface Signin ()

@end

@implementation Signin

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)button1:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)ButtonSend:(UIButton *)sender {
    
    //    TestCode *tc = [[TestCode alloc]init];
    //    [self presentViewController:tc animated:YES completion:nil];
    //    NSLog(@"Send Message!");
    //    NSURL* url = [NSURL URLWithString:@"http://106.14.136.121:8080/citicup/designer_get_code.action"];
    //    // 请求
    //    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    //    // 超时
    //    request.timeoutInterval = 5;
    //    // 请求方式
    //    request.HTTPMethod = @"POST";
    //
    //    // 设置请求体和参数
    //    // 创建一个描述订单的JSON数据
    //    NSDictionary* orderInfo = @{@"phonenum":@"18525525028"};
    //    // OC对象转JSON
    //    NSData* json = [NSJSONSerialization dataWithJSONObject:orderInfo options:NSJSONWritingPrettyPrinted error:nil];
    //    // 设置请求头
    //    request.HTTPBody = json;
    //    // 设置请求头类型 (因为发送给服务器的参数类型已经不是普通数据,而是JSON)
    //    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //    NSURLSession* session = [NSURLSession sharedSession];
    //    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    //        // 错误判断
    //        if (data==nil||error)return;
    //        // 解析JSON
    //        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //        NSString* resultErro = dic[@"error"];
    //        if (resultErro)
    //        {
    //            NSLog(@"错误信息:%@",resultErro);
    //        }else
    //        {
    //            NSLog(@"结果信息:%@",dic[@"success"]);
    //        }
    //    }];
    //
    
    
    NSString *string = _phonenumber.text;
    NSDictionary* dic = @{@"phonenum":string};
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    //申明返回的结果是json类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"] ;
    
    //接口地址、、
    NSString *url=@"http://106.14.136.121:8080/CitiCup/designer_get_code.action";
    //发送请求
    [manager POST:url parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSString  *tempstring = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding] ;
        NSData * data = [tempstring dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil] ;
        NSLog(@"dic:%@",dic) ;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        
    }];
    TestCode *testcode = [[TestCode alloc]init];
    [self presentViewController:testcode animated:YES completion:nil];
}

- (IBAction)buttonDelete:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

