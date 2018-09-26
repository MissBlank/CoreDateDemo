//
//  ViewController.m
//  CoreData
//
//  Created by NERC on 2018/9/26.
//  Copyright © 2018年 GaoNing. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Student+CoreDataClass.h"

@interface ViewController ()

@property(nonatomic,strong)AppDelegate * appDelegate;

@end

@implementation ViewController
@synthesize appDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    appDelegate =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [self createBtns];
}

-(void)createBtns{
    NSArray *butsNameArray = @[@"增",@"删",@"改",@"查"];
    int butW = 50;
    for (int i = 0; i < butsNameArray.count; i++) {
        ///btn name
        NSString * btnName = butsNameArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * butW + 10 * i, 200, butW, butW);
        button.backgroundColor = [UIColor blueColor];
        button.layer.cornerRadius = 5;
        button.layer.masksToBounds = YES;
        [button setTitle:btnName forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(clickBtnAction:)
         forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1000 + i;
        [self.view addSubview:button];
    }
    
}

-(void)clickBtnAction:(UIButton *)btn
{
    NSInteger tag = btn.tag -1000;
    switch (tag) {
        case 0:
            [self addAction];       //增
            break;
        case 1:
            [self deleteAction];    //删
            break;
        case 2:
            [self updateAction];    //改
            break;
        case 3:
            [self selectAction];    //查
            break;
        default:
            break;
    }
}


-(void)addAction{
    
    //此代码等价于 类的 alloc init
    Student * stu=[NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:appDelegate.persistentContainer.viewContext];
    
    //赋值
    stu.name  =[NSString stringWithFormat:@"学生%d",arc4random()%10];
    stu.sex = arc4random()%2 == 0 ? YES:NO;
    stu.age = arc4random()%15;
    NSLog(@"增加了一个学生 名字是:%@ 性别是:%@ 年龄是:%d",stu.name,stu.sex == YES ? @"男":@"女",stu.age);
    
    [appDelegate saveContext];
}

-(void)deleteAction{
    
    //获取这个类所有实体
    NSEntityDescription * entity =[NSEntityDescription entityForName:@"Student" inManagedObjectContext:appDelegate.persistentContainer.viewContext];
    
    //创建请求
    NSFetchRequest * request =[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    
    //创建条件 年龄=10 的学生
    NSPredicate * predicate =[NSPredicate predicateWithFormat:@"age > 10"];
    [request setPredicate:predicate];
    
    //获取符合条件的结果
    NSArray * resultArray =[appDelegate.persistentContainer.viewContext executeFetchRequest:request error:nil];
    
    if (resultArray.count >0) {
        for (Student * student in resultArray) {
            //删除实体
            [appDelegate.persistentContainer.viewContext deleteObject:student];
        }
        //保存结果
        [appDelegate saveContext];
        NSLog(@"删除年龄为10的学生完成");
    }else{
        NSLog(@"没有符合条件的结果");
    }

    

}
-(void)updateAction{
    
    //获取这个类所有实体
    NSEntityDescription * entity =[NSEntityDescription entityForName:@"Student" inManagedObjectContext:appDelegate.persistentContainer.viewContext];
    
    //创建请求
    NSFetchRequest * request =[[NSFetchRequest alloc]init];
    [request setEntity:entity];
//
    //创建条件 年龄《10的学生
    NSPredicate * predicate =[NSPredicate predicateWithFormat:@"age < 10"];
    [request setPredicate:predicate];
    
    //获取符合条件的结果
    NSArray * resultArray =[appDelegate.persistentContainer.viewContext executeFetchRequest:request error:nil];
    
    if (resultArray.count > 0) {
        for (Student * stu  in resultArray) {
            
            stu.age = stu.age + 10;
            stu.name = [NSString stringWithFormat:@"%@修",stu.name];
        }
        //保存结果
        [appDelegate saveContext];
         NSLog(@"修改学生信息完成");
        
    }else{
        NSLog(@"没有符合条件的结果");
    }
    
    
}

-(void)selectAction{
    
    //获取这个类的所有实体
    NSEntityDescription * entity =[NSEntityDescription entityForName:@"Student" inManagedObjectContext:appDelegate.persistentContainer.viewContext];
    
    //创建查询请求
    NSFetchRequest * request =[[NSFetchRequest alloc]init];
    [request setEntity:entity];
    
//    //设置查询条件
//    NSPredicate * predicate =[NSPredicate predicateWithFormat:@"age = 10"];
//    [request setPredicate:predicate];
    
    
    //获取符合条件的结果
    NSArray * resultArray =[appDelegate.persistentContainer.viewContext executeFetchRequest:request error:nil];
    ///打印查询结果
    for (Student *stu in resultArray) {
        NSLog(@"查询到一个学生 名字是:%@ 性别是:%@ 年龄是:%hd",stu.name,stu.sex == YES ? @"男":@"女",stu.age);
    }
}












- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
