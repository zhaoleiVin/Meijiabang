//
//  ZXYCourseUserStatusBase.m
//
//  Created by   on 15/3/13
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYCourseUserStatusBase.h"
#import "ZXYCourseUserStatusData.h"


NSString *const kZXYCourseUserStatusBaseResult = @"result";
NSString *const kZXYCourseUserStatusBaseData = @"data";


@interface ZXYCourseUserStatusBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYCourseUserStatusBase

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
            self.result = [[self objectOrNilForKey:kZXYCourseUserStatusBaseResult fromDictionary:dict] doubleValue];
            self.data = [ZXYCourseUserStatusData modelObjectWithDictionary:[dict objectForKey:kZXYCourseUserStatusBaseData]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.result] forKey:kZXYCourseUserStatusBaseResult];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kZXYCourseUserStatusBaseData];

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

    self.result = [aDecoder decodeDoubleForKey:kZXYCourseUserStatusBaseResult];
    self.data = [aDecoder decodeObjectForKey:kZXYCourseUserStatusBaseData];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_result forKey:kZXYCourseUserStatusBaseResult];
    [aCoder encodeObject:_data forKey:kZXYCourseUserStatusBaseData];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYCourseUserStatusBase *copy = [[ZXYCourseUserStatusBase alloc] init];
    
    if (copy) {

        copy.result = self.result;
        copy.data = [self.data copyWithZone:zone];
    }
    
    return copy;
}


@end
