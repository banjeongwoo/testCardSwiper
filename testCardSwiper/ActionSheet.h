//
//  ActionSheet.h
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//

#import "Component.h"

NS_ASSUME_NONNULL_BEGIN
@class ActionSheetContentView;

@interface ActionSheet : Component

@property(nonatomic,strong) NSString *title;
@property(nonnull,nonatomic,strong)ActionSheetContentView *contentView;
@property(nonatomic)UIEdgeInsets *contentEdgeInsets;
@property(nonatomic)UIEdgeInsets *titleEdgeInsets;

@property(nonatomic)CGFloat titleHeight;
@property(nonatomic)CGFloat contentHeight;
@property(nonatomic)BOOL reverse;
@property(nonatomic)BOOL isBottonEdge;
@property(nonatomic)BOOL blankTouch;

- (void)changeContentHeight:(CGFloat) contentHeight;

- (void)show;
- (void)dismiss;
- (void)showInView:(UIView*)view;
- (void)showInAlphaView:(UIView*)view;
@end

NS_ASSUME_NONNULL_END
