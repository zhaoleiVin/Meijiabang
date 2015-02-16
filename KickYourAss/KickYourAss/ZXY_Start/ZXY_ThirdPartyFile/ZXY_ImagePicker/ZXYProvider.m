//
//  ZXYProvider.m
//  ArtSearching
//
//  Created by developer on 14-4-18.
//  Copyright (c) 2014年 Duostec. All rights reserved.
//

#import "ZXYProvider.h"
#import "AppDelegate.h"
@implementation ZXYProvider
static ZXYProvider *instance = nil;
+ (ZXYProvider *)sharedInstance
{
    static dispatch_once_t onece;
    dispatch_once(&onece, ^{
        if(instance == nil)
        {
            instance = [[super allocWithZone:NULL] init];
        }
    });
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)mutableCopy
{
    return [[ZXYProvider alloc] init];
}

- (id)copy
{
    return [[ZXYProvider alloc] init];
}

- (id)init
{
    if(instance)
    {
        return instance;
    }
    else
    {
        self = [super init];
        return self;
    }
}


- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    AppDelegate *ad = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return [ad persistentStoreCoordinator];
}

- (NSManagedObjectContext *)childThreadContext
{
    if (childThreadManagedObjectContext != nil)
    {
        return childThreadManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        childThreadManagedObjectContext = [[NSManagedObjectContext alloc] init];
        [childThreadManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    else
    {
        NSLog(@"create child thread managed object context failed!");
    }
    
    [childThreadManagedObjectContext setStalenessInterval:0.0];
    [childThreadManagedObjectContext setMergePolicy:NSOverwriteMergePolicy];
    
    return childThreadManagedObjectContext;
}


#pragma mark - delete
-(BOOL)deleteCoreDataFromDB:(NSString *)stringName
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSArray *deleteObjects = [self readCoreDataFromDB:stringName];
    NSError *error;
    for(int i = 0;i<deleteObjects.count;i++)
    {
        NSManagedObject *deleteObject = [deleteObjects objectAtIndex:i];
        [manageContext deleteObject:deleteObject];
    }
    if([manageContext save:&error])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)deleteCoreDataFromDB:(NSString *)stringName withContent:(NSString *)content byKey:(NSString *)key
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSArray *deleteObjects = [self readCoreDataFromDB:stringName withContent:content andKey:key];
    NSError *error;
    for(int i = 0;i<deleteObjects.count;i++)
    {
        NSManagedObject *deleteObject = [deleteObjects objectAtIndex:i];
        [manageContext deleteObject:deleteObject];
    }
    if([manageContext save:&error])
    {
        return YES;
    }
    else
    {
        return NO;
    }

}

-(BOOL)deleteCoreDataFromDB:(NSString *)stringName Byformat:(NSString *)formatter
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSArray *deleteObjects = [self readCoreDataFromDB:stringName withLike:formatter];
    NSError *error;
    for(int i = 0;i<deleteObjects.count;i++)
    {
        NSManagedObject *deleteObject = [deleteObjects objectAtIndex:i];
        [manageContext deleteObject:deleteObject];
    }
    if([manageContext save:&error])
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma mark - read
- (NSArray *)readCoreDataFromDB:(NSString *)stringName
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:stringName inManagedObjectContext:manageContext ];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError *error;
    NSArray *resultArr = [manageContext executeFetchRequest:request error:&error];
    if(error)
    {
        NSAssert(error, @"readCoreDataFromDB: error");
        return nil;
    }
    else
    {
        return resultArr;
    }
}

-(NSArray *)readCoreDataFromDB:(NSString *)stringName withContent:(NSString *)content andKey:(NSString *)key
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:stringName inManagedObjectContext:manageContext ];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    if(key != nil || content!=nil)
    {
        NSString *stringFormat = [NSString stringWithFormat:@"%@==\'%@\'",key,content];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:stringFormat];
        [request setPredicate:predicate];
    }
    [request setEntity:entity];
    NSError *error;
    NSArray *resultArr = [manageContext executeFetchRequest:request error:&error];
    if(error)
    {
        NSAssert(error, @"readCoreDataFromDB: error");
        return nil;
    }
    else
    {
        return resultArr;
    }

}

