//
//  ActionSheet.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//

#import "ActionSheet.h"
#import "ComponentLayerView.h"
NSString *const RootControllerTouchEventNotification = @"RootControllerTouchEventNotification";

@interface ActionSheet()

@property(nonnull,nonatomic,strong)UIView *titleView;
@property(nonatomic)BOOL isShowInView;
@property(nonatomic,strong) UIButton *button;
@end

@implementation ActionSheet

- (void)dealloc {
     _title = nil;
    _contentView = nil;
    _titleView = nil;
    if(_blankTouch){
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    
}

- (void)initial {
    
    _titleHeight = 40.0f;
    _contentHeight = 20.0f;
    
    self.backgroundColor = [UIColor whiteColor];
//    _contentView = [ActionSheetContentView new];
    
    _reverse = NO;
    _blankTouch = NO;
    _isBottonEdge = YES;
  
}

-(void) setBlankTouch:(BOOL)blankTouch {
    _blankTouch = blankTouch;
    
    if(_blankTouch){
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                    selector:@selector(touchEventNotification:)
                                                        name:RootControllerTouchEventNotification
                                                      object:nil];
    }
}


- (UIView*)titleView:(CGRect)frame {
    
    UIView *container = [[UIView alloc]initWithFrame:frame];
   
    
    CGRect slice;
    CGRect remainder;

    container.backgroundColor = [UIColor whiteColor];
    CGRectDivide(UIEdgeInsetsInsetRect(container.bounds, UIEdgeInsetsMake(0, 10, 0, 10)),
                 &slice, &remainder,
                 frame.size.height,
                 CGRectMaxXEdge);

    //Label *label = [[Label alloc]initWithFrame:remainder];
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = self.title;
    
    label.numberOfLines = 1;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor darkTextColor];
    [container addSubview:label];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //_button.style = _reverse ? @"actionSheetReverseCloseButton" : @"actionSheetCloseButton";
    [_button addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _button.frame = slice;
    _button.accessibilityLabel = @"닫기";
    _button.accessibilityHint = @"";
    [container addSubview:_button];
    
    return container;
}


