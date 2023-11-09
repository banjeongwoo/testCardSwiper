//
//  ViewController.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/23.
//

#import "ViewController.h"
#import "SwipeCardView.h"
#import "PayRegCardView.h"
#import "PayRcmdCardView.h"
#import "CardDetailViewController.h"

#define USE_MAX_COUNT      4 //1000

@interface ViewController () <SwipeCardsDataSource>
@property(strong, nonatomic) SwipeCardView *swipeCardView;
@property(strong, nonatomic) NSArray *dataList;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UILabel *textlabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // self.itemSize = CGSizeMake(192*(width/360.0), 120*(width/360.0));
    //h: 248, height: 155.76)
    
    CGFloat w = 272*(width/360.0);
    CGFloat h = 180*(width/360.0);
    
    //_swipeCardView = [[SwipeCardView alloc] initWithFrame:CGRectMake((width-w)/2, 100, w, h)];
    //_swipeCardView.dataSource = (id)self;
    //_swipeCardView.delegate = (id)self;
    //[self.view addSubview:_swipeCardView];
    
    //_swipeCardView = [[SwipeCardView alloc] initWithFrame:CGRectMake((width-w)/2, 100, w, h)];
    
    _swipeCardView = [[SwipeCardView alloc] initWithFrame:CGRectMake(0, 100, w, h)];
    
    _swipeCardView.dataSource = (id)self;
    _swipeCardView.delegate = (id)self;
    [self.view addSubview:_swipeCardView];
    _dataList = @[
        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10",
        @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",

//        @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"40",
//
//        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"30",
//
//        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"40",
//
//        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"50",
//
//        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"60",
//
//        @"21", @"22", @"23", @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"38", @"39", @"70",
//
//        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"80",
//
//        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"90",
//
//        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"100"
    ];
    
