//
//  ZXYCourseUserStatusData.m
//
//  Created by   on 15/3/13
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYCourseUserStatusData.h"


NSString *const kZXYCourseUserStatusDataIsStar = @"isStar";
NSString *const kZXYCourseUserStatusDataIsCollect = @"isCollect";


@interface ZXYCourseUserStatusData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYCourseUserStatusData

@synthesize isStar = _isStar;
@synthesize isCollect = _isCollect;


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
            self.isStar = [self objectOrNilForKey:kZXYCourseUserStatusDataIsStar fromDictionary:dict];
            self.isCollect = [self objectOrNilForKey:kZXYCourseUserStatusDataIsCollect fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.isStar forKey:kZXYCourseUserStatusDataIsStar];
    [mutableDict setValue:self.isCollect forKey:kZXYCourseUserStatusDataIsCollect];

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

    self.isStar = [aDecoder decodeObjectForKey:kZXYCourseUserStatusDataIsStar];
    self.isCollect = [aDecoder decodeObjectForKey:kZXYCourseUserStatusDataIsCollect];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_isStar forKey:kZXYCourseUserStatusDataIsStar];
    [aCoder encodeObject:_isCollect forKey:kZXYCourseUserStatusDataIsCollect];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYCourseUserStatusData *copy = [[ZXYCourseUserStatusData alloc] init];
    
    if (copy) {

        copy.isStar = [self.isStar copyWithZone:zone];
        copy.isCollect = [self.isCollect copyWithZone:zone];
    }
    
    return copy;
}


@end
