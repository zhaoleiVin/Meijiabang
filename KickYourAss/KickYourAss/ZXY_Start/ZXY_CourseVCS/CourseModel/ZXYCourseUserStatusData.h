//
//  ZXYCourseUserStatusData.h
//
//  Created by   on 15/3/13
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXYCourseUserStatusData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *isStar;
@property (nonatomic, strong) NSString *isCollect;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
