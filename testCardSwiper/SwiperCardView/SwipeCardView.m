//
//  SwiperCardView.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/23.
//

#import "SwipeCardView.h"

@interface SwipeCardView()
@property (nonatomic, strong) NSMutableArray<CardView*> * cardViews;
@property (nonatomic) NSInteger numberOfCards;
@property (nonatomic) NSInteger cardsToBeVisible;
@property (nonatomic) NSInteger remainingcards;

@property (nonatomic) CGFloat horizontalInset;
@property (nonatomic) CGFloat verticalInset;
@property (nonatomic) CGRect orgRect;

//@property (nonatomic) NSInteger leftInsertIdx;
//@property (nonatomic) NSInteger rightInsertIdx;


// new ----

@property (nonatomic) NSInteger previousIndex;
@property (nonatomic) CGFloat cardPadding;

//@property (nonatomic) NSInteger realCurrentIndex;

@property(strong, nonatomic) UIPanGestureRecognizer *pgr;


@property (nonatomic) NSInteger currentPreGestureZindex;
@property (nonatomic) NSInteger nextPreGestureZindex;
@property (nonatomic) NSInteger nextPreIndex;
@end


@implementation SwipeCardView
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
    _cardViews = [NSMutableArray array];
    _orgRect = self.bounds;

    _horizontalInset = 40;
    _verticalInset = 5;
    _cardsToBeVisible = 7;
   

    _cardPadding = 40.0;
    self.currentIndex = 0;
    //_realCurrentIndex = 0;
    _previousIndex = 0;
}

-(void) setCurrnetPositonIndex:(NSInteger) index{
    self.currentIndex = index;
    [self reloadData];
}

-(void) reloadData{
    
    for(CardView *cardView in self.cardViews) {
        [cardView removeFromSuperview];
    }
    
    [self.cardViews removeAllObjects];
    
    _numberOfCards = [self.dataSource numberOfItems];
    
    _remainingcards = _numberOfCards;
    
    if(self.currentIndex > 0){
        _previousIndex = _currentIndex-1;
    }else{
        _previousIndex = 0;
    }
    
    NSInteger startIdx = MAX(0, self.currentIndex-3);
    NSInteger endIdx = MIN(_numberOfCards, startIdx+_cardsToBeVisible+1);
       
    //_realCurrentIndex = self.currentIndex;
    
    //for(int i=0; i < MIN(_numberOfCards, _cardsToBeVisible); i++){
    for(NSInteger i=startIdx; i < endIdx; i++){
        CardView *view = [self.dataSource cardAtIndex:i];
        view.index = i;
        
        if(_numberOfCards-1 == i){
            view.isLastCell = YES;
        }else{
            view.isLastCell = NO;
        }
        
        view.maxCardLegth = _numberOfCards;
        view.delegate = (id)self;
        [self frameCardViews:view atIndex:i];
        
        if(i == self.currentIndex){
            view.userInteractionEnabled = YES;
        }else{
            view.userInteractionEnabled = NO;
        }
        
        // 화면 숨기 처리
        if(view.index < self.currentIndex - 2){
            view.hidden = YES;
        }else if(view.index > self.currentIndex + 2){
            view.hidden = YES;
        }else{
            view.hidden = NO;
        }
        
        [self.cardViews insertObject:view atIndex:0];
        [self insertSubview:view atIndex:0];
        self.remainingcards -= 1;
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    NSLog(@"reloadData");
    
}

-(CGFloat) xOffset:(NSInteger) index {
    NSInteger topCardProgress = [self currentPosition:index];
    CGFloat padding = _cardPadding;
    CGFloat x = ((CGFloat)index - _currentIndex)*padding;
    if(topCardProgress > 0 && topCardProgress < 0.99 && index < (_numberOfCards -1)){
        return x * [self swingOutMultiplier:topCardProgress];
    }
    
    return x;
}

-(NSInteger) zIndex:(NSInteger) index {
    if(index < _currentIndex){
        return -(_numberOfCards - index);
    }else{
        return (_numberOfCards - index);
    }
}

-(CGFloat) scale:(NSInteger) index {
    return 1.0 - (0.1 * fabs([self currentPosition:index]));
}

-(CGFloat) currentPosition:(NSInteger) index {
    return _currentIndex - index;
}

-(CGFloat) swingOutMultiplier:(CGFloat) progress {
    return sin(M_PI * progress) * 15;
}

-(CGFloat) rotationDegrees:(NSInteger) index {
    return -[self currentPosition:index]*2;
}


-(void) frameCardViews:(CardView *) cardView atIndex:(NSInteger) index {
    CGRect cardViewFrame = _orgRect;
    
    cardView.layer.zPosition = [self zIndex:index];
    CGFloat xoffset = [self xOffset:index];
    CGFloat scale = [self scale:index];
    CGFloat degress = [self rotationDegrees:index];
    
    if(xoffset < 0){
        xoffset = xoffset / 4;
    }
    
    NSLog(@"xoffset %f, scale %f", xoffset, scale);
    
    cardViewFrame.origin.x += xoffset;
    
    cardViewFrame.size.width = cardViewFrame.size.width*scale;
    cardViewFrame.size.height = cardViewFrame.size.height*scale;
    
    cardViewFrame.origin.y = (_orgRect.size.height - cardViewFrame.size.height)/2;
    
    cardView.frame = cardViewFrame;
    cardView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, degress*M_PI/180);
    [cardView setNeedsLayout];
    [cardView layoutIfNeeded];
    

    NSLog(@"oooo %d cardView.frame : %@", (int)index, NSStringFromCGRect(cardView.frame));
}