//    _dataList = @[
//        @"1", @"2", @"3", @"4", @"5", @"6"
//    ];
    _swipeCardView.currentIndex = 1;
    [_swipeCardView reloadData];
    
    LPayMiddleBannerCollectionViewLayout *layout = [LPayMiddleBannerCollectionViewLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = 12;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(80, 80);
        
    [_collectionView setCollectionViewLayout:layout];
    
    
    //NSInteger cnt = _dataList.count;
 
    [_collectionView reloadData];
    
  
//    CGFloat updatedOffset = ((layout.itemSize.width + layout.minimumLineSpacing) * cnt) -  (40 + layout.minimumLineSpacing);
//    [self.collectionView setContentOffset:CGPointMake(updatedOffset, 0)];
//    layout.currentPage = cnt;
    
    //[_swipeCardView setCurrnetPositonIndex:1];
    
    NSString *cardMsg = @"결제할 때마다 ##최대 1.5% 적립##\n연간 ##240만P## **적립 가능!**이상해";
    
    NSString *msg = cardMsg;
    
    msg = [msg stringByReplacingOccurrencesOfString:@"##" withString:@""];
    msg = [msg stringByReplacingOccurrencesOfString:@"**" withString:@""];
    
    NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] init];

    @try {
        
        UIFont *font = [UIFont boldSystemFontOfSize:18];
        NSArray *tagList = @[@"##", @"**"]; // 파란색, 굵게
        BOOL isContinue = true;
        do{
            NSString *tag = @"";
            NSRange rangtag1 =[cardMsg rangeOfString:tagList[0]];
            NSRange rangtag2 =[cardMsg rangeOfString:tagList[1]];
            
            if(rangtag1.location != NSNotFound && rangtag2.location != NSNotFound){
                NSString *res;
                if(rangtag1.location > rangtag2.location ){
                    res = [[cardMsg substringFromIndex : 0] substringToIndex : rangtag2.location];
                    tag = tagList[1];
                    cardMsg = [cardMsg substringFromIndex : rangtag2.location];
                }else{
                    res = [[cardMsg substringFromIndex : 0] substringToIndex : rangtag1.location];
                    tag = tagList[0];
                    cardMsg = [cardMsg substringFromIndex : rangtag1.location];
                }
                NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:res];
                [mutableAttributedString appendAttributedString:attributedString];
                
                
                NSRange secondInstance = [[cardMsg substringFromIndex:tag.length] rangeOfString:tag];
                
                if(secondInstance.location != NSNotFound){
                    NSString *subStr = [[cardMsg substringFromIndex : tag.length] substringToIndex : secondInstance.location];
                   
                    if([tag isEqualToString:@"##"]){
                        NSDictionary *attrs = @{ NSForegroundColorAttributeName : [UIColor redColor] };
                        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:subStr attributes:attrs];

                        [mutableAttributedString appendAttributedString:attrStr];
                    }else {
                        NSDictionary *attrs = @{ NSFontAttributeName : font };
                        NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:subStr attributes:attrs];

                        [mutableAttributedString appendAttributedString:attrStr];
                    }
                    
                    cardMsg = [cardMsg substringFromIndex : secondInstance.location + secondInstance.length + tag.length];
                    NSLog(@"");
                }else{
                    break;
                }

            }else if(rangtag1.location != NSNotFound){
                tag = tagList[0];
                
                if(rangtag1.length !=0){
                    NSString *subStr = [[cardMsg substringFromIndex:0] substringToIndex : rangtag1.location];
                    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:subStr];
                    [mutableAttributedString appendAttributedString:attributedString];
                    
                    cardMsg = [cardMsg substringFromIndex : rangtag1.location];
                }
                
                NSRange secondInstance = [[cardMsg substringFromIndex:tag.length] rangeOfString:tag];
                
                if(secondInstance.location != NSNotFound){
                    NSString *subStr = [[cardMsg substringFromIndex : tag.length] substringToIndex : secondInstance.location];
                    NSDictionary *attrs = @{ NSFontAttributeName : font };
                    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:subStr attributes:attrs];

                    [mutableAttributedString appendAttributedString:attrStr];
                    
                    cardMsg = [cardMsg substringFromIndex : secondInstance.location + secondInstance.length + tag.length];
                }else{
                    break;
                }
            }else if(rangtag2.location != NSNotFound){
                
                if(rangtag2.length !=0){
                    NSString *subStr = [[cardMsg substringFromIndex:0] substringToIndex : rangtag2.location];
                    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:subStr];
                    [mutableAttributedString appendAttributedString:attributedString];
                    
                    cardMsg = [cardMsg substringFromIndex : rangtag2.location];
                }
                
                tag = tagList[1];
                NSRange secondInstance = [[cardMsg substringFromIndex:tag.length] rangeOfString:tag];
                
                NSLog(@"|%@|", cardMsg);
                
                if(secondInstance.location != NSNotFound){
                    NSString *subStr = [[cardMsg substringFromIndex : tag.length] substringToIndex : secondInstance.location];
                    NSDictionary *attrs = @{ NSFontAttributeName : font };
                    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:subStr attributes:attrs];

                    [mutableAttributedString appendAttributedString:attrStr];
                    
                    cardMsg = [cardMsg substringFromIndex : secondInstance.location + secondInstance.length + tag.length];
                }else{
                    cardMsg = @"";
                    break;
                }
            }else{
                
                UIFont *font = [UIFont systemFontOfSize:18];
                
                NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:cardMsg];
                
                NSDictionary *attrs = @{ NSFontAttributeName : font };
                NSAttributedString *attrStr = [[NSAttributedString alloc] initWithString:cardMsg attributes:attrs];

                
                [mutableAttributedString appendAttributedString:attributedString];
              
                cardMsg = @"";
                break;
            }
            
        }while(cardMsg.length);
        
