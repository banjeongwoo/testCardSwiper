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
@end

NS_ASSUME_NONNULL_END
