//
//  Message.h
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Message : NSObject
+ (Message*)messageWithObject:(nullable id)object;
+ (Message*)messageWithName:(NSString*)name object:(nullable id)object;
@property(nonatomic,readonly)NSString *name;
@property(nonatomic,readonly)id object;
@end

NS_ASSUME_NONNULL_END