#if 0
        for(NSString *tag in tagList){
    
            while ([cardMsg rangeOfString:tag].location != NSNotFound) {
                NSLog(@"%@", cardMsg);
                NSRange firstRange = [cardMsg rangeOfString:tag];
            
                NSRange secondInstance;// = [[cardMsg substringFromIndex:firstRange.location + firstRange.length] rangeOfString:tag];
                
//                if([tag isEqualToString:@"##**"]  ){
//                    secondInstance = [[cardMsg substringFromIndex:firstRange.location + firstRange.length] rangeOfString:@"**##"];
//                }else if([tag isEqualToString:@"**##"]){
//                    secondInstance = [[cardMsg substringFromIndex:firstRange.location + firstRange.length] rangeOfString:@"##**"];
//                }else{
//                    secondInstance = [[cardMsg substringFromIndex:firstRange.location + firstRange.length] rangeOfString:tag];
//                }
                
                secondInstance = [[cardMsg substringFromIndex:firstRange.location + firstRange.length] rangeOfString:tag];
                
                NSRange finalRange = NSMakeRange(firstRange.location, secondInstance.location);
                
                if([tag isEqualToString:@"##"]){ // 파란색
                    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value: [UIColor redColor] range:finalRange];
                }else if([tag isEqualToString:@"**"]){ // 굵게
                    [mutableAttributedString addAttribute:NSFontAttributeName value: font range:finalRange];
                }
//                else if([tag isEqualToString:@"##**"] || [tag isEqualToString:@"**##"] ){
//                    [mutableAttributedString addAttribute:NSForegroundColorAttributeName value: [UIColor redColor] range:finalRange];
//                    [mutableAttributedString addAttribute:NSFontAttributeName value: font range:finalRange];
//                }
//
                NSRange secondRange = NSMakeRange((finalRange.location + finalRange.length + tag.length), tag.length);
                
                cardMsg = [cardMsg stringByReplacingCharactersInRange:secondRange withString:@""];
                NSLog(@"%@", cardMsg);
                cardMsg = [cardMsg stringByReplacingCharactersInRange:firstRange withString:@""];
               
                NSLog(@"%@", cardMsg);
            }
                
                // NSString *cardMsg = @"결제할 때마다 ##최대 1.5% 적립##\n연간 ##240만P## 적립 가능!";
        }
        
#endif
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.description);
    }
    
    self.textlabel.attributedText = mutableAttributedString;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    [self.collectionView scrollToItemAtIndexPath: [NSIndexPath indexPathForRow:_dataList.count*2 inSection:0]
                                                atScrollPosition: UICollectionViewScrollPositionCenteredHorizontally
                                                        animated: NO];
    
}


- (nonnull __kindof CardView *)cardAtIndex:(NSInteger)index {
    
    if(index == 0){
        PayRegCardView *view = [[PayRegCardView alloc] init];
        [view setData:@(index)];
        return view;
    }else if(index == _dataList.count-1){
        PayRcmdCardView *view = [[PayRcmdCardView alloc] init];
        [view setData:@(index)];
        return view;
    } else{
        CardView *view = [[CardView alloc] init];
//        if(index == 0){
//            view.backgroundColor = [UIColor yellowColor];
//        }else if(index == 1){
//            view.backgroundColor = [UIColor purpleColor];
//        }else if(index == 2){
//            view.backgroundColor = [UIColor redColor];
//        }else if(index == 3){
//            view.backgroundColor = [UIColor blueColor];
//        }else if(index == 4){
//            view.backgroundColor = [UIColor orangeColor];
//        }else {
//            //view.backgroundColor = [UIColor greenColor];
//            view.backgroundColor = [UIColor colorWithRed:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
//                                                           green:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
//                                                            blue:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
//                                                   alpha:1];
//        }
        [view setData:@(index)];
        return view;
    }
    
//    CardView *view = [[CardView alloc] init];
//    if(index == 0){
//        view.backgroundColor = [UIColor yellowColor];
//    }else if(index == 1){
//        view.backgroundColor = [UIColor purpleColor];
//    }else if(index == 2){
//        view.backgroundColor = [UIColor redColor];
//    }else if(index == 3){
//        view.backgroundColor = [UIColor blueColor];
//    }else if(index == 4){
//        view.backgroundColor = [UIColor orangeColor];
//    }else {
//        view.backgroundColor = [UIColor greenColor];
//    }
//    [view setData:@(index)];
//    return view;
}

- (NSInteger)numberOfItems {
    return _dataList.count;
}

-(void) SwipeCardView:(CardView*)cardView currentPage:(NSInteger)page{
    NSLog(@"XXX currentPage %d", (int)page);
    
    
}

