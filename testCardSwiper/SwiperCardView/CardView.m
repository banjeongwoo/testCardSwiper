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
    //    _shadowView = [[UIView alloc] init];
    //    _shadowView.backgroundColor = [UIColor blackColor];
    //    _shadowView.alpha = 0.15;
    //
    //
    //    [self addSubview:_shadowView];
    //
    //    _shadowView.translatesAutoresizingMaskIntoConstraints = false;
    //    [_shadowView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = true;
    //    [_shadowView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = true;
    //    [_shadowView.topAnchor constraintEqualToAnchor:self.topAnchor].active = true;
    //    [_shadowView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = true;
    //
    //    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    //    _shadowView.layer.shadowOffset = CGSizeMake(0, 10);
    //    _shadowView.layer.shadowOpacity = 1.0;
    //    _shadowView.layer.shadowRadius = 10.0;
    
    _shadowImageView = [[UIImageView alloc] init];
    _shadowImageView.backgroundColor = [UIColor clearColor];
    _shadowImageView.alpha = 1.0;
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
                _bgView.backgroundColor = [UIColor yellowColor];
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
    
    CGFloat wh = 7.0*(width/393.0);
    
    CGPoint point = [sender translationInView:self];
    
    NSLog(@"point x: %f", point.x);
    
    CGPoint centerOfParentContainer = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
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
        maxMovePosiotion = 10;//maxMovePosiotion*0.9;
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
            
            //(1.0 - 0.9)
            // 사이즈
            //(1.0-percent)*0.9;
            
            CGFloat yOffset = percent*wh;
            
            if(_direction == kMoveRight && fabs(point.x) < maxMovePosiotion){
                card.center = CGPointMake(centerOfParentContainer.x + point.x, centerOfParentContainer.y-yOffset);
            }else if(_direction == kMoveLeft && fabs(point.x) < maxMovePosiotion){
                card.center = CGPointMake(centerOfParentContainer.x + point.x, centerOfParentContainer.y-yOffset);
            }
            
            CGFloat scale = 0.9 + (1.0-percent)*0.1;
            
            NSLog(@"--->> angle: %f percent : %f scale : %f", angle, percent, scale);
            if((self.index == 0 && _direction == kMoveRight) || (self.isLastCell && _direction == kMoveLeft)){
                angle = 0.0f;
                scale = 1.0f;
            }
            
            CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
            card.transform = CGAffineTransformRotate(transform, angle*1.3);
            
            

            if(!((self.index == 0 && _direction == kMoveRight) || (self.isLastCell && _direction == kMoveLeft))){
                [self.delegate swipeChanged:self index:self.index direction:_direction percent:percent];
            }
       
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
                card.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
                [self layoutIfNeeded];
                _direction = kMoveNone;
                [self.delegate swipeReset];
                
            }else if(self.index == 0 && _direction == kMoveRight){
                card.transform = CGAffineTransformIdentity;
                card.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
                [self layoutIfNeeded];
                _direction = kMoveNone;
                [self.delegate swipeReset];
            }else if(self.isLastCell && _direction == kMoveLeft){
                card.transform = CGAffineTransformIdentity;
                card.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
                [self layoutIfNeeded];
                _direction = kMoveNone;
                [self.delegate swipeReset];
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

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
  return YES;
}


@end
