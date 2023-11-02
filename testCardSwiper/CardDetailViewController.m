//
//  CardDetailViewController.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//

#import "CardDetailViewController.h"
#import "ViewController.h"
#import "UIColor+Extension.h"

@interface CardDetailViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *dataList;

@end

@implementation CardDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.layer.zPosition = 100000;
    
    //CGFloat w = [[UIScreen mainScreen] bounds].size.width;

//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
//    layout.minimumInteritemSpacing = 0;
//    layout.itemSize = CGSizeMake(w-60, 300);
//    [_collectionView setCollectionViewLayout:layout];
    
//    StickCollectionViewFlowLayout *flowLayout = [[StickCollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(w-60, 150)];
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
//    flowLayout.minimumInteritemSpacing = -20;
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//  //  flowLayout.firstItemTransform = 30;
//    [_collectionView setCollectionViewLayout:flowLayout];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGSize itemSize = CGSizeMake(width-60, 185*(width/360));
    
    StickCollectionViewFlowLayout *layout = [StickCollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumLineSpacing = -42;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = itemSize;
    
    [_collectionView setCollectionViewLayout:layout];
    
  
    _collectionView.backgroundColor = [UIColor whiteColor];
}

-(void) setData:(id) data{
//    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
//    StickCollectionViewFlowLayout *flowLayout = [[StickCollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(w-60, 300)];
//    flowLayout.minimumInteritemSpacing = 0;
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    [_collectionView setCollectionViewLayout:flowLayout];
    
    NSInteger count = [data integerValue];
    
    NSMutableArray *array = [NSMutableArray array];
    for(int i=0; i<count; i++){
        [array addObject:@(i)];
    }
    
    _dataList = [array mutableCopy];
    
   
  
    
    
//    CGFloat diff = self.collectionView.frame.size.height - self.collectionView.contentSize.height;
//    if (diff > 0) {
//        self.collectionView.contentInset = UIEdgeInsetsMake(diff, 0, 0, 0);
//    }
    
    //[_collectionView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        
        [self.collectionView performBatchUpdates:^{
            //invalidateLayout
           
        } completion:^(BOOL finished) {
            if(finished){
//
//                CGFloat maxContentOffset =  self.collectionView.contentSize.height - self.collectionView.bounds.size.height + self.collectionView.contentInset.bottom;
//
//                //[self.collectionView setContentOffset:CGPointMake(0, maxContentOffset)];
//                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataList.count-1 inSection:0];
//                [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
               
    //            [self.collectionView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    //            [self.collectionView layoutIfNeeded];
    //            [self.collectionView setNeedsLayout];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(600 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
//                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataList.count-1 inSection:0];
//                    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
                    
                });
            }
            
        }];
    });
}

- (void)viewWillLayoutSubviews {
//    CGFloat h = self.collectionView.frame.size.height;
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)_collectionView.collectionViewLayout;
//    CGFloat cellOffset = (layout.itemSize.height - layout.minimumLineSpacing);
//
//    if(cellOffset*_dataList.count < h){
//        CGFloat top = h - cellOffset*_dataList.count + layout.minimumLineSpacing;
//        self.collectionView.contentInset = UIEdgeInsetsMake(top,0,0,0);
//    }
//
//    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataList.count-1 inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:NO];
}

- (IBAction)buttonUpInside:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}
#pragma UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CardViewCell";
    CardViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(indexPath.item%5 == 0){
        cell.contentView.backgroundColor = [UIColor yellowColor];
    }else if(indexPath.item%5 == 1){
        cell.contentView.backgroundColor = [UIColor purpleColor];
    }else if(indexPath.item%5 == 2){
        cell.contentView.backgroundColor = [UIColor redColor];
    }else if(indexPath.item%5 == 3){
        cell.contentView.backgroundColor = [UIColor blueColor];
    }else if(indexPath.item%5 == 4){
        cell.contentView.backgroundColor = [UIColor orangeColor];
    }else {
        cell.contentView.backgroundColor = [UIColor orangeColor];
    }
    
    cell.contentView.layer.cornerRadius = 8;
    cell.contentView.layer.masksToBounds = true;
    cell.titleLabel.text = [NSString stringWithFormat:@"%lu", indexPath.item];
    return cell;
}

#pragma UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *selected = [self.tracks objectAtIndex:indexPath.row];
    //NSLog(@"selected=%@", selected);
    
    UIViewController *rootView = UIApplication.sharedApplication.keyWindow.rootViewController;
    ViewController *topViewController = (ViewController*) rootView.navigationController.topViewController;
   
    [self dismissViewControllerAnimated:YES completion:^{
        //[topViewController update:indexPath.item];
    }];
    
}

//cardViewCell

