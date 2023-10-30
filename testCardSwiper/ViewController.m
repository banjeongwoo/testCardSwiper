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

@interface ViewController () <SwipeCardsDataSource>
@property(strong, nonatomic) SwipeCardView *swipeCardView;
@property(strong, nonatomic) NSArray *dataList;
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
    
    _swipeCardView = [[SwipeCardView alloc] initWithFrame:CGRectMake((width-w)/2, 100, w, h)];
    _swipeCardView.dataSource = (id)self;
    _swipeCardView.delegate = (id)self;
    [self.view addSubview:_swipeCardView];
    
    _dataList = @[
        @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20",

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
    
    //[_swipeCardView setCurrnetPositonIndex:1];
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
   
    [controller setData:@(3)];
    [self.navigationController presentViewController:controller
                                            animated:YES
                                            completion:nil];
}

@end
