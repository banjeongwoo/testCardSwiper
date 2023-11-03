//
//  ViewController.h
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/23.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

-(void) update:(NSInteger) idx;
@end

@interface LPayMiddleBannerCollectionViewLayout : UICollectionViewFlowLayout
@property (nonatomic, assign) CGFloat currentPage;
@end

@interface LPayMiddleBannerCell : UICollectionViewCell

@end
