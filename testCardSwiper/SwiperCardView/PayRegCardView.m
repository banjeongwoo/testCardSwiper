//
//  payRegCardView.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/25.
//

#import "PayRegCardView.h"
@interface PayRegCardView()
@property(strong, nonatomic) UIStackView *stackView;
@property(strong, nonatomic) UIView *cardaddView;
@property(strong, nonatomic) UIImageView *carddAddImageView;
@property(strong, nonatomic) UILabel *cardAddLabel;
@property(strong, nonatomic) UIButton *cardAddButton;

@property(strong, nonatomic) UILabel *bankAddLabel;

@property(strong, nonatomic) UIImageView *backAddImageView;

@property(strong, nonatomic) UIView *backaddView;

@property(strong, nonatomic) UIButton *backAddButton;

@property(strong, nonatomic) UIButton *payMgrButton;
@property(strong, nonatomic) UIView *splitView;

@end

@implementation PayRegCardView 

- (void)dealloc {
    if (self){
        _stackView = nil;
        _cardaddView = nil;
        _carddAddImageView = nil;
        _cardAddLabel = nil;
        _cardAddButton = nil;

        _bankAddLabel = nil;

        _backAddImageView = nil;

        _backaddView = nil;

        _backAddButton = nil;

        _payMgrButton = nil;
        _splitView = nil;
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
    [self configureStackView];
    [self configurePayMgrButton];
    [super addPanGestureOnCards];
}

-(void) configureStackView {
   
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat iw = (width*28)/360;
    
    _stackView = [[UIStackView alloc] init];
    _stackView.layer.zPosition = 101;
    _stackView.backgroundColor = [UIColor blackColor];
    _stackView.distribution = UIStackViewDistributionFillEqually;
    _stackView.axis = UILayoutConstraintAxisHorizontal;
    [self.bgView addSubview:_stackView];
    
    _stackView.translatesAutoresizingMaskIntoConstraints = false;
    [_stackView.leadingAnchor constraintEqualToAnchor:self.bgView.leadingAnchor].active = true;
    [_stackView.trailingAnchor constraintEqualToAnchor:self.bgView.trailingAnchor].active = true;
    [_stackView.topAnchor constraintEqualToAnchor:self.bgView.topAnchor].active = true;
    [_stackView.bottomAnchor constraintEqualToAnchor:self.bgView.bottomAnchor constant:48].active = true;
    // -- card
    _cardaddView = [[UIView alloc] init];
    _cardaddView.backgroundColor = [UIColor whiteColor];
    
    _carddAddImageView = [[UIImageView alloc] init];
    _carddAddImageView.image = [UIImage imageNamed:@"icolpayaddcard"];
    [_cardaddView addSubview:_carddAddImageView];
    
    _carddAddImageView.translatesAutoresizingMaskIntoConstraints = false;
    [_carddAddImageView.topAnchor constraintEqualToAnchor:_cardaddView.topAnchor constant:34].active = true;
    [_carddAddImageView.widthAnchor constraintEqualToConstant:iw].active = true;
    [_carddAddImageView.heightAnchor constraintEqualToConstant:iw].active = true;
    [_carddAddImageView.centerXAnchor constraintEqualToAnchor:_cardaddView.centerXAnchor].active = true;
    
    
    _cardAddLabel = [[UILabel alloc] init];
    _cardAddLabel.text = @"카드 등록";
    //_cardAddLabel.textColor = [UIColor colorNamed:@"Gray300"];
    _cardAddLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    //_cardAddLabel.fontStyle = @"SUIT";
    _cardAddLabel.textColor = [UIColor blackColor];
    [_cardaddView addSubview:_cardAddLabel];
    _cardAddLabel.translatesAutoresizingMaskIntoConstraints = false;
    [_cardAddLabel.topAnchor constraintEqualToAnchor:_carddAddImageView.bottomAnchor constant:1].active = true;
    [_cardAddLabel.centerXAnchor constraintEqualToAnchor:_cardaddView.centerXAnchor].active = true;
    
    
    _cardAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cardAddButton.tag = 0;
   // _cardAddButton.name = @"cardAddButton";
    [_cardAddButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_cardaddView addSubview:_cardAddButton];
    
    _cardAddButton.translatesAutoresizingMaskIntoConstraints = false;
    [_cardAddButton.topAnchor constraintEqualToAnchor:_cardaddView.topAnchor].active = true;
    [_cardAddButton.leadingAnchor constraintEqualToAnchor:_cardaddView.leadingAnchor].active = true;
    [_cardAddButton.trailingAnchor constraintEqualToAnchor:_cardaddView.trailingAnchor].active = true;
    [_cardAddButton.bottomAnchor constraintEqualToAnchor:_cardaddView.bottomAnchor].active = true;
    
    
    [_stackView addArrangedSubview:_cardaddView];
    
    // -- bank
    _backaddView = [[UIView alloc] init];
    _backaddView.backgroundColor = [UIColor whiteColor];

    _backAddImageView = [[UIImageView alloc] init];
    _backAddImageView.image = [UIImage imageNamed:@"icolpayaddbank"];
    [_backaddView addSubview:_backAddImageView];
    
    _backAddImageView.translatesAutoresizingMaskIntoConstraints = false;
    [_backAddImageView.topAnchor constraintEqualToAnchor:_backaddView.topAnchor constant:34].active = true;
    [_backAddImageView.widthAnchor constraintEqualToConstant:iw].active = true;
    [_backAddImageView.heightAnchor constraintEqualToConstant:iw].active = true;
    [_backAddImageView.centerXAnchor constraintEqualToAnchor:_backaddView.centerXAnchor].active = true;
    
    _bankAddLabel = [[UILabel alloc] init];
    _bankAddLabel.text = @"계좌 등록";
    _bankAddLabel.textColor = [UIColor colorNamed:@"Gray300"];
    _bankAddLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    //_bankAddLabel.fontStyle = @"SUIT";
    _bankAddLabel.textColor = [UIColor blackColor];
    [_backaddView addSubview:_bankAddLabel];
    
    _bankAddLabel.translatesAutoresizingMaskIntoConstraints = false;
    [_bankAddLabel.topAnchor constraintEqualToAnchor:_backAddImageView.bottomAnchor constant:1].active = true;
    [_bankAddLabel.centerXAnchor constraintEqualToAnchor:_backaddView.centerXAnchor].active = true;
    
    
    _backAddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backAddButton.tag = 1;
    //_backAddButton.name = @"backAddButton";
    [_backAddButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_backaddView addSubview:_backAddButton];
    
    _backAddButton.translatesAutoresizingMaskIntoConstraints = false;
    [_backAddButton.topAnchor constraintEqualToAnchor:_backaddView.topAnchor].active = true;
    [_backAddButton.leadingAnchor constraintEqualToAnchor:_backaddView.leadingAnchor].active = true;
    [_backAddButton.trailingAnchor constraintEqualToAnchor:_backaddView.trailingAnchor].active = true;
    [_backAddButton.bottomAnchor constraintEqualToAnchor:_backaddView.bottomAnchor].active = true;

    [_stackView addArrangedSubview:_backaddView];
    
    // -- split
    _splitView = [[UIView alloc] init];
    //_splitView.backgroundColor = [UIColor rgbColorWithRed:238 green:238 blue:238 alpha:1];
    _splitView.layer.zPosition = 101;
    [self addSubview:_splitView];

    _splitView.translatesAutoresizingMaskIntoConstraints = false;
    [_splitView.topAnchor constraintEqualToAnchor:self.bgView.topAnchor constant:37].active = true;
    [_splitView.bottomAnchor constraintEqualToAnchor:self.bgView.bottomAnchor constant:-(48+37)].active = true;
    //[_splitView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = true;
    [_splitView.widthAnchor constraintEqualToConstant:1].active = true;
    [_splitView.centerXAnchor constraintEqualToAnchor:self.bgView.centerXAnchor].active = true;

}

-(void) configurePayMgrButton {
    _payMgrButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payMgrButton.tag = 3;
    _payMgrButton.layer.zPosition = 101;
    //_payMgrButton.name = @"payMgrButton";
    [_payMgrButton addTarget:self action:@selector(buttonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [_payMgrButton setTitle:@"결제수단 관리" forState:UIControlStateNormal];
    [_payMgrButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //_payMgrButton.titleFont = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    //_payMgrButton.fontStyle = @"SUIT";
   // _payMgrButton.backgroundColor = [UIColor rgbColorWithRed:247 green:247 blue:247 alpha:1];
    
    [self addSubview:_payMgrButton];
   
    _payMgrButton.translatesAutoresizingMaskIntoConstraints = false;
    [_payMgrButton.leadingAnchor constraintEqualToAnchor:self.bgView.leadingAnchor].active = true;
    [_payMgrButton.trailingAnchor constraintEqualToAnchor:self.bgView.trailingAnchor].active = true;
    [_payMgrButton.bottomAnchor constraintEqualToAnchor:self.bgView.bottomAnchor].active = true;
    [_payMgrButton.heightAnchor constraintEqualToConstant:48].active = YES;
   
}

- (void)buttonTouchUpInside:(UIButton *)button {
    
//    if([button.name isEqualToString:@"payMgrButton"]){
//        [self.delegate actionCardView:self message:[Message messageWithName:button.name object:nil]];
//    }else if([button.name isEqualToString:@"cardAddButton"]){
//        [self.delegate actionCardView:self message:[Message messageWithName:button.name object:nil]];
//    }else if([button.name isEqualToString:@"backAddButton"]){
//        [self.delegate actionCardView:self message:[Message messageWithName:button.name object:nil]];
//    }
    
}


@end
