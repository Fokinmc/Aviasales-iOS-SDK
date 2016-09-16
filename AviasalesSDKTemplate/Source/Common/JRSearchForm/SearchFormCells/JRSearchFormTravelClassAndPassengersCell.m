//
//  JRSearchFormTravelClassAndPassengersCell.m
//
//  Copyright 2016 Go Travel Un Limited
//  This code is distributed under the terms and conditions of the MIT license.
//

#import "JRSearchFormTravelClassAndPassengersCell.h"
#import "JRSearchFormSimpleSearchTableView.h"

@interface JRSearchFormTravelClassAndPassengersCell ()

@property (weak, nonatomic) IBOutlet JRSearchFormSimpleSearchTableView *tableView;

@end


@implementation JRSearchFormTravelClassAndPassengersCell

- (void)initialSetup {
	JRSearchFormItem *passengersItem = [[JRSearchFormItem alloc] initWithType:JRSearchFormTableViewPassengersItem itemDelegate:self.item.itemDelegate];
	JRSearchFormItem *travelClassItem = [[JRSearchFormItem alloc] initWithType:JRSearchFormTableViewTravelClassItem itemDelegate:self.item.itemDelegate];
    [_tableView setItems:@[passengersItem, travelClassItem]];
	[_tableView reloadData];
}

- (void)setItem:(JRSearchFormItem *)item {
	[super setItem:item];
	[self initialSetup];
}

- (void)updateCell {
	[_tableView reloadData];
}

@end
