//
//  UIColor+Extension.h
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)
+ (UIColor *)hex:(UInt32)col;
+ (UIColor *)hex:(UInt32)col alpha:(float)alpha;
+ (UIColor*)rgbColorWithRed:(float)r green:(float)g blue:(float)b alpha:(float)alpha;
+ (UIColor *)pointBlueColor;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
@end

NS_ASSUME_NONNULL_END
