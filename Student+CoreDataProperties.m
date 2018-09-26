//
//  Student+CoreDataProperties.m
//  CoreData
//
//  Created by NERC on 2018/9/26.
//  Copyright © 2018年 GaoNing. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic sex;

@end