- (void)show {
   // UIViewController *rvc = UIApplication.sharedApplication.keyWindow.rootViewController;
    //UIView *view = [rvc valueForKey:@"componentLayerView"];
   
    ComponentLayerView *view = [[ComponentLayerView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.rootViewController.view.bounds];
    [[UIApplication sharedApplication].keyWindow.rootViewController.view addSubview:view];
    
    [self _showInView:view];
}

- (void)setContentView:(ActionSheetContentView *)contentView {
    contentView.actionSheet = self;
    _contentView = contentView;
}

- (void)showInAlphaView:(UIView*)view {
    self.isShowInView = YES;
    ComponentLayerView *componentLayerView = [[ComponentLayerView alloc]initWithFrame:view.bounds];
    componentLayerView.backgroundView.backgroundColor = [UIColor rgbColorWithRed:0 green:0 blue:0 alpha:0.8f];
    [view addSubview:componentLayerView];
    [self _showInView:componentLayerView];
}

- (void)showInView:(UIView*)view {
    
    self.isShowInView = YES;
    UIView *componentLayerView = [[ComponentLayerView alloc]initWithFrame:view.bounds];
    [view addSubview:componentLayerView];
    [self _showInView:componentLayerView];
}

- (void)_showInView:(UIView*)view {
    
    UIViewController *rvc = UIApplication.sharedApplication.keyWindow.rootViewController;
    
    
    if (_reverse) {
        
        UIEdgeInsets edgeInsets = [rvc safeAreaInsets];
        CGFloat safeArea = edgeInsets.top;
        
        CGRect frame = view.bounds;
        CGFloat height = _titleHeight + _contentHeight;
        height += safeArea;
        
        CGRect slice;
        CGRect remainder;
        
        CGRectDivide(frame, &slice, &remainder, height, CGRectMinYEdge);
        
        self.frame = slice;
        
        remainder = UIEdgeInsetsInsetRect(slice, UIEdgeInsetsMake(safeArea, 0, 0, 0));
        
        
        CGRectDivide(remainder, &slice, &remainder, _titleHeight, CGRectMinYEdge);
        
        self.titleView = [self titleView:slice];
        
        [self addSubview:_titleView];
        
        
        CGRectDivide(remainder, &slice, &remainder, _contentHeight, CGRectMinYEdge);
        
        _contentView.frame = slice;
        [self addSubview:_contentView];
        
        
        [view addSubview:self];
        
        [self roundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight
                       radius:CGSizeMake(25.0f, 25.f)];
        
    }else {

        UIEdgeInsets edgeInsets = [rvc safeAreaInsets];
        CGFloat safeArea = edgeInsets.bottom;
        
        CGRect frame = view.bounds;
        CGFloat height = self.titleHeight + self.contentHeight;
        
        if(_isBottonEdge)
            height += safeArea;
        
        
        CGRect slice;
        CGRect remainder;
        
        CGRectDivide(frame, &slice, &remainder, height, CGRectMaxYEdge);
        
        self.frame = slice;
        
        CGRectDivide(self.bounds, &slice, &remainder, self.titleHeight, CGRectMinYEdge);
        if(self.titleHeight > 0){
            self.titleView = [self titleView:slice];
            [self addSubview:_titleView];
        }
        
        CGRectDivide(remainder, &slice, &remainder, self.contentHeight, CGRectMinYEdge);
        _contentView.frame = slice;
        [self addSubview:_contentView];
        
        
        [view addSubview:self];
        
        if([self.style isEqualToString:@"BenefitPartnerShip"]){
            self.titleView.backgroundColor = [UIColor clearColor];
        }else{
            [self roundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                           radius:CGSizeMake(25.0f, 25.f)];
        }
    }
    
    
    [self showAnimation];
}

- (void)changeContentHeight:(CGFloat) contentHeight {
    
    _contentHeight = contentHeight;
    
    UIViewController *rvc = UIApplication.sharedApplication.keyWindow.rootViewController;
    UIView *view = [rvc valueForKey:@"componentLayerView"];
    
    if (_reverse) {
           
       UIEdgeInsets edgeInsets = [rvc safeAreaInsets];
       CGFloat safeArea = edgeInsets.top;
       
       CGRect frame = view.bounds;
       CGFloat height = _titleHeight + _contentHeight;
       if(_isBottonEdge)
           height += safeArea;
       
       CGRect slice;
       CGRect remainder;
       
       CGRectDivide(frame, &slice, &remainder, height, CGRectMinYEdge);
       
       self.frame = slice;
       
       remainder = UIEdgeInsetsInsetRect(slice, UIEdgeInsetsMake(safeArea, 0, 0, 0));
       
       
       CGRectDivide(remainder, &slice, &remainder, _titleHeight, CGRectMinYEdge);
       
        _titleView.frame = slice;
       
       CGRectDivide(remainder, &slice, &remainder, _contentHeight, CGRectMinYEdge);
       
       _contentView.frame = slice;
        
        [self roundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight
                       radius:CGSizeMake(25.0f, 25.f)];
        
    }else {

        UIEdgeInsets edgeInsets = [rvc safeAreaInsets];
        CGFloat safeArea = edgeInsets.bottom;
           
       CGRect frame = view.bounds;
       CGFloat height = self.titleHeight + self.contentHeight;
       height += safeArea;
       
       
       CGRect slice;
       CGRect remainder;
       
       CGRectDivide(frame, &slice, &remainder, height, CGRectMaxYEdge);
       
       self.frame = slice;
       
       CGRectDivide(self.bounds, &slice, &remainder, self.titleHeight, CGRectMinYEdge);
        _titleView.frame  = slice;
           
        CGRectDivide(remainder, &slice, &remainder, self.contentHeight, CGRectMinYEdge);
           
        _contentView.frame = slice;
        
        [self roundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight
                              radius:CGSizeMake(25.0f, 25.f)];
    }
}


- (void)dismiss {
    
//    if ([_contentView.delegate respondsToSelector:@selector(actionSheetContentView: message:)]){
//        [_contentView.delegate actionSheetContentView:_contentView message:[Message messageWithName:@"dismiss" object:_contentView.]];
//    }

//    delegate?.actionSheet?(self, clickedButtonAt: selectedIndex)
    [_contentView dismiss];
    BOOL ani = [self dismissAnimation];
    if (ani) {
    }else{
        [self removeFromSuperview];
        if(self.isShowInView){
            [self.superview removeFromSuperview];
        }
    }
    
    
}

- (BOOL)showAnimation {
    
    DECLARE_WEAK_SELF(weakself);
    
    CGFloat ty = self.bounds.size.height;
    if (_reverse) {
        ty *= -1;
        UIViewController *rvc = UIApplication.sharedApplication.keyWindow.rootViewController;
        [((RootController*)rvc) setStatusBarHidden:YES animated:YES];
    }
    CATransform3D transform = CATransform3DTranslate(CATransform3DIdentity,
                                                     0,
                                                     ty,
                                                     0);
    self.layer.transform = transform;
    
    
    [UIView animateWithDuration:0.3f
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
        weakself.layer.transform = CATransform3DIdentity;
    } completion:^(BOOL finished) {
        if (UIAccessibilityIsVoiceOverRunning()) {
            UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.button);
        }
    }];
    
    return YES;
}

