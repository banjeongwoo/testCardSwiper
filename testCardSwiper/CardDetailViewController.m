//
//  CardDetailViewController.m
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//

#import "CardDetailViewController.h"

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
    
    StickCollectionViewFlowLayout *flowLayout = [[StickCollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(w-60, 300)];
    flowLayout.minimumInteritemSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.firstItemTransform = 30;
    [_collectionView setCollectionViewLayout:flowLayout];
    
  
    

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
        cell.contentView.backgroundColor = [UIColor colorWithRed:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
                                                       green:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
                                                        blue:((float) (arc4random_uniform((uint32_t)index)%255) / 255.0f)
                                               alpha:1];
    }
    
    cell.titleLabel.text = [NSString stringWithFormat:@"%lu", indexPath.item];
    return cell;
}

#pragma UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //NSString *selected = [self.tracks objectAtIndex:indexPath.row];
    //NSLog(@"selected=%@", selected);
}

//cardViewCell

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = UIScreen.mainScreen.bounds.size.width;
    return CGSizeMake(width-60, 148);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 30, 0, 30);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return -20;
}

@end


//https://github.com/matbeich/StickyCollectionView/blob/master/StickCollectionView/Source/StickCollectionViewFlowLayout.m
@implementation StickCollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *oldItems = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *allItems = [[NSMutableArray alloc]initWithArray:oldItems copyItems:YES];
    
    __block UICollectionViewLayoutAttributes *headerAttributes = nil;
    
    [allItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UICollectionViewLayoutAttributes *attributes = obj;
        
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
            headerAttributes = attributes;
        }else {
            [self updateCellAttributes:attributes withSectionHeader:headerAttributes];
            
        }
    }];
    
    return allItems;
}

- (void)updateCellAttributes:(UICollectionViewLayoutAttributes *)attributes withSectionHeader:(UICollectionViewLayoutAttributes *)headerAttributes {
    
    CGFloat minY = CGRectGetMinY(self.collectionView.bounds) + self.collectionView.contentInset.top;
    CGFloat maxY = attributes.frame.origin.y - CGRectGetHeight(headerAttributes.bounds);
    CGFloat finalY = MAX(minY, maxY);
    
    CGPoint origin = attributes.frame.origin;
    
    CGFloat deltaY = (finalY - origin.y) / CGRectGetHeight(attributes.frame);
    
    if (self.firstItemTransform) {
        attributes.transform = CGAffineTransformMakeScale((1- deltaY * self.firstItemTransform), (1 - deltaY * self.firstItemTransform));
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

@interface CardViewCell()


@end

@implementation CardViewCell



@end
