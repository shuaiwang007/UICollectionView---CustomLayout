//
//  WSCollectionViewCell.m
//  自定义布局
//
//  Created by 王帅 on 16/4/1.
//  Copyright © 2016年 Mr.wang. All rights reserved.
//

#import "WSCollectionViewCell.h"

@interface WSCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation WSCollectionViewCell

- (void)awakeFromNib {
    
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.borderWidth = 3;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:imageName];
    
}

@end
