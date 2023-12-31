//
//  CardView.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/23.
//

#import "CardView.h"

@interface CardView()
@property(strong, nonatomic) UIView *shadowView;

@property(strong, nonatomic) UIImageView *shadowImageView;


@property(strong, nonatomic) UIPanGestureRecognizer *pgr;
@property(strong, nonatomic) UILabel *indexlabel;

@property(strong, nonatomic) UIButton *cellButton;
@end

@implementation CardView

- (void)dealloc {
    if (self){
        _pgr = nil;
        _shadowView = nil;
        _shadowImageView = nil;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        [self initial];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initial];
    }
    return self;
}

- (void)initial {
    _isLastCell = NO;
    _direction = kMoveNone;
    [self configureShadowView];
    [self configureBgView];
    
    _indexlabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    _indexlabel.textColor = [UIColor blackColor];
    [self.bgView addSubview:_indexlabel];
    
    [self configureCellButton];
    
    [self addPanGestureOnCards];
   
}


-(void) configureShadowView {
    _shadowImageView = [[UIImageView alloc] init];
    //_shadowImageView.backgroundColor = [UIColor clearColor];
    //_shadowImageView.alpha = 1.0;
    _shadowImageView.contentMode = UIViewContentModeScaleToFill;
    _shadowImageView.image = [UIImage imageNamed:@"icolpayshadow"];
    
    [self addSubview:_shadowImageView];
    
    _shadowImageView.translatesAutoresizingMaskIntoConstraints = false;
    [_shadowImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:0].active = true;
    [_shadowImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:0].active = true;
    [_shadowImageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:0].active = true;
    [_shadowImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:0].active = true;
}

