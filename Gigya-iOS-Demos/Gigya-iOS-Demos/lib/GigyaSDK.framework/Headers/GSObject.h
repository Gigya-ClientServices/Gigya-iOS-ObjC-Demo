//
//  GSObject.h
//  GigyaSDK
//
//  Created by Ran Dahan on 7/11/13.
//  Copyright (c) 2013 Gigya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSObject : NSObject

@property (nonatomic, copy) NSString *source;
- (id)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key;
- (id)objectForKey:(NSString *)key;
- (void)setObject:(id)obj forKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (NSArray *)allKeys;
- (NSString *)JSONString;

@end