-(NSArray *)readCoreDataFromDB:(NSString *)stringName withContentNumber:(NSNumber *)content andKey:(NSString *)key
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:stringName inManagedObjectContext:manageContext ];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    if(key != nil || content!=nil)
    {
        NSString *stringFormat = [NSString stringWithFormat:@"%@==\'%@\'",key,content];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:stringFormat];
        [request setPredicate:predicate];
    }
    [request setEntity:entity];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"sortIndex" ascending:YES];
    NSArray *arr = [NSArray arrayWithObjects:descriptor, nil];
    [request setSortDescriptors:arr];
    NSError *error;
    NSArray *resultArr = [manageContext executeFetchRequest:request error:&error];
    if(error)
    {
        NSAssert(error, @"readCoreDataFromDB: error");
        return nil;
    }
    else
    {
        return resultArr;
    }
    
}


-(NSArray *)readCoreDataFromDB:(NSString *)stringName withContent:(NSString *)content andKey:(NSString *)key orderBy:(NSString *)keyOrder isDes:(BOOL)isDes
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:stringName inManagedObjectContext:manageContext ];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    if(key != nil || content!=nil)
    {
        NSString *stringFormat = [NSString stringWithFormat:@"%@==\'%@\'",key,content];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:stringFormat];
        [request setPredicate:predicate];
    }
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:keyOrder ascending:isDes];
    NSArray *arr = [NSArray arrayWithObjects:descriptor, nil];
    [request setSortDescriptors:arr];
    [request setEntity:entity];
    NSError *error;
    NSArray *resultArr = [manageContext executeFetchRequest:request error:&error];
    if(error)
    {
        NSAssert(error, @"readCoreDataFromDB: error");
        return nil;
    }
    else
    {
        return resultArr;
    }
    
}


-(NSArray *)readCoreDataFromDBNum:(NSString *)stringName withContent:(NSNumber *)content andKey:(NSString *)key
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:stringName inManagedObjectContext:manageContext ];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    if(key != nil || content!=nil)
    {
        NSString *stringFormat = [NSString stringWithFormat:@"%@==%d",key,content.intValue];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:stringFormat];
        [request setPredicate:predicate];
    }
    [request setEntity:entity];
    NSError *error;
    NSArray *resultArr = [manageContext executeFetchRequest:request error:&error];
    if(error)
    {
        NSAssert(error, @"readCoreDataFromDB: error");
        return nil;
    }
    else
    {
        return resultArr;
    }
    
}


- (NSArray *)readCoreDataFromDB:(NSString *)stringName orderByKey:(NSString *)stringKey isDes:(BOOL)isDes
{
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:stringName inManagedObjectContext:manageContext ];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSSortDescriptor *sorDiscriper = [NSSortDescriptor sortDescriptorWithKey:stringKey ascending:isDes];
    NSArray *sortArr = [NSArray arrayWithObjects:sorDiscriper, nil];
    [request setSortDescriptors:sortArr];
    [request setEntity:entity];
    NSError *error;
    NSArray *resultArr = [manageContext executeFetchRequest:request error:&error];
    if(error)
    {
        NSAssert(error, @"readCoreDataFromDB: error");
        return nil;
    }
    else
    {
        return resultArr;
    }

}

-(NSArray *)readCoreDataFromDB:(NSString *)stringName isDes:(BOOL)isDes orderByKey:(id)stringKey, ...
{
    NSMutableArray *paramsArr = [[NSMutableArray alloc] init];
    va_list params;
    va_start(params, stringKey);
    id arg ;
    if(stringKey)
    {
        id startString = stringKey;
        [paramsArr addObject:startString];
        while ((arg = va_arg(params, id))) {
            if(arg)
            {
                [paramsArr addObject:arg];
            }
        }
        va_end(params);
    }
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:stringName inManagedObjectContext:manageContext ];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSMutableArray *sortArr = [[NSMutableArray alloc] init];
    for(int i = 0;i<paramsArr.count;i++)
    {
        NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:[paramsArr objectAtIndex:i] ascending:isDes];
        [sortArr addObject:des];
    }
    [request setSortDescriptors:sortArr];
    [request setEntity:entity];
    NSError *error;
    NSArray *resultArr = [manageContext executeFetchRequest:request error:&error];
    if(error)
    {
        NSAssert(error, @"readCoreDataFromDB: error");
        return nil;
    }
    else
    {
        return resultArr;
    }

}

