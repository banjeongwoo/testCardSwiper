//
//  ComponentLayerView.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//

#import "ComponentLayerView.h"
#import "UIColor+Extension.h"

@interface ComponentLayerView()

@end

@implementation ComponentLayerView

- (void)initial {
    self.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
    self.backgroundView = [UIView new];
    self.backgroundView.backgroundColor = [UIColor rgbColorWithRed:0 green:0 blue:0 alpha:.8f];
    
    [self addSubview:self.backgroundView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
}


- (void)didAddSubview:(UIView *)subview {
    [super didAddSubview:subview];
    if(self.subviews.count == 2){
        self.hidden = NO;
        self.backgroundView.alpha = 0.5;
        [UIView animateWithDuration:0.3f animations:^{
            self.backgroundView.alpha = 1.0;
        } completion:^(BOOL finished) {
        }];
    }
}
   
- (void)addSubview:(UIView *)view {
    if (self.subviews.count > 1){
        UIView *lastView = self.subviews.lastObject;
        lastView.hidden = NO;
        view.hidden = YES;
        
        [self insertSubview:view atIndex:1];
    }else{
        [super addSubview:view];
    }
}

- (void)willRemoveSubview:(UIView *)subview {
    [super willRemoveSubview:subview];
    NSInteger count = self.subviews.count;
    if(count == 2){
        [UIView animateWithDuration:0.3f animations:^{
            if (self) {
                self.backgroundView.alpha = 0.0;
            }
        } completion:^(BOOL finished) {
            if (finished) {
                self.hidden = YES;
            }else {
                NSArray *subviews = [[UIApplication sharedApplication].keyWindow.rootViewController.view subviews];
                for (UIView *subview in subviews) {
                    if ([subview isKindOfClass:[ComponentLayerView class]]) {
                        self.hidden = true;
                    }
                }
            }
        }];
    }else if(count > 2){
        UIView *view = [self.subviews objectAtIndex:count - 2];

        view.hidden = NO;
        view.alpha = 0;
        SEL selector = NSSelectorFromString(@"showAnimation");
        if([view respondsToSelector:selector]){
            IMP imp = [view methodForSelector:selector];
            void (*func)(id, SEL) = (void*)imp;
            func(view, selector);
        }
    }
}
@end
