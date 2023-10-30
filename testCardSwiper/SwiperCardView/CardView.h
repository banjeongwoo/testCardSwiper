//
//  CardView.h
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CardView;

typedef enum {
    kMoveNone,
    kMoveLeft,
    kMoveRight
} EnumCardSwipe;

@protocol CardDelegate <NSObject>
-(void) swipeStart:(CardView*) cardView;
-(void) swipeChanged:(CardView*) cardView index:(NSInteger) index direction:(EnumCardSwipe) direction percent:(CGFloat) percent;
-(void) swipeDidEnd:(CardView*) cardView index:(NSInteger) index direction:(EnumCardSwipe) direction;
-(void) swipeReset;
-(void) actionCardView:(CardView*)cardView;
//-(void) actionCardView:(CardView*)cardView message:(Message*) message;
@end

@interface CardView : UIView
@property (nonatomic, weak, nullable) id <CardDelegate> delegate;

@property(strong, nonatomic) UIView *bgView;
@property(nonatomic) BOOL isLastCell;
@property(nonatomic) NSInteger index;
@property(nonatomic) NSInteger maxCardLegth;
@property(nonatomic) EnumCardSwipe direction;
-(void) initial;
-(void) setData:(id) data;
-(void) addPanGestureOnCards;
@end

NS_ASSUME_NONNULL_END