#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat width = UIScreen.mainScreen.bounds.size.width;
//    return CGSizeMake(width-60, 150);
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 30, 0, 30);
//}
//
////
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    //return -48;
//    return -20;
//}

@end
@interface StickCollectionViewFlowLayout()
@property (nonatomic, assign) CGFloat prePosY;
@property(nonatomic)CGFloat lastContentOffsetY;

@property(nonatomic)NSInteger seqIndex;
@property(nonatomic)CGFloat ltemOffset;

@property(nonatomic) BOOL isSetup;
@property(nonatomic,strong) NSMutableArray *layoutAttributes;
@end

@implementation StickCollectionViewFlowLayout

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        _lastContentOffsetY = 0;
        _seqIndex = 0;
        
        _ltemOffset = 50;
        _layoutAttributes = nil;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    
//    if(!self.isSetup){
//
//        _layoutAttributes = [NSMutableArray new];
//        NSInteger numberOfItem = (NSInteger)[self.collectionView numberOfItemsInSection:0];
//
//        for(int i=0; i < numberOfItem; i++){
//            NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
//            [self updateCellAttributes:attributes delta:0.f];
//            [_layoutAttributes addObject:attributes];
//        }
//        self.isSetup = YES;
//    }
   
    //NSLog(@"====>>>>>> prepareLayout");
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *oldItems = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allItems = [[NSMutableArray alloc]initWithArray:oldItems copyItems:YES];
    
    NSInteger startidx = -1;
  //  NSLog(@"layoutAttributesForElementsInRect start");
    _prePosY = 0.0f;
   // NSLog(@"scroll diff : %f", self.collectionView.contentOffset.y - _lastContentOffsetY);
    
    //    NSInteger topVisibleCardIndex = (int)fabs(self.collectionView.contentOffset.y)/self.itemSize.height;
    //    NSInteger lastVisibleCardIndex = (int) (fabs(self.collectionView.contentOffset.y)+self.collectionView.bounds.size.height)/self.itemSize.height;
    //    NSInteger lastCardIndex = (int)[self.collectionView numberOfItemsInSection:0];
    //
    //    if(lastVisibleCardIndex >= lastCardIndex)  { lastVisibleCardIndex = lastCardIndex; }
    //
    //    if(self.collectionView.contentOffset.y < 0) { topVisibleCardIndex = 0; }
    //
    //    for(int index = (int)topVisibleCardIndex; index < (int)lastVisibleCardIndex; index++){
    //
    //        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //
    //        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
    //
    
    
//    for (UICollectionViewLayoutAttributes *attribute in allItems) {
//
//       // NSLog(@"all index startidx %lu", attribute.indexPath.row);
//        if (CGRectIntersectsRect(attribute.frame, rect)) {
//            if(startidx == -1){
//                startidx = (int)attribute.indexPath.row;
//              //  NSLog(@"startidx %lu", startidx);
//            }
//
//            [self updateCellAttributes:attribute startidx:startidx];
//        }
//    }
    
    //NSLog(@"%f %f %f",  self.collectionView.contentSize.height, self.collectionView.bounds.size.height, self.collectionView.contentInset.bottom);
    CGSize contentSize = [self collectionViewContentSize];
    
    CGFloat maxContentOffset = contentSize.height - self.collectionView.bounds.size.height + self.collectionView.contentInset.bottom; // 전체 스크롤 오프셋
    
    NSInteger numberOfItem = (NSInteger)[self.collectionView numberOfItemsInSection:0];
    CGFloat itemRange = maxContentOffset/numberOfItem; // 카드 한장 이동 할 수 있는 거리
    
    CGFloat contentOffset = self.collectionView.contentOffset.y; // 현재 위치
     
    NSInteger curItemPos = (NSInteger)contentOffset/itemRange; // 현자 아아템 포지션
  
  
    _ltemOffset = 100;
    CGFloat itmeHeight = _ltemOffset;
    CGFloat delta = MIN(((contentOffset-curItemPos*itemRange)/itemRange)*itmeHeight, itmeHeight);
    
    NSMutableArray *layoutAttributes = [NSMutableArray new];
    for(int i=0; i < numberOfItem; i++){
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self updateCellAttributes:attributes curItemPos:curItemPos];
        
