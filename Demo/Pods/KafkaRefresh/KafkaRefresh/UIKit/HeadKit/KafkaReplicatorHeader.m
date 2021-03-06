/**
 * Copyright (c) 2016-present, K.
 * All rights reserved.
 *
 * e-mail:xorshine@icloud.com
 * github:https://github.com/xorshine
 *
 * This source code is licensed under the MIT license.
 */

#import "KafkaReplicatorHeader.h"  

@implementation KafkaReplicatorHeader

- (void)setupProperties{
	[super setupProperties];	
	[self.layer addSublayer:self.replicatorLayer];
}

- (void)layoutSubviews{
	[super layoutSubviews];
	self.replicatorLayer.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)setFillColor:(UIColor *)fillColor{
	if (super.fillColor == fillColor) {
		return;
	}
	[super setFillColor:fillColor];
	self.replicatorLayer.tintColor = fillColor;
}

- (void)setAnimationStyle:(KafkaReplicatorLayerAnimationStyle)animationStyle{
	if (_animationStyle == animationStyle) {
		return;
	}
	_animationStyle = animationStyle;
	self.replicatorLayer.animationStyle = animationStyle;
}

- (void)kafkaDidScrollWithProgress:(CGFloat)progress max:(const CGFloat)max{ 
	self.replicatorLayer.opacity = progress;
}

- (void)kafkaRefreshStateDidChange:(KafkaRefreshState)state{
	[super kafkaRefreshStateDidChange:state];
	switch (state) {
		case KafkaRefreshStateNone:
		case KafkaRefreshStateScrolling:break;
		case KafkaRefreshStateReady:{
			self.replicatorLayer.opacity = 1.;
			break;
		}
		case KafkaRefreshStateRefreshing:{
			[self.replicatorLayer startAnimating];
			break;
		}
		case KafkaRefreshStateWillEndRefresh:{
			[self.replicatorLayer stopAnimating];
			break;
		}
	}
}

- (KafkaReplicatorLayer *)replicatorLayer{
	if (!_replicatorLayer) {
		_replicatorLayer = [KafkaReplicatorLayer layer];
	}
	return _replicatorLayer;
}

@end
