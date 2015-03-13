//
//  ZXYCourseDetailListData.m
//
//  Created by   on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "ZXYCourseDetailListData.h"


NSString *const kZXYCourseDetailListDataImgPath = @"img_path";
NSString *const kZXYCourseDetailListDataId = @"id";
NSString *const kZXYCourseDetailListDataTitle = @"title";
NSString *const kZXYCourseDetailListDataStarNum = @"star_num";
NSString *const kZXYCourseDetailListDataDesc = @"desc";
NSString *const kZXYCourseDetailListDataCollectNum = @"collect_num";


@interface ZXYCourseDetailListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZXYCourseDetailListData

@synthesize imgPath = _imgPath;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize title = _title;
@synthesize starNum = _starNum;
@synthesize desc = _desc;
@synthesize collectNum = _collectNum;


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
            self.imgPath = [self objectOrNilForKey:kZXYCourseDetailListDataImgPath fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kZXYCourseDetailListDataId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kZXYCourseDetailListDataTitle fromDictionary:dict];
            self.starNum = [self objectOrNilForKey:kZXYCourseDetailListDataStarNum fromDictionary:dict];
            self.desc = [self objectOrNilForKey:kZXYCourseDetailListDataDesc fromDictionary:dict];
            self.collectNum = [self objectOrNilForKey:kZXYCourseDetailListDataCollectNum fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imgPath forKey:kZXYCourseDetailListDataImgPath];
    [mutableDict setValue:self.dataIdentifier forKey:kZXYCourseDetailListDataId];
    [mutableDict setValue:self.title forKey:kZXYCourseDetailListDataTitle];
    [mutableDict setValue:self.starNum forKey:kZXYCourseDetailListDataStarNum];
    [mutableDict setValue:self.desc forKey:kZXYCourseDetailListDataDesc];
    [mutableDict setValue:self.collectNum forKey:kZXYCourseDetailListDataCollectNum];

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

    self.imgPath = [aDecoder decodeObjectForKey:kZXYCourseDetailListDataImgPath];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kZXYCourseDetailListDataId];
    self.title = [aDecoder decodeObjectForKey:kZXYCourseDetailListDataTitle];
    self.starNum = [aDecoder decodeObjectForKey:kZXYCourseDetailListDataStarNum];
    self.desc = [aDecoder decodeObjectForKey:kZXYCourseDetailListDataDesc];
    self.collectNum = [aDecoder decodeObjectForKey:kZXYCourseDetailListDataCollectNum];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imgPath forKey:kZXYCourseDetailListDataImgPath];
    [aCoder encodeObject:_dataIdentifier forKey:kZXYCourseDetailListDataId];
    [aCoder encodeObject:_title forKey:kZXYCourseDetailListDataTitle];
    [aCoder encodeObject:_starNum forKey:kZXYCourseDetailListDataStarNum];
    [aCoder encodeObject:_desc forKey:kZXYCourseDetailListDataDesc];
    [aCoder encodeObject:_collectNum forKey:kZXYCourseDetailListDataCollectNum];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZXYCourseDetailListData *copy = [[ZXYCourseDetailListData alloc] init];
    
    if (copy) {

        copy.imgPath = [self.imgPath copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.starNum = [self.starNum copyWithZone:zone];
        copy.desc = [self.desc copyWithZone:zone];
        copy.collectNum = [self.collectNum copyWithZone:zone];
    }
    
    return copy;
}


@end
