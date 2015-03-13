//
//  ZXYCourseDetailListData.h
//
//  Created by   on 15/3/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXYCourseDetailListData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imgPath;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *starNum;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *collectNum;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