//        attributes.zIndex = attributes.indexPath.row;
//        CGPoint origin = attributes.frame.origin;
//        if(attributes.indexPath.row > 0 && curItemPos < 4){
//            if(contentOffset > 0){
//                origin.y = origin.y-delta;
//            }
//        }
        
        [layoutAttributes addObject:attributes];
    }
    
    if(curItemPos > 3) { // 4장이상인경우 하나씩 지워 저야한다.
        CGFloat y = 0;
        for(UICollectionViewLayoutAttributes *attributes in layoutAttributes){
            CGPoint origin = attributes.frame.origin;
            
//            if(y == 0){
//                
//                y = origin.y;
//            }else{
//                origin.y = (y-self.minimumLineSpacing);
//            }
            origin.y -= (itmeHeight*(curItemPos-4) + delta);
            
            if(attributes.indexPath.item > 3){
                origin.y -= itmeHeight;
            }
            
            //NSLog(@"cur %lu _ %f",attributes.indexPath.item,  origin.y);
            attributes.frame = (CGRect){origin, attributes.frame.size};
            
           // y = CGRectGetMaxY(attributes.frame);
            
            NSLog(@"%lu ---->>>>>> %@", attributes.indexPath.item, NSStringFromCGRect( attributes.frame ));
        }
    }
    
    
    
    return layoutAttributes;
    
    
    

    
   // NSLog(@"pp --- %f %lu itemOffsetCnt %lu", pp, curItem, itemOffsetCnt);
   
     
 
  //  NSLog(@"=====>> %lu , %f",curItemPos, pp);
    
   // CGFloat y = 0;
    
    //for(UICollectionViewLayoutAttributes *attributes in layoutAttributes){
   // CGFloat minY = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
//    y = 0;
//    CGFloat pointY = curItemPos*itmeD;
//    // 하나씩 위로 또 아래로
//    if(contentOffset > 0 && curItemPos > 3) {
//        for(UICollectionViewLayoutAttributes *attributes in layoutAttributes){
//
//            CGPoint origin = attributes.frame.origin;
//
//            origin.y -= (pointY+pp);
//
//            attributes.frame = (CGRect){origin, attributes.frame.size};
//        }
//    }
    
    //for(int i=0; i < numberOfItem; i++){
    
    
    
    //NSLog(@"--,%lu", idex);
    
//    if(contentOffset > 0 && curItem > 3 ){
////        [UIView animateWithDuration:0.2f animations:^{
////
////        }];
//
//
//        CGFloat pointY = (curItem-1)*itmeD;
//
//        //CGFloat curPointOffset = (itmeD*3 + pp*itmeD);
//        CGFloat curPointOffset = (pp*itmeD);
//
//        NSLog(@"pointY --- %f %lu", pointY, curItem);
//
//        for(UICollectionViewLayoutAttributes *attributes in layoutAttributes){
//            CGPoint origin = attributes.frame.origin;
//
////                if(curItem == numberOfItem){
////                    origin.y -= pointY - 20;
////                }else{
////                    origin.y -= (pointY - (60 + pp*20));
////                }
//
//            //origin.y -= (pointY - curPointOffset);
//            if(attributes.indexPath.item == 0){
//                NSLog(@"Y; %f", origin.y);
//            }
//
//            //origin.y -= (pp*itmeD);//(pointY + curPointOffset);//(pointY - curPointOffset);
//
//
//
//
//            attributes.frame = (CGRect){origin, attributes.frame.size};
//
//            [layoutAttributes addObject:attributes];
//        }
//    }
    
    
    
    
 //   _lastContentOffsetY = self.collectionView.contentOffset.y;
   // NSLog(@"layoutAttributesForElementsInRect end");
//
//    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        UICollectionViewLayoutAttributes *attributes = obj;
//
//
//
//        if(startidx == -1){
//            startidx = attributes.indexPath.row;
//            NSLog(@"startidx %d", startidx);
//        }
//
//        [self updateCellAttributes:attributes];
//    }];
    
}

- (void)updateCellAttributes:(UICollectionViewLayoutAttributes *) attributes curItemPos:(NSInteger) curItemPos{
    CGFloat contentOffset = self.collectionView.contentOffset.y;

    CGFloat minY = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
    CGFloat maxY = attributes.frame.origin.y;
    CGFloat finalY = MAX(minY, maxY);

    CGPoint origin = attributes.frame.origin;

    if(curItemPos > 0 && contentOffset >= self.ltemOffset){
       // NSLog(@"%lu", attributes.indexPath.row);
       finalY += (attributes.indexPath.row*self.ltemOffset);
        //finalY += (attributes.indexPath.row*self.ltemOffset - delta);
    }

    origin.y = finalY;
    attributes.frame = (CGRect){origin, attributes.frame.size};
    attributes.zIndex = attributes.indexPath.row;

}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end

