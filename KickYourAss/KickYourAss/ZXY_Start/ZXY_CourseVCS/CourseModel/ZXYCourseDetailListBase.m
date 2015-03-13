//
//  ZXYCourseDetailListBase.m
//
//  Created by   on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYCourseDetailListBase.h"
#import "ZXYCourseDetailListData.h"


NSString *const kZXYCourseDetailListBaseResult = @"result";
NSString *const kZXYCourseDetailListBaseData = @"data";


@interface ZXYCourseDetailListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYCourseDetailListBase

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
            self.result = [[self objectOrNilForKey:kZXYCourseDetailListBaseResult fromDictionary:dict] doubleValue];
    NSObject *receivedZXYCourseDetailListData = [dict objectForKey:kZXYCourseDetailListBaseData];
    NSMutableArray *parsedZXYCourseDetailListData = [NSMutableArray array];
    if ([receivedZXYCourseDetailListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZXYCourseDetailListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZXYCourseDetailListData addObject:[ZXYCourseDetailListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZXYCourseDetailListData isKindOfClass:[NSDictionary class]]) {
       [parsedZXYCourseDetailListData addObject:[ZXYCourseDetailListData modelObjectWithDictionary:(NSDictionary *)receivedZXYCourseDetailListData]];
    }

    self.data = [NSArray arrayWithArray:parsedZXYCourseDetailListData];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXYCourseDetailListBaseResult];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kZXYCourseDetailListBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXYCourseDetailListBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXYCourseDetailListBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXYCourseDetailListBaseResult];
    [aCoder encodeObject:_data forKey:kZXYCourseDetailListBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYCourseDetailListBase *copy = [[ZXYCourseDetailListBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