-(NSArray *)readCoreDataFromDB:(NSString *)dbName formatString:(NSString *)format isDes:(BOOL)isDes orderByKey:(id) stringKey,...
{
    NSMutableArray *paramsArr = [[NSMutableArray alloc] init];
    va_list params;
    va_start(params, stringKey);
    id arg ;
    if(stringKey)
    {
        id startString = stringKey;
        [paramsArr addObject:startString];
        while ((arg = va_arg(params, id))) {
            if(arg)
            {
                [paramsArr addObject:arg];
            }
        }
        va_end(params);
    }
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:dbName inManagedObjectContext:manageContext ];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSMutableArray *sortArr = [[NSMutableArray alloc] init];
    if(format.length > 0)
    {
        NSString *stringFormatter = [NSString stringWithFormat:@"%@",format];
        NSPredicate *predict = [NSPredicate predicateWithFormat:stringFormatter];
        [request setPredicate:predict];
    }
    for(int i = 0;i<paramsArr.count;i++)
    {
        NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:[paramsArr objectAtIndex:i] ascending:isDes];
        [sortArr addObject:des];
    }
    [request setSortDescriptors:sortArr];
    [request setEntity:entity];
    NSError *error;
    NSArray *resultArr = [manageContext executeFetchRequest:request error:&error];
    if(error)
    {
        NSAssert(error, @"readCoreDataFromDB: error");
        return nil;
    }
    else
    {
        return resultArr;
    }

}

- (NSArray *)readCoreDataFromDB:(NSString *)stringName withLike:(NSString *)likeString
{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *manageContext = app.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:stringName inManagedObjectContext:manageContext];
    if(likeString.length > 0)
    {
        NSString *fomat = [NSString stringWithFormat:@"%@",likeString];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:fomat];
        [request setPredicate:predicate];
    }
    [request setEntity:entity];
    
    NSError *error = nil;
    NSArray *arr = [manageContext executeFetchRequest:request error:&error];
    if(error == nil)
    {
        //NSLog(@"%d count is ",arr.count);
        return arr;
    }
    else
    {
         NSLog(@"error readCoredata %@",error);
        return nil;
    }
}

#pragma mark - save
- (BOOL)saveDataToCoreData:(NSDictionary *)dic withDBName:(NSString *)dbName isDelete:(BOOL)isDelete
{
    if(isDelete)
    {
        [self deleteCoreDataFromDB:dbName];
    }
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:dbName inManagedObjectContext:manageContext];
    for(int i = 0;i<dic.allKeys.count;i++)
    {
        
        NSString *onekey = [dic.allKeys objectAtIndex:i];
        if([onekey isEqualToString:@"id"])
        {
            onekey = [NSString stringWithFormat:@"%@%@",dbName.lowercaseString,onekey.uppercaseString];
        }
        if([onekey hasPrefix:@"_"])
        {
            onekey = [NSString stringWithFormat:@"%@%@",dbName.lowercaseString,onekey];
        }
        id currentValue  = [dic objectForKey:onekey];
        
        @try {
            if([currentValue isKindOfClass:[NSNumber class]])
            {
                [object setValue:currentValue forKey:onekey];
            }
            else
            {
                [object setValue:currentValue forKey:onekey];
            }

        }
        @catch (NSException *exception) {
            NSLog(@"没有key");
        }
        @finally {
            continue;
        }
       
    }
    NSError *error = nil;
    [manageContext save:&error];
    if(error == nil)
    {
        return  YES;
    }
    else
    {
        NSLog(@"saveDataToCoreData errpr");
        return  NO;
    }
}