//@interface StickCollectionViewFlowLayout()
//@property (nonatomic, strong) NSMutableArray *arrayCache;
//@property (nonatomic, assign) CGFloat dragOffset;
//
//@property (nonatomic, assign) CGFloat contentHeigth;
//
//@property (nonatomic, assign) NSInteger prelastPos;
//@property (nonatomic, assign) CGFloat preOffset;
//@end
////https://github.com/matbeich/StickyCollectionView/blob/master/StickCollectionView/Source/StickCollectionViewFlowLayout.m
//@implementation StickCollectionViewFlowLayout
//
//
//- (instancetype)initWithCoder:(NSCoder *)coder {
//    self = [super initWithCoder:coder];
//    if (self) {
//        _prePos = 0;
//    }
//    return self;
//}
//
//- (void)prepareLayout {
//    [super prepareLayout];
//    _startIdx = -1;
//    //_prePos = 0;
//
//   // _lastPos = 0;
//
////    _standardHeight = 150;
////    _featuredHeight = 150;
//
////    _dragOffset = 380;
////    _contentHeigth = 500;
//
////    self.minimumLineSpacing = 0;
////    CGFloat width = UIScreen.mainScreen.bounds.size.width;
////    self.itemSize = CGSizeMake(width-60, 185*(width/360));
//   // self.itemSize = CGSizeMake(width-60, 150);
//
//   // NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
//
//
////        if(itemSize.height*_dataList.count < _collectionView.bounds.size.height){
////
////        }
//}
//
////- (CGSize)collectionViewContentSize {
////    CGFloat width = UIScreen.mainScreen.bounds.size.width;
////    return CGSizeMake(width-60, _contentHeigth);
////}
//
//- (NSArray<__kindof UICollectionViewLayoutAttributes *> *) layoutAttributesForElementsInRect:(CGRect)rect {
//
//    NSMutableArray *attributes = [@[] mutableCopy];
//    NSArray *layoutAttr = [super layoutAttributesForElementsInRect:rect];
//    [attributes addObjectsFromArray:layoutAttr];
//
////    NSLog(@"attributes.count : %lu", attributes.count);
////    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
////    NSInteger featuredItemIndex = MAX(0, (int)(self.collectionView.contentOffset.y/_dragOffset));
//
//  //  CGFloat nextItemPercentageOffset = (self.collectionView.contentOffset.y / _dragOffset) - (CGFloat)featuredItemIndex;
//
////    CGFloat y = 0;
//
//   // CGFloat width = UIScreen.mainScreen.bounds.size.width;
//
////    NSInteger topVisibleCardIndex = (int)fabs(self.collectionView.contentOffset.y)/(_featuredHeight-50);
////    NSLog(@"jwban featuredItemIndex %lu nextItemPercentageOffset: %lu", featuredItemIndex,lastVisibleCardIndex);
//    NSLog(@"jwban layoutAttributesForElementsInRect !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
//
//
//    CGFloat contentOffset = self.collectionView.contentOffset.y;
//    CGFloat maxContentOffset =  self.collectionView.contentSize.height - self.collectionView.bounds.size.height + self.collectionView.contentInset.bottom;
//    NSInteger lastVisibleCardIndex = (NSInteger) (fabs(self.collectionView.contentOffset.y)+self.collectionView.bounds.size.height)/(self.itemSize.height-self.minimumLineSpacing);
//
////    if(contentOffset == 0){
////        lastVisibleCardIndex = 0;
////    }
//
//    CGFloat offsetDiff = maxContentOffset - contentOffset;
//
//    if(_preOffset != 0){
//        offsetDiff = _preOffset - contentOffset;
//       // NSLog(@"xxx=======>>>>> %f %f %f" , _preOffset , contentOffset, offsetDiff);
//    }
//
//   // CGFloat itemY = (self.itemSize.height-self.minimumLineSpacing)*lastVisibleCardIndex + self.collectionView.bounds.size.height;
//
//    CGFloat normalizedCenter = offsetDiff;
//
//    //((maxContentOffset - contentOffset)/((self.itemSize.height-self.minimumLineSpacing)*lastVisibleCardIndex))*300.0f;
//    if(contentOffset == 0){
//       // normalizedCenter = 30;
//    }
//
//    if(lastVisibleCardIndex != 0 && _prePos != lastVisibleCardIndex){
//        _preOffset = contentOffset;
//        NSLog(@"lastVisibleCardIndex change item %lu pre %lu _preOffset : %f", lastVisibleCardIndex, _prePos, _preOffset);
//        _prePos = lastVisibleCardIndex;
//    }
//
//    if(lastVisibleCardIndex == 0){
//        NSLog(@"lastVisibleCardIndex");
//    }
//
//    NSLog(@"lastVisibleCardIndex %lu  -- %f",lastVisibleCardIndex, normalizedCenter);
//
//   // NSLog(@"clastVisibleCardIndex %f t %lu b %lu c %f",contentOffset, topVisibleCardIndex, lastVisibleCardIndex, normalizedCenter);
//
//    for (UICollectionViewLayoutAttributes *attribute in attributes) {
//        //CGRect frame = attribute.frame;
//        attribute.zIndex = attribute.indexPath.item;
//
//        if(maxContentOffset == contentOffset){
//            attribute.transform = CGAffineTransformIdentity;
//        }else if (offsetDiff != 0 && attribute.indexPath.item >= lastVisibleCardIndex && normalizedCenter > 0){
//            CGFloat y = MAX(-normalizedCenter, -20);
//            y = y*(attribute.indexPath.item-lastVisibleCardIndex);
//            NSLog(@"===== normalizedCenter %f", y);
//            attribute.transform = CGAffineTransformMakeTranslation(0, y);
//        }else {
//            attribute.transform = CGAffineTransformIdentity;
//        }
//    }
//
//
//    if(fabs(normalizedCenter) >= 0){
//
//    }
//
////    NSLog(@"jwban layoutAttributesForElementsInRect !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! end");
////    NSLog(@"jwban layoutAttributesForElementsInRect !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! end");
////    NSLog(@"jwban layoutAttributesForElementsInRect !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! end");
//
//
//    return attributes;
//    //return layoutAttributes;
//}
//
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}
//
//@end