//-(void) frameCardViews:(CardView *) cardView atIndex:(NSInteger) index atNextIndex:(NSInteger)nextIndex percent:(CGFloat) percent{
//    NSLog(@"nextIndex %d", (int)nextIndex);
////    CGRect cardViewFrame = _orgRect;
// //   cardView.layer.zPosition = [self zIndex:index];
//    CGFloat xoffset = [self xOffset:nextIndex];
//    CGFloat scale = [self scale:nextIndex];
//    CGFloat degress = [self rotationDegrees:nextIndex];
//    NSLog(@"xoffset : %f scale %f", xoffset, scale);
//
//    CGFloat p = 0.9 + (1.0-percent)*0.1;
//
//    if(_previousIndex > index){
//        xoffset = (xoffset*(1.0-percent)*0.1)*4;
//    }else{
//        xoffset = -(xoffset*(1.0-percent)*0.1);
//    }
//
//    NSLog(@"frameCardViews:(CardView *) %d xoffset : %f", (int)index, xoffset);
//
//    scale = 0.1+scale*p;
//    degress = degress*p;
//    NSLog(@"000 scale : %f", scale);
//
//    if(xoffset < 0){
//    //    xoffset = xoffset / 4;
//    }
//
//    // last card frame ---
////    cardViewFrame.origin.x += xoffset;
////    cardViewFrame.size.width = cardViewFrame.size.width*scale;
////    cardViewFrame.size.height = cardViewFrame.size.height*scale;
////    cardViewFrame.origin.y = (_orgRect.size.height - cardViewFrame.size.height)/2;
//
//    //cardView.frame = cardViewFrame;
////    cardView.transform = CGAffineTransformMakeRotation(degress*M_PI/180);
//
//    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
//    //transform = CGAffineTransformTranslate(transform, xoffset*10, 0);
//    transform = CGAffineTransformTranslate(transform, xoffset, 0);
//    cardView.transform = CGAffineTransformRotate(transform, degress*M_PI/180);
//
//    [cardView setNeedsLayout];
//    [cardView layoutIfNeeded];
//
//    if(index == 1){
////        NSLog(@"xxxoooo index: %d, percent: %f offset: %f degress:%f scale:%f", (int)index, percent, xoffset, degress, scale);
////        NSLog(@"xxxoooo  %@", NSStringFromCGRect(cardViewFrame));
//
//        NSLog(@"xxxoooo degress:%f ",  degress);
//    }
//
//}


