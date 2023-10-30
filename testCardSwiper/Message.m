//
//  Message.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//

#import "Message.h"

@implementation Message

- (void)dealloc
{
    _name = nil;
    _object = nil;
}

+ (Message*)messageWithObject:(id)object
{
    Message *message = [[Message alloc]init];
    message->_name = nil;
    message->_object = object;
    return message;
}

+ (Message*)messageWithName:(NSString*)name object:(id)object
{
    Message *message = [[Message alloc]init];
    message->_name = name;
    message->_object = object;
    return message;
}
@end
