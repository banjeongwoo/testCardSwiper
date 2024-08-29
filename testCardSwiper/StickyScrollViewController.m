//
//  StickyScrollViewController.m
//  testCardSwiper
//
//  Created by Sungkil Moon on 8/29/24.
//

#import "StickyScrollViewController.h"

@interface StickyScrollViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *stickyHeaderView;
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *middleBanner01View;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *stickyHeaderViewTopContraint;
@end

@implementation StickyScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _stickyHeaderViewTopContraint.constant = self.topView.frame.size.height;
    
    
}

- (IBAction)ButtonTouchUpInside:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    //self.navigationController?.popViewController(animated: true)
    [self.navigationController popViewControllerAnimated:true];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"contentOffset %f %f", scrollView.contentOffset.y, self.topView.frame.size.height);
    
    //BOOL shouldShowSticky = scrollView.contentOffset.y >= self.topView.frame.size.height;
    
    //_stickyHeaderView.hidden = shouldShowSticky;
    
    CGFloat stickyTopOffset = self.topView.frame.size.height - scrollView.contentOffset.y;
    _stickyHeaderViewTopContraint.constant = stickyTopOffset > 0.0f ? stickyTopOffset : 0.0f;
    
    CGFloat middlebannerOffset = _middleBanner01View.frame.origin.y + _middleBanner01View.frame.size.height - _stickyHeaderView.frame.size.height;
    
    BOOL shouldShowSticky = scrollView.contentOffset.y >= middlebannerOffset;
    if(shouldShowSticky){
        _stickyHeaderViewTopContraint.constant = middlebannerOffset - scrollView.contentOffset.y;
    }
    
   // _stickyHeaderView.hidden = shouldShowSticky;
    
   // NSLog(@"middleBanner : %f %f", _middleBanner01View.frame.origin.y, _middleBanner01View.frame.size.height);
    
    
}




@end