@interface CardViewCell()

@end

@implementation CardViewCell

@end











////
////  CardDetailViewController.m
////  testCardSwiper
////
////  Created by MI00363 on 2023/10/30.
////
//
//#import "CardDetailViewController.h"
//#import "ViewController.h"
//#import "UIColor+Extension.h"
//
//@interface CardDetailViewController ()
//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (strong, nonatomic) NSArray *dataList;
//
//@end
//
//@implementation CardDetailViewController
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    //self.view.layer.zPosition = 100000;
//
//    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
//
////    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
////    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
////    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
////    layout.minimumInteritemSpacing = 0;
////    layout.itemSize = CGSizeMake(w-60, 300);
////    [_collectionView setCollectionViewLayout:layout];
//
////    StickCollectionViewFlowLayout *flowLayout = [[StickCollectionViewFlowLayout alloc] init];
////    [flowLayout setItemSize:CGSizeMake(w-60, 300)];
////    flowLayout.minimumInteritemSpacing = 0;
////    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
////    flowLayout.firstItemTransform = 30;
////    [_collectionView setCollectionViewLayout:flowLayout];
//
//
//    _collectionView.backgroundColor = [UIColor whiteColor];
//
//
//}
//
//-(void) setData:(id) data{
////    CGFloat w = [[UIScreen mainScreen] bounds].size.width;
////    StickCollectionViewFlowLayout *flowLayout = [[StickCollectionViewFlowLayout alloc] init];
////    [flowLayout setItemSize:CGSizeMake(w-60, 300)];
////    flowLayout.minimumInteritemSpacing = 0;
////    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
////    [_collectionView setCollectionViewLayout:flowLayout];
//
//    NSInteger count = [data integerValue];
//
//    NSMutableArray *array = [NSMutableArray array];
//    for(int i=0; i<count; i++){
//        [array addObject:@(i)];
//    }
//
//    _dataList = [array mutableCopy];
//
//    [_collectionView reloadData];
//
//
////    CGFloat diff = self.collectionView.frame.size.height - self.collectionView.contentSize.height;
////    if (diff > 0) {
////        self.collectionView.contentInset = UIEdgeInsetsMake(diff, 0, 0, 0);
////    }
//
//    //[_collectionView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
//
//
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1000 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
////        [self.collectionView performBatchUpdates:^{} completion:^(BOOL finished) {
////
////
////        }];
//      //  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataList.count-1 inSection:0];
//      //  [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
//
//        [self.collectionView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
//    });
//
//
//
////    func scrollToLastItem(at scrollPosition: UICollectionViewScrollPosition = .centeredHorizontally, animated: Bool = true) {
////           let lastSection = numberOfSections - 1
////           guard lastSection >= 0 else { return }
////           let lastItem = numberOfItems(inSection: lastSection) - 1
////           guard lastItem >= 0 else { return }
////           let lastItemIndexPath = IndexPath(item: lastItem, section: lastSection)
////           scrollToItem(at: lastItemIndexPath, at: scrollPosition, animated: animated)
////       }
//
//
//
////    CGSize contentSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
////    if (contentSize.height > self.collectionView.bounds.size.height) {
////        CGPoint targetContentOffset = CGPointMake(0.0f, contentSize.height - self.collectionView.bounds.size.height);
////        [self.collectionView setContentOffset:targetContentOffset];
////    }
//
////    CGSize contentSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
////        if (contentSize.height > self.collectionView.bounds.size.height) {
////            CGPoint targetContentOffset = CGPointMake(0.0f, contentSize.height - self.collectionView.bounds.size.height);
////            [self.collectionView setContentOffset:targetContentOffset];
////        }
//}
//
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//
//    // ---- autolayout ----
//    [self.view layoutIfNeeded];
//
//
////    CGSize contentSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
////    if (contentSize.height > self.collectionView.bounds.size.height) {
////        CGPoint targetContentOffset = CGPointMake(0.0f, contentSize.height - self.collectionView.bounds.size.height);
////        [self.collectionView setContentOffset:targetContentOffset];
////    }
//
////    CGSize contentSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
////       if (contentSize.height > self.collectionView.bounds.size.height) {
////           CGPoint targetContentOffset = CGPointMake(0.0f, contentSize.height - self.collectionView.bounds.size.height);
////           [self.collectionView setContentOffset:targetContentOffset];
////       }
//
////    CGFloat diff = self.collectionView.frame.size.height - self.collectionView.contentSize.height;
////    if (diff > 0) {
////        self.collectionView.contentInset = UIEdgeInsetsMake(diff, 0, 0, 0);
////    }
//}
//
//- (IBAction)buttonUpInside:(id)sender {
//    [self dismissViewControllerAnimated:NO completion:nil];
//}
//#pragma UICollectionViewDataSource
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.dataList.count;
//}
//
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"CardViewCell";
//    CardViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
//
//    if(indexPath.item%5 == 0){
//        cell.contentView.backgroundColor = [UIColor yellowColor];
//    }else if(indexPath.item%5 == 1){
//        cell.contentView.backgroundColor = [UIColor purpleColor];
//    }else if(indexPath.item%5 == 2){
//        cell.contentView.backgroundColor = [UIColor redColor];
//    }else if(indexPath.item%5 == 3){
//        cell.contentView.backgroundColor = [UIColor blueColor];
//    }else if(indexPath.item%5 == 4){
//        cell.contentView.backgroundColor = [UIColor orangeColor];
//    }else {
//        //view.backgroundColor = [UIColor greenColor];
//       // cell.contentView.backgroundColor = [UIColor rgbColorWithRed:index%255) green:<#(float)#> blue:<#(float)#> alpha:<#(float)#>]
//
//        [UIColor colorWithRed:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
//                                                       green:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
//                                                        blue:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
//                                               alpha:1];
//    }
//
//    cell.contentView.layer.cornerRadius = 28;
//    cell.contentView.layer.masksToBounds = true;
//    cell.titleLabel.text = [NSString stringWithFormat:@"%lu", indexPath.item+1];
//    return cell;
//}
//
//#pragma UICollectionViewDelegate
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    //NSString *selected = [self.tracks objectAtIndex:indexPath.row];
//    //NSLog(@"selected=%@", selected);
//
//    UIViewController *rootView = UIApplication.sharedApplication.keyWindow.rootViewController;
//    ViewController *topViewController = (ViewController*) rootView.navigationController.topViewController;
//
//    [self dismissViewControllerAnimated:YES completion:^{
//        [topViewController update:indexPath.item];
//    }];
//
//}
//
////cardViewCell
//
//#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat width = UIScreen.mainScreen.bounds.size.width;
//    return CGSizeMake(width-60, 185);
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 30, 0, 30);
//}
//
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return -48;
//}
//
//@end
//
//@interface StickCollectionViewFlowLayout()
//@property (nonatomic, strong) NSMutableArray *arrayCache;
//@end
////https://github.com/matbeich/StickyCollectionView/blob/master/StickCollectionView/Source/StickCollectionViewFlowLayout.m
//@implementation StickCollectionViewFlowLayout
//
//
//- (instancetype)initWithCoder:(NSCoder *)coder {
//    self = [super initWithCoder:coder];
//    if (self) {
//
//    }
//    return self;
//}
//
//- (void)prepareLayout {
//    [super prepareLayout];
//    _startIdx = -1;
//    _prePos = 0;
//
//    _standardHeight = 185;
//    _featuredHeight = 150;
//
//    //int c = self.collectionView.numberOfSections;
//
//   // _arrayCache = [NSMutableArray array];
////
////    _arrayCache = [NSMutableArray new];
////
////    CGFloat y = 0;
////
////    int count = (int)[self.collectionView numberOfItemsInSection:0];
////
////    for(int i=count-1; i >= 0; i--){
////        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
////        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
////
////        if(i >= count-3){
////            y += 20;
////        }
////        CGRect rect = CGRectMake(30, y, self.itemSize.width, 128);
////
////
////
////        attributes.frame = rect;
////
////        attributes.zIndex = i;
////
////        [_arrayCache addObject:attributes];
////
////        y += (self.itemSize.height - 49);
////    }
////    let layout = CardCollectionViewLayout()
////       layout.edgeInsets = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
////       layout.cardSize = CGSize(width: 320, height: 480)
////       let cardView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
////       cardView.registerClass(CardCell.self, forCellWithReuseIdentifier: "Cell")
////       cardView.backgroundColor = UIColor.whiteColor()
////       cardView.dataSource = self
////       cardView.delegate = self
//}
//
////- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
////    return _arrayCache[indexPath.item];
////}
//
//
//- (NSArray<__kindof UICollectionViewLayoutAttributes *> *) layoutAttributesForElementsInRect:(CGRect)rect {
//
//    NSMutableArray *layoutAttributes = [NSMutableArray new];
//
//
//
//    NSInteger topVisibleCardIndex = (int)fabs(self.collectionView.contentOffset.y)/self.itemSize.height;
//    NSInteger lastVisibleCardIndex = (int) (fabs(self.collectionView.contentOffset.y)+self.collectionView.bounds.size.height)/self.itemSize.height;
//    NSInteger lastCardIndex = (int)[self.collectionView numberOfItemsInSection:0];
//
//    if(lastVisibleCardIndex >= lastCardIndex)  { lastVisibleCardIndex = lastCardIndex; }
//
//    if(self.collectionView.contentOffset.y < 0) { topVisibleCardIndex = 0; }
//
//    for(int index = (int)topVisibleCardIndex; index < (int)lastVisibleCardIndex; index++){
//
//        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//
//        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
//
//        if(attributes){
//            [layoutAttributes addObject:attributes];
//            if (index == topVisibleCardIndex && self.collectionView.contentOffset.y > 0){
//                CGFloat y = fabs(self.collectionView.contentOffset.y) - (self.itemSize.height * attributes.indexPath.item) + 49*attributes.indexPath.item;
//                attributes.transform = CGAffineTransformMakeTranslation(0, y);
//            }else {
//                attributes.transform = CGAffineTransformIdentity;
//            }
//
//            attributes.zIndex = attributes.indexPath.item;
//
//        }
//    }
//
//    if(self.collectionView.contentOffset.y < 0){
//        [self updateLayoutAttributesOfTheTopCards:layoutAttributes];
//    }
//
//    return layoutAttributes;
//
//
////    NSArray *oldItems = [super layoutAttributesForElementsInRect:rect];
////    NSMutableArray *allItems = [[NSMutableArray alloc]initWithArray:oldItems copyItems:YES];
////    //__block UICollectionViewLayoutAttributes *headerAttributes = nil;
////    _startIdx = -1;
////    _prePos = 0;
////
////    CGFloat y = 0;
////
////    for (UICollectionViewLayoutAttributes *attribute in allItems) {
////        [self updateCellAttributes:attribute rect:(CGRect)rect y:y];
////    }
////
//////    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//////
//////        UICollectionViewLayoutAttributes *attributes = obj;
//////
////////        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
////////            headerAttributes = attributes;
////////        }else {
////////
////////        }
//////
//////        NSLog(@"idx %lu", idx);
//////        [self updateCellAttributes:attributes rect:(CGRect)rect];
//////    }];
////
////    return allItems;
//}
//
////guard let collection = collectionView else {
////            return
////        }
////        let noneIdx = Int(collection.contentOffset.y/titleHeight)
////        if noneIdx < 0 {
////            return
////        }
////        attribute.isExpand = false
////        let index = attribute.zIndex
////        var currentFrame = CGRect(x: collection.frame.origin.x, y: titleHeight * CGFloat(index), width: cellSize.width, height: cellSize.height)
////        if index == noneIdx{
////            attribute.frame = CGRect(x: currentFrame.origin.x, y: collection.contentOffset.y, width: cellSize.width, height: cellSize.height)
////        }
////        else if index <= noneIdx, currentFrame.maxY > collection.contentOffset.y{
////            currentFrame.origin.y -= (currentFrame.maxY - collection.contentOffset.y )
////            attribute.frame = currentFrame
////        }
////        else {
////            attribute.frame = currentFrame
////        }
//
///*
// NSMutableArray *attributes = [@[] mutableCopy];
// NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
//
// [attributes addObjectsFromArray:layoutAttributes];
//
// CGRect visibleRect;
// visibleRect.origin = self.collectionView.contentOffset;
// visibleRect.size = self.collectionView.bounds.size;
//
// CGFloat collectionCenter = self.collectionView.frame.size.width/2;
// CGFloat contentOffset = self.collectionView.contentOffset.x;
//
// for (UICollectionViewLayoutAttributes *attribute in attributes) {
//     CGRect frame = attribute.frame;
//     frame.origin.y = 0;
//     attribute.frame = frame;
//
//     if (CGRectIntersectsRect(attribute.frame, rect)) {
//         CGFloat center = attribute.center.x - contentOffset;
//         CGFloat maxDistance = self.itemSize.width + self.minimumLineSpacing;
//         CGFloat distance = MIN(ABS(collectionCenter - center), maxDistance);
//
//         CGFloat ratio = (maxDistance - distance)/maxDistance;
//
//         CGFloat alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha;
//         CGFloat scale = ratio * (1 - self.sideItemScale) + self.sideItemScale;
//
//         attribute.alpha = alpha;
//
//         CGFloat dist = attribute.frame.origin.x - visibleRect.origin.x;
//
//         CATransform3D transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1);
//         transform = CATransform3DTranslate(transform, 0, 0, -fabs(dist/1000));
//         attribute.transform3D = transform;
//     }
// }
//
// return attributes;
// */
//
//-(void) updateLayoutAttributesOfTheTopCards:(NSMutableArray<UICollectionViewLayoutAttributes*> *) attributes {
//
//    for(UICollectionViewLayoutAttributes *attribute in attributes){
//        CGFloat y = (fabs(self.collectionView.contentOffset.y) * ((CGFloat)attribute.indexPath.item * 0.5)) * 0.5;
//        NSLog(@"%lu updateLayoutAttributesOfTheTopCards %f",attribute.indexPath.item, y );
//        attribute.transform = CGAffineTransformMakeTranslation(0, y);
//    }
//  }
//
//- (void)updateCellAttributes:(UICollectionViewLayoutAttributes *)attributes rect:(CGRect)rect y:(CGFloat) y{
//
//    CGFloat contentOffset = self.collectionView.contentOffset.y;
//    CGFloat collectionCenter = self.collectionView.frame.size.height/2;
//
//    CGFloat center = attributes.center.x - contentOffset;
//    CGFloat maxDistance = self.itemSize.height + self.minimumLineSpacing;
//    CGFloat distance = MIN(ABS(collectionCenter - center), maxDistance);
//
//    CGFloat ratio = (maxDistance - distance)/maxDistance;
//
//    NSLog(@"updateCellAttributes idx : %lu center :%f %f %f %f", attributes.indexPath.row, center, attributes.center.x, contentOffset, ratio);
//
//
//    NSLog(@"contentSize.height : %f, %f, %f",  self.collectionView.contentSize.height, CGRectGetMinY(self.collectionView.bounds) , self.collectionView.contentInset.top);
//
//    CGFloat contentHeight = self.collectionView.contentSize.height;
//
//    CGFloat minY = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
//    CGFloat maxView = CGRectGetMaxY(self.collectionView.bounds);
//
//    NSLog(@"%lu minY : %f maxView : %f %@", attributes.indexPath.row, minY,maxView , NSStringFromCGRect(self.collectionView.bounds));
//
//    CGFloat maxY = attributes.frame.origin.y; //- CGRectGetHeight(headerAttributes.bounds);
//    CGFloat finalY = MAX(minY, maxY);
//
//    CGPoint origin = attributes.frame.origin;
//
//    NSLog(@"%lu minY : %f maxY : %f finalY : %f", attributes.indexPath.row, minY, maxY, finalY);
//
////    finalY = contentHeight - (attributes.indexPath.row + 1) * CGRectGetHeight(headerAttributes.bounds);
//
//    //---- minY 0
//
//
//
//
////
////        if(_startIdx == -1){
////            _startIdx = attributes.indexPath.row;
////
////        }else{
////            finalY += 50 *(attributes.indexPath.row-_startIdx);
////        }
////
////    }else{
////
////    }
//
////    if(maxY-minY < (maxView - minY)/2){
////        finalY = _prePos +   50;
////    }
//
////    if(attributes.indexPath.row == 0){
////        finalY += _prePos;
////    }
////
//
//
//
//    //---- maxView 800
//
//
// //   CGFloat deltaY = (finalY - origin.y) / CGRectGetHeight(attributes.frame);
//
////    if (self.firstItemTransform) {
////        attributes.transform = CGAffineTransformMakeScale((1- deltaY * self.firstItemTransform), (1 - deltaY * self.firstItemTransform));
////    }
//
////    origin.y = finalY;
////    attributes.frame = (CGRect){origin, attributes.frame.size};
//    attributes.zIndex = attributes.indexPath.row;
//
//    _prePos = finalY;
//
//    NSLog(@"%lu : frame %@ z: %lu", attributes.indexPath.row, NSStringFromCGRect(attributes.frame), attributes.zIndex);
//
//}
//
//- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
//    return YES;
//}
//
//@end
//
//@interface CardViewCell()
//
//
//@end
//
//@implementation CardViewCell
//
//
//
//@end