- (BOOL)dismissAnimation {
    
    DECLARE_WEAK_SELF(weakself);
    
    CATransform3D transform = CATransform3DIdentity;
    self.layer.transform = transform;
    
    CGFloat ty = self.bounds.size.height;
    if (_reverse) {
        ty *= -1;
        
        UIViewController *rvc = UIApplication.sharedApplication.keyWindow.rootViewController;
        [((RootController*)rvc) setStatusBarHidden:NO animated:YES];
    }
    
    [UIView animateWithDuration:0.3f
                          delay:0.3f
         usingSpringWithDamping:1
          initialSpringVelocity:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        weakself.layer.transform = CATransform3DTranslate(CATransform3DIdentity,
                                                          0,
                                                          ty,
                                                          0);
        
    } completion:^(BOOL finished) {
        [weakself removeFromSuperview];
        
        if(weakself.isShowInView){
            [weakself.superview removeFromSuperview];
        }
    }];
    return YES;
}


#pragma mark - RootController TouchEventNotification
- (void)touchEventNotification:(NSNotification *)notification {
    if(_blankTouch){
        
        UITouch *touch  = notification.object;
          
        UIView *keyWindow = UIApplication.sharedApplication.keyWindow;
        CGPoint point = [touch locationInView:keyWindow];
        
        CGRect convertFarme = [self convertRect:self.bounds toView:keyWindow];
        BOOL contains = CGRectContainsPoint(convertFarme, point);
        
        if (contains) {
            return;
        }
        
        
        
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
//        _blankTouch = NO;
//        [self dismiss];
      
         UIView *touchView = touch.view;
         if([touchView isKindOfClass:[UIView class]] && ![touchView isKindOfClass:[Button class]]){
             if(touchView.tag != 10000){
                 [[NSNotificationCenter defaultCenter] removeObserver:self];
                 _blankTouch = NO;
                 [self dismiss];
             }
             
         }
         
    }
}


//open override func showAnimation() -> Bool {
//    self.backgroundView.alpha = 0.5
//    UIView.animate(withDuration: 0.3) {
//        self.backgroundView.alpha = 1
//    }
//
//    let transform = CATransform3DTranslate(CATransform3DIdentity,
//                                           0,
//                                           self.contentView.bounds.size.height,
//                                           0)
//
//    self.contentView.layer.transform = transform
//    UIView.animate(withDuration: 0.3,
//                   delay: 0.1,
//                   usingSpringWithDamping: 1,
//                   initialSpringVelocity: 0,
//                   options: .curveEaseOut,
//                   animations: {
//                    self.contentView.layer.transform = CATransform3DIdentity
//    },completion: nil)
//    return true
//}
//
//
//@discardableResult
//open override func dismissAnimation() -> Bool{
//
//    UIView.animate(withDuration: 0.3) {
//        self.backgroundView.alpha = 0.0
//    }
//
//    let transform = CATransform3DIdentity
//    self.layer.transform = transform
//    UIView.animate(withDuration: 0.3,
//                   delay: 0.1,
//                   usingSpringWithDamping: 1,
//                   initialSpringVelocity: 0,
//                   options: .curveEaseOut,
//                   animations: {
//                    self.contentView.layer.transform = CATransform3DTranslate(CATransform3DIdentity,
//                                                                              0,
//                                                                              self.contentView.frame.size.height,
//                                                                              0)
//    },completion: { finished in
//        self.removeFromSuperview()
//    })
//    return true
//}

@end
