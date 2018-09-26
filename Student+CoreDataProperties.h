//
//  Student+CoreDataProperties.h
//  CoreData
//
//  Created by NERC on 2018/9/26.
//  Copyright © 2018年 GaoNing. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int32_t age;
@property (nonatomic) BOOL sex;

@end

NS_ASSUME_NONNULL_END
