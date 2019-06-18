//
//  HotTableViewCell.m
//  Project
//
//  Created by 天空吸引我 on 2019/6/18.
//

#import "HotTableViewCell.h"

@implementation HotTableViewCell

#pragma mark - Initial Methods
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

/**视图初始化*/
- (void)setupUI {

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Delegate

#pragma mark - Public

#pragma mark - Private

#pragma mark - Setter

#pragma mark - Getter

@end