-(void) SwipeCardView:(CardView*) cardView didSelectItemAtIndex:(NSInteger) index{
    CardDetailViewController *controller = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CardDetailViewController"];
    controller.modalPresentationStyle = UIModalPresentationFullScreen;
   
    [controller setData:@(20)];
    //[controller setData:@(self.dataList.count)];
    [self.navigationController presentViewController:controller animated:YES completion:^{
        
    }];
    
//    [self.navigationController presentViewController:controller
//                                            animated:YES
//                                            completion:nil];
    
  
}

-(void) update:(NSInteger) idx{
    [_swipeCardView setCurrnetPositonIndex:idx];
}

-(void) scrollViewDidEndDecelerating: (UIScrollView*) scrollView {
    
    //
    LPayMiddleBannerCollectionViewLayout *layout = (LPayMiddleBannerCollectionViewLayout*)self.collectionView.collectionViewLayout;
    
    
    if(layout.currentPage == _dataList.count * (USE_MAX_COUNT -2) ){
        NSInteger item = _dataList.count * 2;
        [self.collectionView scrollToItemAtIndexPath: [NSIndexPath indexPathForRow:item inSection:0]
                                                    atScrollPosition: UICollectionViewScrollPositionCenteredHorizontally
                                                            animated: NO];
        
        layout.currentPage = item;
    } else if( layout.currentPage == _dataList.count){
        NSInteger item = _dataList.count * (USE_MAX_COUNT -2);
        
        [self.collectionView scrollToItemAtIndexPath: [NSIndexPath indexPathForRow:item inSection:0]
                                                    atScrollPosition: UICollectionViewScrollPositionCenteredHorizontally
                                                            animated: NO];
        
        layout.currentPage = item;
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataList.count * USE_MAX_COUNT;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LPayMiddleBannerCell" forIndexPath:indexPath];
   // [cell setData:_dataList[indexPath.item]];
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if(_dataList.count > 1){
////        CollectionViewFlowLayout *layout = (CollectionViewFlowLayout*)_collectionView.collectionViewLayout;
////        if (layout.currentPage == 0){
////            NSInteger item = _dataList.count*(kMaxItemCount-1);
////            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
////            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
////
////            layout.currentPage = item;
////        }else if (layout.currentPage == (_dataList.count * kMaxItemCount) - 1){
////            NSInteger item = _dataList.count;
////            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
////            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
////
////            layout.currentPage = item;
////        }
//    }
//}


@end

@implementation LPayMiddleBannerCell

-(void) didLoad {
    self.contentView.backgroundColor = [UIColor yellowColor];
}


@end



#pragma mark - LPayCardCollectionViewLayout
@interface LPayMiddleBannerCollectionViewLayout ()

@property (nonatomic) BOOL isSetup;
@property (nonatomic, assign) CGFloat spaceing;
@property (nonatomic, assign) CGFloat sideItemScale;
@property (nonatomic, assign) CGFloat sideItemAlpha;

@property (nonatomic, assign) CGFloat previousOffset;

@property (nonatomic, strong) NSMutableArray *layoutAttributes;

@property (nonatomic, assign) CGFloat centerOffset;
@end

@implementation LPayMiddleBannerCollectionViewLayout

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.isSetup = NO;
        
        self.spaceing = 12;
        self.sideItemScale = 1.0f;
        self.sideItemAlpha = 1.0f;
        self.currentPage = 0;
        
        _layoutAttributes = [NSMutableArray new];
        
//        self.previousOffset = 0;
//        self.currentPage = 0;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    if(!self.isSetup){
        [self setupLayout];
        self.isSetup = YES;
    }
    
    CGFloat offset = 0;
    CGFloat width = self.collectionView.bounds.size.width;
    NSInteger numberOfItem = (NSInteger)[self.collectionView numberOfItemsInSection:0];
    for(int i = 0; i < numberOfItem; i++){
        if(width < i*(self.itemSize.width+self.minimumLineSpacing)){
            offset = (i-1)*(self.itemSize.width+self.minimumLineSpacing);
            
            offset = ceil(width - offset)/2.0f + (self.itemSize.width/2.0f+self.minimumLineSpacing);
            offset = offset - (self.itemSize.width + self.minimumLineSpacing);
            
            //offset = offset - (self.itemSize.width + self.minimumLineSpacing)*self.sideItemScale;
            offset = offset + (self.itemSize.width + self.minimumLineSpacing)*2; // 0을 중간으로
            break;
        }
    }
    
    _centerOffset = offset;
}

- (void) setupLayout {
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.itemSize = CGSizeMake(80, 80);
    self.spaceing = 12;
    self.sideItemScale = 1.0f;
    self.sideItemAlpha = 1.0f;
    self.minimumLineSpacing = self.spaceing;
    //self.minimumLineSpacing = self.spaceing - (self.itemSize.width-(self.itemSize.width*self.sideItemScale))/2.0;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0;
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    NSMutableArray *attributes = [@[] mutableCopy];
    NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    [attributes addObjectsFromArray:layoutAttributes];
    
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    CGFloat collectionCenter = self.collectionView.frame.size.width/2;
    CGFloat contentOffset = self.collectionView.contentOffset.x;

//    CGFloat offset = 0;
//    CGFloat width = self.collectionView.bounds.size.width;
//    NSInteger numberOfItem = (NSInteger)[self.collectionView numberOfItemsInSection:0];
//    for(int i = 0; i < numberOfItem; i++){
//        if(width < i*(self.itemSize.width+self.minimumLineSpacing)){
//            offset = (i-1)*(self.itemSize.width+self.minimumLineSpacing);
//
//            offset = ceil(width - offset)/2.0f + (self.itemSize.width/2.0f+self.minimumLineSpacing);
//            //offset = offset - (self.itemSize.width + self.minimumLineSpacing);
//
//            offset = offset - (self.itemSize.width + self.minimumLineSpacing)*self.sideItemScale;
//            offset = offset + (self.itemSize.width + self.minimumLineSpacing)*2; // 0을 중간으로
//            break;
//        }
//    }
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        CGRect frame = attribute.frame;
        frame.origin.y = 0;
        
//        if(attribute.indexPath.item < _currentPage+2){
//            frame.origin.x += offset - self.minimumLineSpacing;
//        }else if(attribute.indexPath.item > _currentPage+3){
//            frame.origin.x += offset + self.minimumLineSpacing;
//        }else{
//            frame.origin.x += offset;
//        }
        
        frame.origin.x += _centerOffset;
        
        attribute.frame = frame;
        
        if (CGRectIntersectsRect(attribute.frame, rect)) {
            CGFloat center = attribute.center.x - contentOffset;
            CGFloat maxDistance = self.itemSize.width + self.minimumLineSpacing;
            CGFloat distance = MIN(ABS(collectionCenter - center), maxDistance);
            
            CGFloat ratio = (maxDistance - distance)/maxDistance;

            CGFloat scale = ratio * (1 - self.sideItemScale) + self.sideItemScale;
            
            CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity, scale, scale);
            attribute.transform = transform;
        }
    }
    
    return attributes;
}

