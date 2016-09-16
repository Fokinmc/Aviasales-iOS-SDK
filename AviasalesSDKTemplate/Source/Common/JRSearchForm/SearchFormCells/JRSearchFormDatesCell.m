//
//  JRSearchFormDatesCell.m
//
//  Copyright 2016 Go Travel Un Limited
//  This code is distributed under the terms and conditions of the MIT license.
//

#import "JRSearchFormDatesCell.h"
#import "JRSearchFormSimpleSearchTableView.h"
#import "JRSearchFormDateCell.h"
#import "UIImage+JRUIImage.h"

@interface JRSearchFormDatesCell ()

@property (weak, nonatomic) IBOutlet JRSearchFormSimpleSearchTableView *tableView;

@end

@implementation JRSearchFormDatesCell

- (void)updateCell {
	[_tableView reloadData];
}

- (void)initialSetup {
	JRSearchFormItem *directDateItem = [[JRSearchFormItem alloc] initWithType:JRSearchFormTableViewDirectDateItem itemDelegate:self.item.itemDelegate];
	JRSearchFormItem *returnDateItem = [[JRSearchFormItem alloc] initWithType:JRSearchFormTableViewReturnDateItem itemDelegate:self.item.itemDelegate];
	[_tableView setItems:@[directDateItem, returnDateItem]];
	[_tableView reloadData];
}

- (void)setItem:(JRSearchFormItem *)item {
	[super setItem:item];
	[self initialSetup];
}

@end
