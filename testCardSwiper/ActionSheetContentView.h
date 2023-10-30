//
//  ActionSheetContentView.h
//  testCardSwiper
//
//  Created by MI00363 on 2023/10/30.
//

#import <UIKit/UIKit.h>

#import "Message.h"
#import "ActionSheet.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ActionSheetContentViewDelegate;

@interface ActionSheetContentView : UIView
@property(nonatomic,strong) ActionSheet *actionSheet;
@property(nonatomic,weak)id <ActionSheetContentViewDelegate> delegate;
@property(nonatomic,weak)IBOutlet UIView *contentView;
@property(nonatomic,strong) NSString *screen_name;
@property(nonatomic,strong) NSString *screen_id;

//- (IBAction)buttonTouchUpInside:(Button*)button;
//- (IBAction)componentValueChanged:(Component*)component;
//- (IBAction)componentTouchUpInside:(Component*)component;
- (void)setData:(id)data;
- (void)dismiss;

@end


@protocol ActionSheetContentViewDelegate <NSObject>
- (void)actionSheetContentView:(ActionSheetContentView*)contentView message:(Message*) message;
@end

NS_ASSUME_NONNULL_END
