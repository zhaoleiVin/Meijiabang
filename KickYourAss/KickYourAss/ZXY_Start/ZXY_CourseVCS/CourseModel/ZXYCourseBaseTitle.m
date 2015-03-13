//
//  ZXYCourseBaseTitle.m
//
//  Created by   on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYCourseBaseTitle.h"
#import "ZXYCourseData.h"


NSString *const kZXYCourseBaseTitleResult = @"result";
NSString *const kZXYCourseBaseTitleData = @"data";


@interface ZXYCourseBaseTitle ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYCourseBaseTitle

@synthesize result = _result;
@synthesize data = _data;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.result = [[self objectOrNilForKey:kZXYCourseBaseTitleResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXYCourseData = [dict objectForKey:kZXYCourseBaseTitleData];
    NSMutableArray *parsedZXYCourseData = [NSMutableArray array];
    if ([receivedZXYCourseData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYCourseData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYCourseData addObject:[ZXYCourseData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYCourseData isKindOfClass:[NSDictionary class]]) {
       [parsedZXYCourseData addObject:[ZXYCourseData modelObjectWithDictionary:(NSDictionary *)receivedZXYCourseData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXYCourseData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXYCourseBaseTitleResult];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXYCourseBaseTitleData];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.result = [aDecoder decodeDoubleForKey:kZXYCourseBaseTitleResult];
    self.data = [aDecoder decodeObjectForKey:kZXYCourseBaseTitleData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXYCourseBaseTitleResult];
    [aCoder encodeObject:_data forKey:kZXYCourseBaseTitleData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYCourseBaseTitle *copy = [[ZXYCourseBaseTitle alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
