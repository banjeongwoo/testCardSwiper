# testCardSwiper

#### https://stackoverflow.com/questions/39390979/how-to-make-the-center-cell-of-the-uicollectionview-overlap-the-other-two-cells

#### https://www.kodeco.com/7246-expanding-cells-in-ios-collection-views?page=3


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
    
    CGFloat w = [[UIScreen mainScreen] bounds].size.width;

//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
//    layout.minimumInteritemSpacing = 0;
//    layout.itemSize = CGSizeMake(w-60, 300);
//    [_collectionView setCollectionViewLayout:layout];
    
//    StickCollectionViewFlowLayout *flowLayout = [[StickCollectionViewFlowLayout alloc] init];
//    [flowLayout setItemSize:CGSizeMake(w-60, 300)];
//    flowLayout.minimumInteritemSpacing = 0;
//    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    flowLayout.firstItemTransform = 30;
//    [_collectionView setCollectionViewLayout:flowLayout];
    
  
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
    
    [_collectionView reloadData];
    
    
//    CGFloat diff = self.collectionView.frame.size.height - self.collectionView.contentSize.height;
//    if (diff > 0) {
//        self.collectionView.contentInset = UIEdgeInsetsMake(diff, 0, 0, 0);
//    }
    
    //[_collectionView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
   
    
   
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1000 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
//        [self.collectionView performBatchUpdates:^{} completion:^(BOOL finished) {
//
//
//        }];
      //  NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataList.count-1 inSection:0];
      //  [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
        
        [self.collectionView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
    });
   

    
//    func scrollToLastItem(at scrollPosition: UICollectionViewScrollPosition = .centeredHorizontally, animated: Bool = true) {
//           let lastSection = numberOfSections - 1
//           guard lastSection >= 0 else { return }
//           let lastItem = numberOfItems(inSection: lastSection) - 1
//           guard lastItem >= 0 else { return }
//           let lastItemIndexPath = IndexPath(item: lastItem, section: lastSection)
//           scrollToItem(at: lastItemIndexPath, at: scrollPosition, animated: animated)
//       }
      
    
    
//    CGSize contentSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
//    if (contentSize.height > self.collectionView.bounds.size.height) {
//        CGPoint targetContentOffset = CGPointMake(0.0f, contentSize.height - self.collectionView.bounds.size.height);
//        [self.collectionView setContentOffset:targetContentOffset];
//    }
    
//    CGSize contentSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
//        if (contentSize.height > self.collectionView.bounds.size.height) {
//            CGPoint targetContentOffset = CGPointMake(0.0f, contentSize.height - self.collectionView.bounds.size.height);
//            [self.collectionView setContentOffset:targetContentOffset];
//        }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // ---- autolayout ----
    [self.view layoutIfNeeded];
  

//    CGSize contentSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
//    if (contentSize.height > self.collectionView.bounds.size.height) {
//        CGPoint targetContentOffset = CGPointMake(0.0f, contentSize.height - self.collectionView.bounds.size.height);
//        [self.collectionView setContentOffset:targetContentOffset];
//    }
    
//    CGSize contentSize = [self.collectionView.collectionViewLayout collectionViewContentSize];
//       if (contentSize.height > self.collectionView.bounds.size.height) {
//           CGPoint targetContentOffset = CGPointMake(0.0f, contentSize.height - self.collectionView.bounds.size.height);
//           [self.collectionView setContentOffset:targetContentOffset];
//       }
    
//    CGFloat diff = self.collectionView.frame.size.height - self.collectionView.contentSize.height;
//    if (diff > 0) {
//        self.collectionView.contentInset = UIEdgeInsetsMake(diff, 0, 0, 0);
//    }
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
        //view.backgroundColor = [UIColor greenColor];
       // cell.contentView.backgroundColor = [UIColor rgbColorWithRed:index%255) green:<#(float)#> blue:<#(float)#> alpha:<#(float)#>]
        
        [UIColor colorWithRed:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
                                                       green:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
                                                        blue:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
                                               alpha:1];
    }
    
    cell.contentView.layer.cornerRadius = 28;
    cell.contentView.layer.masksToBounds = true;
    cell.titleLabel.text = [NSString stringWithFormat:@"%lu", indexPath.item+1];
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
        [topViewController update:indexPath.item];
    }];
    
}

//cardViewCell

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    return CGSizeMake(width-60, 185);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 30, 0, 30);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return -48;
}

@end

@interface StickCollectionViewFlowLayout()
@property (nonatomic, strong) NSMutableArray *arrayCache;
@end
//https://github.com/matbeich/StickyCollectionView/blob/master/StickCollectionView/Source/StickCollectionViewFlowLayout.m
@implementation StickCollectionViewFlowLayout


- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {

    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    _startIdx = -1;
    _prePos = 0;
    
    _standardHeight = 185;
    _featuredHeight = 150;
    
    //int c = self.collectionView.numberOfSections;
    
   // _arrayCache = [NSMutableArray array];
//
//    _arrayCache = [NSMutableArray new];
//
//    CGFloat y = 0;
//
//    int count = (int)[self.collectionView numberOfItemsInSection:0];
//
//    for(int i=count-1; i >= 0; i--){
//        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//
//        if(i >= count-3){
//            y += 20;
//        }
//        CGRect rect = CGRectMake(30, y, self.itemSize.width, 128);
//
//
//
//        attributes.frame = rect;
//
//        attributes.zIndex = i;
//
//        [_arrayCache addObject:attributes];
//
//        y += (self.itemSize.height - 49);
//    }
//    let layout = CardCollectionViewLayout()
//       layout.edgeInsets = UIEdgeInsets(top: 40, left: 0, bottom: 40, right: 0)
//       layout.cardSize = CGSize(width: 320, height: 480)
//       let cardView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
//       cardView.registerClass(CardCell.self, forCellWithReuseIdentifier: "Cell")
//       cardView.backgroundColor = UIColor.whiteColor()
//       cardView.dataSource = self
//       cardView.delegate = self
}

//- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//    return _arrayCache[indexPath.item];
//}


- (NSArray<__kindof UICollectionViewLayoutAttributes *> *) layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSMutableArray *layoutAttributes = [NSMutableArray new];
    
    
    
    NSInteger topVisibleCardIndex = (int)fabs(self.collectionView.contentOffset.y)/self.itemSize.height;
    NSInteger lastVisibleCardIndex = (int) (fabs(self.collectionView.contentOffset.y)+self.collectionView.bounds.size.height)/self.itemSize.height;
    NSInteger lastCardIndex = (int)[self.collectionView numberOfItemsInSection:0];
    
    if(lastVisibleCardIndex >= lastCardIndex)  { lastVisibleCardIndex = lastCardIndex; }
    
    if(self.collectionView.contentOffset.y < 0) { topVisibleCardIndex = 0; }
    
    for(int index = (int)topVisibleCardIndex; index < (int)lastVisibleCardIndex; index++){
        
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        if(attributes){
            [layoutAttributes addObject:attributes];
            if (index == topVisibleCardIndex && self.collectionView.contentOffset.y > 0){
                CGFloat y = fabs(self.collectionView.contentOffset.y) - (self.itemSize.height * attributes.indexPath.item);
                attributes.transform = CGAffineTransformMakeTranslation(0, y);
            }else {
                attributes.transform = CGAffineTransformIdentity;
            }
            
            attributes.zIndex = attributes.indexPath.item;
            
        }
    }
    
    if(self.collectionView.contentOffset.y < 0){
        [self updateLayoutAttributesOfTheTopCards:layoutAttributes];
    }

    return layoutAttributes;
    
    
//    NSArray *oldItems = [super layoutAttributesForElementsInRect:rect];
//    NSMutableArray *allItems = [[NSMutableArray alloc]initWithArray:oldItems copyItems:YES];
//    //__block UICollectionViewLayoutAttributes *headerAttributes = nil;
//    _startIdx = -1;
//    _prePos = 0;
//
//    CGFloat y = 0;
//
//    for (UICollectionViewLayoutAttributes *attribute in allItems) {
//        [self updateCellAttributes:attribute rect:(CGRect)rect y:y];
//    }
//
////    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
////
////        UICollectionViewLayoutAttributes *attributes = obj;
////
//////        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
//////            headerAttributes = attributes;
//////        }else {
//////
//////        }
////
////        NSLog(@"idx %lu", idx);
////        [self updateCellAttributes:attributes rect:(CGRect)rect];
////    }];
//
//    return allItems;
}

//guard let collection = collectionView else {
//            return
//        }
//        let noneIdx = Int(collection.contentOffset.y/titleHeight)
//        if noneIdx < 0 {
//            return
//        }
//        attribute.isExpand = false
//        let index = attribute.zIndex
//        var currentFrame = CGRect(x: collection.frame.origin.x, y: titleHeight * CGFloat(index), width: cellSize.width, height: cellSize.height)
//        if index == noneIdx{
//            attribute.frame = CGRect(x: currentFrame.origin.x, y: collection.contentOffset.y, width: cellSize.width, height: cellSize.height)
//        }
//        else if index <= noneIdx, currentFrame.maxY > collection.contentOffset.y{
//            currentFrame.origin.y -= (currentFrame.maxY - collection.contentOffset.y )
//            attribute.frame = currentFrame
//        }
//        else {
//            attribute.frame = currentFrame
//        }