-(void) configureBgView {
    _bgView = [[UIImageView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bgView];
    
    _bgView.translatesAutoresizingMaskIntoConstraints = false;
    [_bgView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:12].active = true;
    [_bgView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-12].active = true;
    [_bgView.topAnchor constraintEqualToAnchor:self.topAnchor constant:4].active = true;
    [_bgView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-20].active = true;
}

-(void) configureCellButton {
    _cellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cellButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    _cellButton.layer.zPosition = 100;
    _cellButton.tag = 10000;
    //_cellButton.name = @"cellclick";
    [self addSubview:_cellButton];
    
    _cellButton.translatesAutoresizingMaskIntoConstraints = false;
    [_cellButton.topAnchor constraintEqualToAnchor:self.topAnchor].active = true;
    [_cellButton.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = true;
    [_cellButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = true;
    [_cellButton.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = true;
}

-(void) buttonTouchUpInside:(UIButton*)sender{
     NSLog(@"you clicked on button %d", (int)sender.tag);
    
    [self.delegate actionCardView:self];
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.layer.cornerRadius = 8;
//    self.layer.masksToBounds = true;
    
    if(_bgView != nil){
        self.bgView.layer.cornerRadius = 8;
        self.bgView.layer.masksToBounds = true;
    }
   
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    
}

-(void) setData:(id) data{
    
   
    NSInteger index = [data integerValue];
    _indexlabel.text = [NSString stringWithFormat:@"%d", (int)index+1];
    
            if(index%5 == 0){
                _bgView.backgroundColor = [UIColor blueColor];
            }else if(index%5 == 1){
                _bgView.backgroundColor = [UIColor purpleColor];
            }else if(index%5 == 2){
                _bgView.backgroundColor = [UIColor redColor];
            }else if(index%5 == 3){
                _bgView.backgroundColor = [UIColor blueColor];
            }else if(index%5 == 4){
                _bgView.backgroundColor = [UIColor orangeColor];
            }else {
                //view.backgroundColor = [UIColor greenColor];
                _bgView.backgroundColor = [UIColor colorWithRed:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
                                                               green:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
                                                                blue:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
                                                       alpha:1];
            }
   
//    _bgView.backgroundColor = [UIColor colorWithRed:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
//                                                       green:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
//                                                        blue:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
//                                               alpha:1];
    
    
    //_bgView.backgroundColor = [UIColor whiteColor];
    
}

-(void) addPanGestureOnCards {
    self.userInteractionEnabled = YES;
    _pgr = [[UIPanGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(handlePanGesture:)];
    [self addGestureRecognizer:_pgr];
}

-(void) handlePanGesture:(UIPanGestureRecognizer*) sender {
    
    CardView *card = (CardView*)sender.view;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat baseyOffset = 10.0f*(width/393.0);
    
    CGPoint point = [sender translationInView:self];
    CGPoint centerOfParentContainer = CGPointMake(width/2, self.center.y);
    NSLog(@"point x: %f", point.x);

    if(point.x < 0){
        _direction = kMoveLeft;
    }else if(point.x > 0){
        _direction = kMoveRight;
    }else {
        _direction = kMoveNone;
    }
    
    CGFloat maxMovePosiotion = (width - self.frame.size.width)/2.0f - 5.0f;
    
    if((self.index == 0 && _direction == kMoveRight) || (self.isLastCell && _direction == kMoveLeft)){
        baseyOffset = 0.0f;
        maxMovePosiotion = 10.0f*(width/393.0f);
    }
    
    switch(sender.state) {
        case UIGestureRecognizerStateBegan:
            [self.delegate swipeStart:self];
            break;
            
        case UIGestureRecognizerStateChanged:{
            
            CGFloat angle = (CGFloat)tan(point.x / (self.frame.size.width * 2.0f));
            
            if(angle < -0.08){
                angle = -0.08;
            }
            
            if(angle > 0.08){
                angle = 0.08;
            }
            
            CGFloat percent = (fabs(angle)/0.08);
        
            CGFloat yOffset = -baseyOffset*percent;
        
            if( fabs(point.x) < maxMovePosiotion){
                card.center = CGPointMake(centerOfParentContainer.x + point.x, centerOfParentContainer.y);
            }
            
            CGFloat scale = 0.9 + (1.0-percent)*0.1;
            
            NSLog(@"--->> angle: %f percent : %f scale : %f", angle, percent, scale);
            if((self.index == 0 && _direction == kMoveRight) || (self.isLastCell && _direction == kMoveLeft)){
                angle = 0.0f;
                scale = 1.0f;
            }
            
            CATransform3D transform = CATransform3DIdentity;
            //transform.m32 = 1.0/500;
            transform.m34 = 1.0/900.0;
            transform = CATransform3DTranslate(transform, 0, yOffset,0);
            transform = CATransform3DScale(transform, scale, scale, 1);
            transform = CATransform3DRotate(transform, angle, 0, 0, 1);
            card.layer.transform = transform;
            
//            CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
//            card.transform = CGAffineTransformRotate(transform, angle);
            
            if(!((self.index == 0 && _direction == kMoveRight) || (self.isLastCell && _direction == kMoveLeft))){
                [self.delegate swipeChanged:self index:self.index direction:_direction percent:percent];
            }
       
            break;
        }
        case UIGestureRecognizerStateEnded:{
            CGFloat angle = (CGFloat)tan(point.x / (self.frame.size.width * 2.0));
            
            if(angle < -0.1){
                angle = -0.1;
            }
            
            if(angle > 0.1){
                angle = 0.1;
            }
            
            CGFloat percent = (fabs(angle)/0.1);
            
            NSLog(@"UIGestureRecognizerStateEnded percent %f", percent);
            
            if(percent < 1.0){
                NSLog(@"UIGestureRecognizerStateEnded percent --- not");
                card.center = centerOfParentContainer;
                card.layer.transform = CATransform3DIdentity;
                [self layoutIfNeeded];
                _direction = kMoveNone;
                [self.delegate swipeReset];
                
            }else if(self.index == 0 && _direction == kMoveRight){
                card.center = centerOfParentContainer;
                card.layer.transform = CATransform3DIdentity;
                [self layoutIfNeeded];
                _direction = kMoveNone;
                [self.delegate swipeReset];
            }else if(self.isLastCell && _direction == kMoveLeft){
                card.center = centerOfParentContainer;
                card.layer.transform = CATransform3DIdentity;
                [self layoutIfNeeded];
                _direction = kMoveNone;
                [self.delegate swipeReset];
            }else{
                [self.delegate swipeDidEnd:self index:self.index direction:_direction];
            }
            
            NSLog(@"UIGestureRecognizerStateEnded frame %@", NSStringFromCGRect(self.frame));
        }
            break;
        default:
            break;
    }
    
}

/*
 -(void) handlePanGesture:(UIPanGestureRecognizer*) sender {
     
     CardView *card = (CardView*)sender.view;
     
     CGFloat width = [UIScreen mainScreen].bounds.size.width;
     
    // CGFloat wh = 7.0*(width/393.0);
     
     CGPoint point = [sender translationInView:self];
     
     NSLog(@"point x: %f", point.x);
     
     CGPoint centerOfParentContainer = CGPointMake(width/2, self.center.y);
     
     NSLog(@"--- point x: %f", centerOfParentContainer.x + point.x);
   
     if(point.x < 0){
         _direction = kMoveLeft;
     }else if(point.x > 0){
         _direction = kMoveRight;
     }else {
         _direction = kMoveNone;
     }
     
     CGFloat maxMovePosiotion = (width - self.frame.size.width)/2 - 10;
     if(((self.index == 0 && _direction == kMoveRight) || (self.isLastCell && _direction == kMoveLeft))){
         maxMovePosiotion = 0;//maxMovePosiotion*0.9;
     }
     
     NSLog(@"handlePanGesture %f, %f", card.center.x, card.center.y);
     
     switch(sender.state) {
         case UIGestureRecognizerStateBegan:
             [self.delegate swipeStart:self];
             break;
             
         case UIGestureRecognizerStateChanged:{
             
             CGFloat angle = (CGFloat)tan(point.x / (self.frame.size.width * 2.0));
             
             if(angle < -0.08){
                 angle = -0.08;
             }
             
             if(angle > 0.08){
                 angle = 0.08;
             }
             
             CGFloat percent = (fabs(angle)/0.08);
             
             NSLog(@"--- angle: %f percent : %f", angle, percent);
             
             CGFloat scale = 0.9 + (1.0-percent)*0.1;
             
             NSLog(@"--->> angle: %f percent : %f scale : %f", angle, percent, scale);
             if((self.index == 0 && _direction == kMoveRight) || (self.isLastCell && _direction == kMoveLeft)){
                 angle = 0.0f;
                 scale = 1.0f;
             }
             
             
             //CGFloat yOffset = percent*wh;
             CGFloat yOffset = 0.0f;
 //            if(_direction == kMoveRight && fabs(point.x) < maxMovePosiotion){
 //                card.center = CGPointMake(centerOfParentContainer.x + point.x, self.center.y);
 //            }else if(_direction == kMoveLeft && fabs(point.x) < maxMovePosiotion){
 //                card.center = CGPointMake(centerOfParentContainer.x + point.x, self.center.y);
 //            }else{
 //                yOffset = -8.0*percent;
 //
 //                CGAffineTransform transform =  CGAffineTransformTranslate(CGAffineTransformIdentity, 0, yOffset);
 //                transform =  CGAffineTransformScale(transform, scale, scale);
 //                card.transform = CGAffineTransformRotate(transform, angle);
 //
 //                [self.delegate swipeChanged:self index:self.index direction:_direction percent:percent];
 //            }
             
             
             if(!((self.index == 0 && _direction == kMoveRight) || (self.isLastCell && _direction == kMoveLeft))){
                 yOffset = -8.0*percent;
                 CGFloat xx =  point.x;
                 if(_direction == kMoveRight && fabs(point.x) > maxMovePosiotion){
                     xx = maxMovePosiotion;
                 }else if(_direction == kMoveLeft && fabs(point.x) > maxMovePosiotion){
                     xx = -maxMovePosiotion;
                 }
                 
                 CGAffineTransform transform =  CGAffineTransformTranslate(CGAffineTransformIdentity, xx, yOffset);
                 transform =  CGAffineTransformScale(transform, scale, scale);
                 card.transform = CGAffineTransformRotate(transform, angle);
                 
                 [self.delegate swipeChanged:self index:self.index direction:_direction percent:percent];
             }else if (self.index == 0 && _direction == kMoveRight){
                 CGFloat xx =  point.x;
                 if(fabs(point.x) > maxMovePosiotion){
                     xx = maxMovePosiotion;
                 }
                 
                 card.center = CGPointMake(centerOfParentContainer.x + xx, self.center.y);
                 
                 //card.transform =  CGAffineTransformTranslate(CGAffineTransformIdentity, xx, 0);
             }else if (self.isLastCell && _direction == kMoveLeft){
                 CGFloat xx =  point.x;
                 if(fabs(point.x) > maxMovePosiotion){
                     xx = -maxMovePosiotion;
                 }
                 
                 card.center = CGPointMake(centerOfParentContainer.x + xx, self.center.y);
                 
                 //card.transform =  CGAffineTransformTranslate(CGAffineTransformIdentity, xx, 0);
             }
        
             
             
            
             
          
             
 //            CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
 //            card.transform = CGAffineTransformRotate(transform, angle);
             
             

 //            if(!((self.index == 0 && _direction == kMoveRight) || (self.isLastCell && _direction == kMoveLeft))){
 //                [self.delegate swipeChanged:self index:self.index direction:_direction percent:percent];
 //            }
        
             break;
         }
         case UIGestureRecognizerStateEnded:{
             CGFloat angle = (CGFloat)tan(point.x / (self.frame.size.width * 2.0));
             
             if(angle < -0.08){
                 angle = -0.08;
             }
             
             if(angle > 0.08){
                 angle = 0.08;
             }
             
             CGFloat percent = (fabs(angle)/0.08);
             
             NSLog(@"UIGestureRecognizerStateEnded percent %f", percent);
             
             if(percent < 1.0){
                 NSLog(@"UIGestureRecognizerStateEnded percent --- not");
              
                 card.transform = CGAffineTransformIdentity;
                 card.center = CGPointMake(self.frame.size.width/2, self.center.y);
                 [self layoutIfNeeded];
                 _direction = kMoveNone;
                 [self.delegate swipeReset];
                 
             }else if(self.index == 0 && _direction == kMoveRight){
                 //card.transform = CGAffineTransformIdentity;
                 card.center = centerOfParentContainer;
                 //CGPointMake(self.frame.size.width/2, self.center.y);
                 //[self layoutIfNeeded];
                 //_direction = kMoveNone;
                 //[self.delegate swipeReset];
             }else if(self.isLastCell && _direction == kMoveLeft){
                 card.center = centerOfParentContainer;
 //                card.transform = CGAffineTransformIdentity;
 //                card.center = CGPointMake(self.frame.size.width/2, self.center.y);
 //                [self layoutIfNeeded];
 //                _direction = kMoveNone;
                 //[self.delegate swipeReset];
             }else{
                 [self.delegate swipeDidEnd:self index:self.index direction:_direction];
             }

             
             NSLog(@"UIGestureRecognizerStateEnded frame %@", NSStringFromCGRect(self.frame));
             
             NSLog(@"UIGestureRecognizerStateEnded centerOfParentContainer %f %f", centerOfParentContainer.x, centerOfParentContainer.y);
         }
             break;
         default:
             break;
     }
     
 }
 */

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
  return YES;
}


@end