-(void) frameCardViews:(CardView *) cardView atIndex:(NSInteger) index atNextIndex:(NSInteger)nextIndex percent:(CGFloat) percent direction:(EnumCardSwipe) direction{
    NSLog(@"nextIndex %d", (int)nextIndex);
//    CGRect cardViewFrame = _orgRect;
 //   cardView.layer.zPosition = [self zIndex:index];
//    CGFloat xoffset = [self xOffset:nextIndex];
//    CGFloat scale = [self scale:nextIndex];
//    CGFloat degress = [self rotationDegrees:nextIndex];
    
    CGFloat xoffset = [self xOffset:index];
    CGFloat nextxoffset = [self xOffset:nextIndex];
    
    CGFloat degress = [self rotationDegrees:index];
    CGFloat nextdegress = [self rotationDegrees:nextIndex];
    
    CGFloat scale = [self scale:index];
    CGFloat nextscale = [self scale:nextIndex];
   
//    if(nextIndex == 2){
//     //   NSLog(@"xxxoooo frameCardViews frameCardViews :(CardView *) index : %d percent :%f xoffset : %f scale: %f degress : %f", (int)index,percent, xoffset, scale, degress);
//        //NSLog(@"xxxoooo frameCardViews === %d xoffset : %f, nextxoffset %f, percent: %f", (int)index, xoffset, nextxoffset, percent);
//    }
    
//    NSInteger topCardProgress = [self currentPosition:index];
//    xoffset = xoffset * [self swingOutMultiplier:topCardProgress];

    
    //CGFloat p = 0.9 + (1.0-percent)*0.1;
    
 //   CGFloat p = scale + (1.0-percent)*0.1;
    // check 중
//    if(_previousIndex > index){
//        xoffset = (xoffset*(1.0-percent)*0.1)*4;
//    }else{
//        xoffset = -(xoffset*(1.0-percent)*0.1);
//    }
    
    if(direction == kMoveLeft){
//        if(index == self.currentIndex+1){
//
//        }else{
//            xoffset = -(fabs(nextxoffset-xoffset)*(1.0-percent))/2;
//        }
//
        xoffset = -(fabs(nextxoffset-xoffset)*(1.0-percent))/2;
    }else{
//        if(index == self.currentIndex-1){
//            xoffset = (fabs(nextxoffset-xoffset)*(1.0-percent))/2;
//        }else{
//            xoffset = (fabs(nextxoffset-xoffset)*(1.0-percent))/2;
//        }
        
        xoffset = (fabs(nextxoffset-xoffset)*(1.0-percent))/2;
    }
        
   
   // degress = (degress - nextdegress)*percent;
    degress = nextdegress + (degress - nextdegress)*percent;
    
    if(index > self.currentIndex){
       
    }else{
        scale = 1.0 - (1.0-percent)*0.1;
    }
    
    if(direction == kMoveLeft){
        if(index > self.currentIndex){
            scale = 1.0 + (1.0-percent)*0.1;
        }else{
            scale = 1.0 - (1.0-percent)*0.1;
        }
    }else{
        if(index > self.currentIndex){
            scale = 1.0 - (1.0-percent)*0.1;
        }else{
            scale = 1.0 + (1.0-percent)*0.1;
        }
    }
    
   
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
    
    transform = CGAffineTransformTranslate(transform, xoffset, 0);
    cardView.transform = CGAffineTransformRotate(transform, degress*M_PI/180);
    
    [cardView setNeedsLayout];
    [cardView layoutIfNeeded];
    
    if(index == 2){
//        NSLog(@"xxxoooo index: %d, percent: %f offset: %f degress:%f scale:%f", (int)index, percent, xoffset, degress, scale);
//        NSLog(@"xxxoooo  %@", NSStringFromCGRect(cardViewFrame));

//        NSLog(@"xxxoooo frameCardViews === %d cardView.frame : %@ xoffset : %f, scale : %f degress : %f, percent: %f", (int)index, NSStringFromCGRect(cardView.frame), xoffset, scale, degress, percent);
        
    //    NSLog(@"xxxoooo frameCardViews === %d cardView.frame : %@ xoffset : %f, percent: %f", (int)index, NSStringFromCGRect(cardView.frame), xoffset, percent);
        
        NSLog(@"xxxoooo frameCardViews === %d scale : %f", (int)index, scale);
   
    }
    
  //  NSLog(@"xxxoooo frameCardViews === %d scale : %f", (int)index, scale);
}


-(void) swipeStart:(CardView*) cardView{
    _currentPreGestureZindex = cardView.layer.zPosition;
    //_cardPadding = 55;
    _cardPadding = 40;
    _nextPreIndex = -1;
    NSLog(@"swipeStart !!!!");
    for(CardView *v in self.subviews){
        [self frameCardViews:v atIndex:v.index];
    }
}