/*
 NSMutableArray *attributes = [@[] mutableCopy];
 NSArray *layoutAttributes = [super layoutAttributesForElementsInRect:rect];
 
 [attributes addObjectsFromArray:layoutAttributes];
 
 CGRect visibleRect;
 visibleRect.origin = self.collectionView.contentOffset;
 visibleRect.size = self.collectionView.bounds.size;
 
 CGFloat collectionCenter = self.collectionView.frame.size.width/2;
 CGFloat contentOffset = self.collectionView.contentOffset.x;
 
 for (UICollectionViewLayoutAttributes *attribute in attributes) {
     CGRect frame = attribute.frame;
     frame.origin.y = 0;
     attribute.frame = frame;
     
     if (CGRectIntersectsRect(attribute.frame, rect)) {
         CGFloat center = attribute.center.x - contentOffset;
         CGFloat maxDistance = self.itemSize.width + self.minimumLineSpacing;
         CGFloat distance = MIN(ABS(collectionCenter - center), maxDistance);
         
         CGFloat ratio = (maxDistance - distance)/maxDistance;

         CGFloat alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha;
         CGFloat scale = ratio * (1 - self.sideItemScale) + self.sideItemScale;
                 
         attribute.alpha = alpha;
         
         CGFloat dist = attribute.frame.origin.x - visibleRect.origin.x;
         
         CATransform3D transform = CATransform3DScale(CATransform3DIdentity, scale, scale, 1);
         transform = CATransform3DTranslate(transform, 0, 0, -fabs(dist/1000));
         attribute.transform3D = transform;
     }
 }
 
 return attributes;
 */

-(void) updateLayoutAttributesOfTheTopCards:(NSMutableArray<UICollectionViewLayoutAttributes*> *) attributes {
    
    for(UICollectionViewLayoutAttributes *attribute in attributes){
        CGFloat y = (fabs(self.collectionView.contentOffset.y) * ((CGFloat)attribute.indexPath.item * 0.5)) * 0.5;
        NSLog(@"%lu updateLayoutAttributesOfTheTopCards %f",attribute.indexPath.item, y );
        attribute.transform = CGAffineTransformMakeTranslation(0, y);
    }
  }

- (void)updateCellAttributes:(UICollectionViewLayoutAttributes *)attributes rect:(CGRect)rect y:(CGFloat) y{
   
    CGFloat contentOffset = self.collectionView.contentOffset.y;
    CGFloat collectionCenter = self.collectionView.frame.size.height/2;
    
    CGFloat center = attributes.center.x - contentOffset;
    CGFloat maxDistance = self.itemSize.height + self.minimumLineSpacing;
    CGFloat distance = MIN(ABS(collectionCenter - center), maxDistance);
    
    CGFloat ratio = (maxDistance - distance)/maxDistance;
    
    NSLog(@"updateCellAttributes idx : %lu center :%f %f %f %f", attributes.indexPath.row, center, attributes.center.x, contentOffset, ratio);
    
    
    NSLog(@"contentSize.height : %f, %f, %f",  self.collectionView.contentSize.height, CGRectGetMinY(self.collectionView.bounds) , self.collectionView.contentInset.top);
    
    CGFloat contentHeight = self.collectionView.contentSize.height;
    
    CGFloat minY = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
    CGFloat maxView = CGRectGetMaxY(self.collectionView.bounds);
    
    NSLog(@"%lu minY : %f maxView : %f %@", attributes.indexPath.row, minY,maxView , NSStringFromCGRect(self.collectionView.bounds));
    
    CGFloat maxY = attributes.frame.origin.y; //- CGRectGetHeight(headerAttributes.bounds);
    CGFloat finalY = MAX(minY, maxY);
    
    CGPoint origin = attributes.frame.origin;
    
    NSLog(@"%lu minY : %f maxY : %f finalY : %f", attributes.indexPath.row, minY, maxY, finalY);
    
//    finalY = contentHeight - (attributes.indexPath.row + 1) * CGRectGetHeight(headerAttributes.bounds);
    
    //---- minY 0
    
   
        
        
//
//        if(_startIdx == -1){
//            _startIdx = attributes.indexPath.row;
//
//        }else{
//            finalY += 50 *(attributes.indexPath.row-_startIdx);
//        }
//
//    }else{
//
//    }

//    if(maxY-minY < (maxView - minY)/2){
//        finalY = _prePos +   50;
//    }
    
//    if(attributes.indexPath.row == 0){
//        finalY += _prePos;
//    }
//
        
    
    
    //---- maxView 800
    
    
 //   CGFloat deltaY = (finalY - origin.y) / CGRectGetHeight(attributes.frame);
    
//    if (self.firstItemTransform) {
//        attributes.transform = CGAffineTransformMakeScale((1- deltaY * self.firstItemTransform), (1 - deltaY * self.firstItemTransform));
//    }

//    origin.y = finalY;
//    attributes.frame = (CGRect){origin, attributes.frame.size};
    attributes.zIndex = attributes.indexPath.row;
    
    _prePos = finalY;
    
    NSLog(@"%lu : frame %@ z: %lu", attributes.indexPath.row, NSStringFromCGRect(attributes.frame), attributes.zIndex);

}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end

@interface CardViewCell()


@end

@implementation CardViewCell



@end



//
//  CardDetailViewController.h
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CardDetailViewController : UIViewController
-(void) setData:(id) data;
@end

@interface CardViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@interface StickCollectionViewFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat firstItemTransform;
@property (nonatomic, assign) NSInteger startIdx;
@property (nonatomic, assign) CGFloat prePos;

@property (nonatomic, assign) CGFloat standardHeight;
@property (nonatomic, assign) CGFloat featuredHeight;
@end

NS_ASSUME_NONNULL_END
