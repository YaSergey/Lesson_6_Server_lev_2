//
//  ViewController.m
//  Lesson_6_Server_lev_2
//
//  Created by Sergey Yasnetsky on 27.05.15.
//  Copyright (c) 2015 Sergey Yasnetsky. All rights reserved.
//

#import "ViewController.h"
#import "Operation.h"
#import <AFNetworking/AFNetworking.h>


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*  Operation * oper = [Operation new];
    
    NSOperationQueue * q = [[NSOperationQueue alloc] init];
    
    [q addOperation:oper];
    */

   /* NSArray * array1  = [[NSArray alloc] initWithObjects:@"qwe",@"qwe1",@"qwe2",@"qwe3",@"qwe4", nil];
    
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"string1", @"STR1",
                           @"string2", @"STR2",
                           array1, @"array1", nil];
    
    NSArray * array2  = [[NSArray alloc] initWithObjects:dict, nil];

    NSDictionary * dict2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"string1", @"STR1",
                           @"string2", @"STR2",
                           array2, @"array2", nil];

    
    NSArray * array3  = [[NSArray alloc] initWithObjects:dict2, nil];

    NSLog(@"array3 %@", array3);
    
    [self firstMethod];
    
    */
    
//    [self getJSON];
    
    [self getDataFromWall];

}


- (void) getDataFromWall {
    
    NSURL * url = [NSURL URLWithString:@"https://api.vk.com/method/"];
    
    AFHTTPRequestOperationManager * requestManagerVK = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
    NSDictionary * parametrs = [[NSDictionary alloc] initWithObjectsAndKeys:
           @"-43818640", @"owner_id",
           @10, @"count",
            @3, @"offset",
            @"onwer", @"filter",
                                nil];
    
    
    [requestManagerVK GET:@"wall.get" parameters:parametrs success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            
            NSLog(@"NSDictionary  TEST %@", responseObject);
            
        }
        
        else if ([responseObject isKindOfClass:[NSArray class]]) {
            
            NSLog(@" NSArray TEST responseObject %@", responseObject);
        }
        
        else {
            
            NSLog(@"Unkwoun class");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        NSLog(@"error %@", error);
    }];

}


    - (void) firstMethod {
        // данные клиента
        SEL selector = @selector(result: STR2:);
        
        NSString * stringSelector = NSStringFromSelector(selector);
        NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
        @"string1", @"STR1",
        @"string2", @"STR2",
        stringSelector, @"selector", nil];
        
        [self method: dict];
        
}

- (void) getJSON {

  /*  NSArray * array1  = [[NSArray alloc] initWithObjects:@"qwe",@"qwe1",@"qwe2",@"qwe3",@"qwe4", nil];
    
    NSDictionary * dict = [[NSDictionary alloc] initWithObjectsAndKeys:
                           @"string1", @"STR1",
                           @"string2", @"STR2",
                           array1, @"array1", nil];
    
    NSArray * array2  = [[NSArray alloc] initWithObjects:dict, nil];
    
    NSDictionary * dict2 = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"string1", @"STR1",
                            @"string2", @"STR2",
                            array2, @"array2", nil];
    
    
    NSArray * array3  = [[NSArray alloc] initWithObjects:dict2, nil];
  
    NSDictionary * dict3 = [[NSDictionary alloc] initWithObjectsAndKeys:
                            @"string1", @"STR1",
                            @"string2", @"STR2",
                            array3, @"array2", nil];

    
    
    NSLog(@"array3 %@", array3);
    
    

    NSError * error = nil;
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict3 options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil) {
 
        NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"jsonString%@", jsonString);
    }
    
 */
    
    // присваиваем переменной значение ссылки как строки
    NSString * urlString = @"http://echo.jsontest.com/key/value/one/two";
    
    // присваиваем переменной значение ссыллки как ссылки, расшифоровываем строку
    NSURL * url = [NSURL URLWithString:urlString]; //
    
    NSMutableURLRequest * req = [[NSMutableURLRequest alloc] initWithURL:url];

    NSOperationQueue * q = [[NSOperationQueue alloc] init];

//    [req  setHTTPBody: jsonData];
//    [req  setHTTPMethod:@"GET"];
    
    // блок передачи запроса по ссылке
    [NSURLConnection sendAsynchronousRequest:req queue:q completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if (jsonObject != nil) {
            
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                
                NSLog(@"NSDictionary  TEST %@", jsonObject);
    
            }
            
            else if ([jsonObject isKindOfClass:[NSArray class]]) {
                
                NSLog(@" NSArray TEST jsonObject %@", jsonObject);
            }
            
            else {
                
                NSLog(@"Unkwoun class");
            }
        }
        
        
    }];
    
    

    }



- (void) method: (NSDictionary *) dict {

    // сервер
    
    SEL selector = NSSelectorFromString([dict valueForKey: @"selector"]);
    [self performSelector:selector withObject:[dict valueForKey:@"STR1"] withObject: [dict valueForKey:@"STR2"]];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) result: (NSString *) string1 STR2: (NSString *) string2 {
    
    // результат серверной обработки
    
    NSLog(@"%@", [NSString stringWithFormat:@"%@ + %@", string1, string2]);


}

@end
