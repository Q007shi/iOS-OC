//
//  TBFGradientView.h
//  TBBaseKit
//
//  Created by 石富才 on 2020/2/19.
//

#import <UIKit/UIKit.h>

@class TBFGradientModel,TBFGradientContentModel;
@interface TBFGradientView : UIView
/**  */
@property (nonatomic, strong) TBFGradientModel *gradient;

@end

@interface TBFGradientModel : NSObject

/** 渐变起点(默认) {0,0}~{1,1}*/
@property (nonatomic, assign) CGPoint startPoint;
/** 渐变终点 {0,0}~{1,1} */
@property (nonatomic, assign) CGPoint endPoint;

/** 渐变数据，注意：gradients 中的 location 之和不能大于1 */
@property (nonatomic, strong) NSArray<TBFGradientContentModel *> *gradientContents;

@end

@interface TBFGradientContentModel : NSObject

/** 颜色 */
@property (nonatomic, strong) UIColor *color;
/** 渐变位置(0~1) */
@property (nonatomic, assign) CGFloat location;

@end