//setCollectionViewContentSize
- (CGSize)collectionViewContentSize {
    NSInteger numberOfItem = (NSInteger)[self.collectionView numberOfItemsInSection:0];
   
    CGFloat collectionViewWidth = (numberOfItem+3)*(self.itemSize.width + self.minimumLineSpacing) + _centerOffset;

   return CGSizeMake(collectionViewWidth, 80);
 }

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    if (CGPointEqualToPoint(velocity, CGPointZero)){
        _currentPage = roundf(proposedContentOffset.x / ((self.itemSize.width + self.minimumLineSpacing)));
    }

    NSInteger itemsCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    
    if  ((_previousOffset > self.collectionView.contentOffset.x) && (velocity.x < 0)) {
        _currentPage = MAX(_currentPage - 1, 0);
    }else if ((_previousOffset < self.collectionView.contentOffset.x) && (velocity.x > 0)) {
        _currentPage = MIN(_currentPage + 1, itemsCount - 1);
    }
    
    NSLog(@"%f %f %f", self.minimumLineSpacing, self.itemSize.width, _currentPage);
    
    CGFloat updatedOffset = ((self.itemSize.width + self.minimumLineSpacing) * _currentPage);
    
    _previousOffset = updatedOffset;
    CGPoint updatedPoint = CGPointMake(updatedOffset, proposedContentOffset.y);
    return updatedPoint;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
@end
