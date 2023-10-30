//
//  PayRcmdCardView.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/25.
//

#import "PayRcmdCardView.h"
@interface PayRcmdCardView()
@property(strong, nonatomic) UIImageView *cardImageView;
@property(strong, nonatomic) UIButton *cardAddButton;
@end

@implementation PayRcmdCardView


- (void)dealloc {
    if (self){
        _cardImageView = nil;
        _cardAddButton = 0;
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
    [super initial];
    self.backgroundColor = [UIColor clearColor];
    [super addPanGestureOnCards];
    
    [self configureCardImageView];
    [self configureCardAddButton];
}


-(void) configureCardImageView {
    _cardImageView = [[UIImageView alloc] init];
    _cardImageView.image = [UIImage imageNamed:@"icolpaycard"];
    [self.bgView addSubview:_cardImageView];
    
    _cardImageView.translatesAutoresizingMaskIntoConstraints = false;
    [_cardImageView.topAnchor constraintEqualToAnchor:self.bgView.topAnchor].active = true;
    [_cardImageView.leadingAnchor constraintEqualToAnchor:self.bgView.leadingAnchor].active = true;
    [_cardImageView.trailingAnchor constraintEqualToAnchor:self.bgView.trailingAnchor].active = true;
    [_cardImageView.bottomAnchor constraintEqualToAnchor:self.bgView.bottomAnchor].active = true;
   
}

-(void) configureCardAddButton {
    _cardAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cardAddButton.tag = 0;
    _cardAddButton.backgroundColor = [UIColor colorWithRed:((float) 34 / 255.0f)
                                                    green:((float) 34 / 255.0f)
                                                     blue:((float) 34 / 255.0f)
                                                    alpha:1];
    [_cardAddButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_cardAddButton setTitle:@"카드 추가하기" forState:UIControlStateNormal];
    [_cardAddButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.bgView addSubview:_cardAddButton];
    
    _cardAddButton.translatesAutoresizingMaskIntoConstraints = false;
   
   
    [_cardAddButton.trailingAnchor constraintEqualToAnchor:self.bgView.trailingAnchor constant:-6].active = true;
    [_cardAddButton.bottomAnchor constraintEqualToAnchor:self.bgView.bottomAnchor constant:-10].active = true;
    [_cardAddButton.widthAnchor constraintEqualToConstant:109].active = YES;
    [_cardAddButton.heightAnchor constraintEqualToConstant:34].active = YES;
}

-(void) buttonClicked:(UIButton*)sender{
     NSLog(@"you clicked on button %d", (int)sender.tag);
}

@end
