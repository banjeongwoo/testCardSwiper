//
//  SwipeCardView.h
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/23.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

NS_ASSUME_NONNULL_BEGIN
@class SwipeCardView;

@protocol SwipeCardsDataSource <NSObject>
-(NSInteger) numberOfItems;
- (__kindof CardView *) cardAtIndex:(NSInteger)index;
@optional

@end

@protocol SwipeCardsDelegate <NSObject>
@optional
-(void) SwipeCardView:(CardView*) cardView didSelectItemAtIndex:(NSInteger) index;
//-(void) SwipeActionCardView:(CardView*)cardView message:(Message*) message;
-(void) SwipeCardView:(CardView*)cardView currentPage:(NSInteger)page;
@end


@interface SwipeCardView : UIView
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, weak, nullable) id <SwipeCardsDataSource> dataSource;
@property (nonatomic, weak, nullable) id <SwipeCardsDelegate> delegate;

-(void) setCurrnetPositonIndex:(NSInteger) index;
-(void) reloadData;

@end

NS_ASSUME_NONNULL_END
