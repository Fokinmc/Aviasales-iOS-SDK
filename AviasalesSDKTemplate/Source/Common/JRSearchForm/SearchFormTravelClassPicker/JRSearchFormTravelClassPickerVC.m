//
//  JRSearchFormTravelClassPickerVC.m
//
//  Copyright 2016 Go Travel Un Limited
//  This code is distributed under the terms and conditions of the MIT license.
//

#import "JRSearchFormTravelClassPickerVC.h"
#import "UIView+JRFadeAnimation.h"
#import "UIImage+JRUIImage.h"
#import "JRTableViewCell.h"
#import "JRSearchInfoUtils.h"
#import "JRSearchFormTravelClassPickerCell.h"

static const NSInteger kJRSearchFormTravelClassPickerWeight = 200;
static const NSInteger kJRSearchFormTravelClassPickerCellHeight = 44;

static const CGFloat kJRSearchFormTravelClassPickerReloadAnimationDutation = 0.2;


@interface JRSearchFormTravelClassPickerVC ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) JRSearchInfo *searchInfo;
@property (weak, nonatomic) id<JRSearchFormTravelClassPickerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *items;

@end


@implementation JRSearchFormTravelClassPickerVC

- (id)initWithDelegate:(id<JRSearchFormTravelClassPickerDelegate>)delegate
            searchInfo:(JRSearchInfo *)searchInfo {
    self = [super init];
	if (self) {
		_delegate = delegate;
        _searchInfo = searchInfo;
		[self rebuildTable];
	}
	return self;
}

- (void)rebuildTable
{
	_items = [NSMutableArray new];
    [_items addObject:@(JRSDKTravelClassEconomy)];
    [_items addObject:@(JRSDKTravelClassPremiumEconomy)];
    [_items addObject:@(JRSDKTravelClassBusiness)];
    [_items addObject:@(JRSDKTravelClassFirst)];
    [_tableView reloadData];
}

- (void)dealloc {
    [_delegate classPickerDidSelectTravelClass];
}

- (CGSize)contentSize
{
	return CGSizeMake(kJRSearchFormTravelClassPickerWeight, kJRSearchFormTravelClassPickerCellHeight * _items.count);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRSDKTravelClass travelClass = [_items[indexPath.row] integerValue];
    NSString *cellIdentifier = @"JRSearchFormTravelClassPickerCell";
    JRSearchFormTravelClassPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = LOAD_VIEW_FROM_NIB_NAMED(cellIdentifier);
        [cell setSearchInfo:_searchInfo];
    }
    [cell.customBackgroundView setBackgroundColor:[UIColor clearColor]];
    [cell.customSelectedBackgroundView setBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2]];
    [cell setTravelClass:travelClass];
    
    [cell setBottomLineVisible:YES];
    [cell setShowLastLine:NO];
    [cell setBottomLineInsets:UIEdgeInsetsMake(0, 22, 0, 0)];
    [cell setBottomLineColor:[[UIColor whiteColor] colorWithAlphaComponent:0.5]];
    
    [cell updateBackgroundViewsForImagePath:indexPath inTableView:tableView];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_searchInfo setTravelClass:[_items[indexPath.row] integerValue]];
	[_tableView reloadData];
    
	NSTimeInterval duration = kJRSearchFormTravelClassPickerReloadAnimationDutation;
	[UIView addTransitionFadeToView:_tableView duration:duration];
    
	__weak JRSearchFormTravelClassPickerVC *weakSelf = self;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.delegate classPickerDidSelectTravelClass];
    });
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

@end