-(void) swipeChanged:(CardView*) cardView index:(NSInteger) index direction:(EnumCardSwipe) direction percent:(CGFloat) percent{
    NSLog(@"-- angle swipeChanged index : %d percent: %f", (int)index, percent);
    NSLog(@"xxxoooo 0일때 cardView.frame : %@", NSStringFromCGRect(cardView.frame));
    
    NSInteger nextCard = 0;
    if(direction == kMoveLeft){
        nextCard = _currentIndex+1;
    }else{
        nextCard = _currentIndex-1;
    }
    
    if(percent == 1.0){
        if(_nextPreIndex == -1){
            for(CardView *v in self.subviews){
                if(v.index == nextCard){
                    _nextPreGestureZindex = v.layer.zPosition;
                    NSLog(@"-- _nextPreGestureZindex : %lu", _nextPreGestureZindex);
                    _nextPreIndex = nextCard;
                    v.layer.zPosition = INT_MAX;
                    break;
                }
            }
        }
        
    }else{
        if(_nextPreIndex != -1){
            for(CardView *v in self.subviews){
                if(v.index == _nextPreIndex){
                    v.layer.zPosition = _nextPreGestureZindex;
                }
            }
            
            cardView.layer.zPosition = _currentPreGestureZindex;
            _nextPreIndex = -1;
        }
    }
    
    // NSLog(@"%d", _currentIndex);
    [UIView animateWithDuration:0.0f animations:^{
        for(CardView *v in self.subviews){
            if(v.index != index){
                // 위치 각도 스케일 보정
                if(direction == kMoveLeft){
                    [self frameCardViews:v atIndex:v.index atNextIndex:v.index-1  percent:1.0-percent direction:direction];
                }else{
                    [self frameCardViews:v atIndex:v.index atNextIndex:v.index+1  percent:1.0-percent direction:direction];
                }
            }
        }
    }];
}

-(void) swipeDidEnd:(CardView*) cardView index:(NSInteger) index direction:(EnumCardSwipe) direction{
    _cardPadding = 40;
    NSLog(@"swipeDidEnd %d", (int)index);
    if(direction == kMoveLeft){
        NSLog(@"swipeDidEnd xxxxxx kMoveLeft");
    }else if(direction == kMoveRight){
        NSLog(@"swipeDidEnd xxxxxx kMoveRight");
    }
    
    cardView.transform = CGAffineTransformIdentity;
    [cardView layoutIfNeeded];
    
    // 현재 index
    if(kMoveLeft == direction){
        self.currentIndex += 1;
        //self.realCurrentIndex += 1;
    }else{
        self.currentIndex -= 1;
        //self.realCurrentIndex -= 1;
    }
    
    NSLog(@"%d", (int)self.currentIndex);
    
    [UIView animateWithDuration:0.1f animations:^{
        for(CardView *v in self.subviews){
            v.transform = CGAffineTransformIdentity;
            [v layoutIfNeeded];
            
            if(v.index == self.currentIndex){
                v.userInteractionEnabled = YES;
            }else{
                v.userInteractionEnabled = NO;
            }
            
            [self frameCardViews:v atIndex:v.index];
            
            // 화면 숨기 처리
            if(v.index < self.currentIndex - 2){
                v.hidden = YES;
            }else if(v.index > self.currentIndex + 2){
                v.hidden = YES;
            }else{
                v.hidden = NO;
            }
        }
        
        [self cardItem_add_and_remove];
        
        for(CardView *v in self.subviews){
            NSLog(@"zPosition index %d zPosition: %f", (int)v.index, v.layer.zPosition);
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.delegate SwipeCardView:cardView currentPage:self.currentIndex];
        });
        
        self.previousIndex = self.currentIndex;
        
        NSLog(@"self.currentIndex : %d", (int)self.currentIndex);
        
    }];
    
   
    
}

