//
//  QuickMenuView.m
//  testCardSwiper
//
//  Created by Sungkil Moon on 8/29/24.
//

#import "QuickMenuView.h"
const CGFloat kNewPageLoadScrollPercentageThreshold = 0.66;

@interface QuickMenuView () <UICollectionViewDragDelegate, UICollectionViewDropDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataList;
@end

@implementation QuickMenuView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSArray *list = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    _dataList = [list mutableCopy];
    [_collectionView reloadData];

}


#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataList count];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QuickMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"QuickMenuCell" forIndexPath:indexPath];
    [cell setData:self.dataList[indexPath.item]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 20, 0, 20);
}

//// < - > cell 사이 간격
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat spacing = ((width - 40) - (92*3))/3.0f;
//    return spacing;
//}
//
//// cell 위 아래 사이 간격
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 14;
//}

-(BOOL) shouldLoadNextPage:(UICollectionView *)collectionView {
  CGFloat yOffset = collectionView.contentOffset.x;
  CGFloat height = collectionView.contentSize.width - CGRectGetWidth(collectionView.frame);
  return yOffset / height > kNewPageLoadScrollPercentageThreshold;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath : %lu", indexPath.item);
   
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"------ end didEndDisplayingCell");
    BOOL shouldLoadNextPage = [self shouldLoadNextPage:collectionView];
    
    if(shouldLoadNextPage && _dataList.count > 0){
        NSLog(@"------ shouldLoadNextPage");
    }
    
}

#pragma mark - UICollectionViewDragDelegate
- (nonnull NSArray<UIDragItem *> *)collectionView:(nonnull UICollectionView *)collectionView
                     itemsForBeginningDragSession:(nonnull id<UIDragSession>)session
                                      atIndexPath:(nonnull NSIndexPath *)indexPath {
    
    id data = _dataList[indexPath.row];
    
    NSItemProvider *itemProvider = [[NSItemProvider alloc] initWithObject:data];
    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:itemProvider];

    dragItem.localObject = data;
    return @[dragItem];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canHandleDropSession:(id<UIDropSession>)session{
    return YES;
}

#pragma mark - UICollectionViewDropDelegate
- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(nullable NSIndexPath *)destinationIndexPath{
    
    if(session.localDragSession != nil){
       return [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationMove intent:UICollectionViewDropIntentUnspecified];
    }
    
    return [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationCancel intent:UICollectionViewDropIntentUnspecified];;
}

- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator{
    NSLog(@"performDropWithCoordinator");
    NSIndexPath *destinationIndexPath = coordinator.destinationIndexPath;
    if(destinationIndexPath != nil){
        
        NSIndexPath *sourceIndexPath = [coordinator.items firstObject].sourceIndexPath;
        if(sourceIndexPath != nil){
            [collectionView performBatchUpdates:^{
                NSLog(@"sourceIndexPath: %lu destinationIndexPath: %lu count: %lu", sourceIndexPath.item, destinationIndexPath.item, self.dataList.count);
                
                id data = self.dataList[sourceIndexPath.item];
            
                [self.dataList removeObjectAtIndex:sourceIndexPath.item];
                [self.dataList insertObject: data atIndex:destinationIndexPath.item];
                
                [collectionView deleteItemsAtIndexPaths:@[sourceIndexPath]];
                [collectionView insertItemsAtIndexPaths:@[destinationIndexPath]];
            } completion:^(BOOL finished) {
                
            }];
            
            
            [coordinator dropItem:[coordinator.items firstObject].dragItem toItemAtIndexPath:destinationIndexPath];
        }
    }
}

@end


@interface QuickMenuCell ()
@property (weak, nonatomic) IBOutlet UILabel *nmLabel;
@property (weak, nonatomic) IBOutlet UIImageView *nmImageView;

@end

@implementation QuickMenuCell

-(void)dealloc {
}

- (void)awakeFromNib {
   [super awakeFromNib];
    [self didLoad];
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

- (void)initial {}

- (void)didLoad {}

- (void)setData:(id)data{
    
    NSString *title = data;
    _nmLabel.text = title;
    
}



@end
