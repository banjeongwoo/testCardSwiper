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

    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(0, 30, 0, 30);
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(w-60, 300);
    [_collectionView setCollectionViewLayout:layout];
    

}

-(void) setData:(id) data{
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


@interface CardViewCell()


@end

@implementation CardViewCell



@end