-(void) cardItem_add_and_remove {
    //. 삭제 왼쪽 아이템 삭제 하기
    if(self.currentIndex-3 > 0){
        NSInteger deleteItem = self.currentIndex-4;
        if(deleteItem >=0){
            NSLog(@"====>>>> delelte index %d", (int)deleteItem);
            for(CardView *v in self.subviews){
                if(v.index == deleteItem){
                    [v removeFromSuperview];
                    [self.cardViews removeObject:v];
                    NSLog(@"====>>>> delelte index ok--- %d", (int)deleteItem);
                    break;;
                }
            }
        }
        
    }
    
    // 왼쪽 아이템 추가하기
    if(self.currentIndex-3 >= 0){
        NSInteger addItem = self.currentIndex-3;
        if(addItem >=0){
            BOOL isExist = false;
           
            for(CardView *v in self.subviews){
                if(v.index == addItem){
                    isExist = true;
                    break;;
                }
            }
            
            if(!isExist){
                NSLog(@"====>>>> delelte index new --> addItem index %d", (int)addItem);
                CardView *view = [self.dataSource cardAtIndex:addItem];
                view.index = addItem;
                view.maxCardLegth = self.numberOfCards;
                view.delegate = (id)self;
                [self frameCardViews:view atIndex:addItem];
                view.userInteractionEnabled = NO;
                view.hidden = YES;
                if(self.numberOfCards-1 == addItem){
                    view.isLastCell = YES;
                }else{
                    view.isLastCell = NO;
                }
                
                [self.cardViews addObject:view];
                [self addSubview:view];
            }
        }
    }
    
    // 오른쪽 아이템 삭제 하기
    if(self.currentIndex+4 > self.cardsToBeVisible-1 && self.currentIndex+4 < self.numberOfCards){
        NSInteger removeItem = self.currentIndex+4;
        
        for(CardView *v in self.subviews){
            if(v.index == removeItem){
                [v removeFromSuperview];
                [self.cardViews removeObject:v];
                NSLog(@"====>>>> delelte index right ok--- %d", (int)removeItem);
                break;;
            }
        }
        
        NSLog(@"====>>>> delelte index right ok view item count--- %d", (int)self.subviews.count);
    }
    
    
    NSLog(@"====>>>> add index %d", (int)self.currentIndex+4);
    
    // 오른쪽 아이템 추가 하기
    if(self.currentIndex+4 > self.cardsToBeVisible-1 && self.currentIndex+4 < self.numberOfCards){
        NSInteger addItem = self.currentIndex+4;
        NSLog(@"====>>>> add index right check %d", (int)addItem);
        // add item
        BOOL isExist = false;
        
        for(CardView *v in self.subviews){
            if(v.index == addItem){
                isExist = true;
                break;
            }
        }
        
        if(!isExist){
            NSLog(@"====>>>> add index right ok--- %d", (int)addItem);
            CardView *view = [self.dataSource cardAtIndex:addItem];
            view.index = addItem;
            view.maxCardLegth = self.numberOfCards;
            view.delegate = (id)self;
            [self frameCardViews:view atIndex:addItem];
            view.userInteractionEnabled = NO;
            view.hidden = YES;
            if(self.numberOfCards-1 == addItem){
                view.isLastCell = YES;
            }else{
                view.isLastCell = NO;
            }
            
            [self.cardViews addObject:view];
            [self addSubview:view];
        }
        //NSLog(@"====>>>> delelte index right ok--- %d", (int)removeItem);
    }
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.0 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//        
//        
//        
//    });
}

-(void) actionCardView:(CardView*)cardView{
    
    [self.delegate SwipeCardView:cardView didSelectItemAtIndex:cardView.index];
}

-(void) swipeReset{
    _cardPadding = 40;
    _currentIndex = _previousIndex;
    [UIView animateWithDuration:0.5f animations:^{
        for(CardView *v in self.subviews){
            v.transform = CGAffineTransformIdentity;
            [v layoutIfNeeded];
            
            if(v.index == self.currentIndex){
                v.userInteractionEnabled = YES;
            }else{
                v.userInteractionEnabled = NO;
            }
            
            [self frameCardViews:v atIndex:v.index];
        }
    }];
}

//-(void) actionCardView:(CardView*)cardView message:(Message*) message{
//
//    if([message.name isEqualToString:@"cellclick"]){
//
//    }else{
//        [self.delegate SwipeActionCardView:cardView message:message];
//    }
//
//}

- (NSString *)hexStringFromColor:(UIColor *)color {
    const CGFloat *components = CGColorGetComponents(color.CGColor);

    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];

    return [NSString stringWithFormat:@"#%02lX%02lX%02lX",
            lroundf(r * 255),
            lroundf(g * 255),
            lroundf(b * 255)];
}
@end