-(BOOL)saveDataToCoreData:(NSDictionary *)dic withDBName:(NSString *)dbName isDelete:(BOOL)isDelete content:(NSString *)content withKey:(NSString *)key
{
    if(isDelete)
    {
        [self deleteCoreDataFromDB:dbName withContent:content byKey:key];
    }
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *manageContext = [app managedObjectContext];
    NSManagedObject *object = [NSEntityDescription insertNewObjectForEntityForName:dbName inManagedObjectContext:manageContext];
    for(int i = 0;i<dic.allKeys.count;i++)
    {
        
        NSString *onekey = [dic.allKeys objectAtIndex:i];
        NSString *value  = [NSString stringWithFormat:@"%@",[dic valueForKey:onekey] ];
        [object setValue:value forKey:onekey];
    }
    NSError *error = nil;
    [manageContext save:&error];
    if(error == nil)
    {
        return  YES;
    }
    else
    {
        NSLog(@"saveDataToCoreData errpr");
        return  NO;
    }

}

- (BOOL)saveDataToCoreDataArr:(NSArray *)arr withDBNam:(NSString *)dbName isDelete:(BOOL)isDelete
{
    if(arr.count == 0)
    {
        return NO;
    }
    if(isDelete)
    {
        [self deleteCoreDataFromDB:dbName];
    }
    for(NSDictionary *dic in arr)
    {
        [self saveDataToCoreData:dic withDBName:dbName isDelete:NO];
    }
    return YES;
}

- (BOOL)saveDataToCoreDataArr:(NSArray *)arr withDBNam:(NSString *)dbName  withDeletePredict:(NSString *)deleteCondition
{
    if(arr.count == 0)
    {
        return NO;
    }
    
    for(NSDictionary *dic in arr)
    {
        if(deleteCondition)
        {
            [self deleteCoreDataFromDB:dbName withContent:[dic objectForKey:deleteCondition] byKey:deleteCondition];
        }
        [self saveDataToCoreData:dic withDBName:dbName isDelete:NO];
    }
    return YES;
}


- (BOOL)saveDataToCoreDataArr:(NSArray *)arr withDBNam:(NSString *)dbName isDelete:(BOOL)isDelete groupByKey:(NSString *)key
{
    if(isDelete)
    {
        [self deleteCoreDataFromDB:dbName];
    }
    for(NSDictionary *dic in arr)
    {
        [self saveDataToCoreData:dic withDBName:dbName isDelete:isDelete content:[dic objectForKey:key] withKey:key];
    }
    return YES;
}


#pragma mark - update
-(BOOL)updateDataFormCoreData:(NSString *)dbName withContent:(id)content andKey:(NSString *)key
{
    NSArray *resultList = [self readCoreDataFromDB:dbName];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *manageContext = [delegate managedObjectContext];
    if(resultList.count == 0)
    {
        NSLog(@"数据库根本就不存在这条数据");
        return NO;
    }
    else
    {
        for(NSManagedObject *object in resultList)
        {
            [object setValue:content forKey:key];
        }
        if([manageContext save:nil])
        {
            return YES;
        }
        else
        {
            NSLog(@"修改数据失败 mark - update");
            return  NO;
        }
    }
}

- (BOOL)updateDataFromCoreData:(NSString *)dbName withContent:(id)content andKey:(NSString *)key whereIS:(NSString *)predictString
{
    NSArray *resultList = [self readCoreDataFromDB:dbName formatString:predictString isDes:YES orderByKey:nil];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *manageContext = [delegate managedObjectContext];
    if(resultList.count == 0)
    {
        NSLog(@"数据库根本就不存在这条数据");
        return NO;
    }
    else
    {
        for(int i = 0;i<resultList.count;i++)
        {
            NSManagedObject *object = [resultList objectAtIndex:i];
            [object setValue:content forKey:key];
        }
        if([manageContext save:nil])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }

}
@end
