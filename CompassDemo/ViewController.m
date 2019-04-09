//
//  ViewController.m
//  CompassDemo
//
//  Created by fh on 2019/4/9.
//  Copyright © 2019年 fh. All rights reserved.
//

#import "ViewController.h"
#import "CompassImageView.h"

#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate, CompassImageViewDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CompassImageView *compassImageView;
@property (nonatomic, strong) UILabel *degreeLabel;
@property (nonatomic, strong) UILabel *directionLable;
@property (nonatomic, strong) UILabel *bottomLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.distanceFilter = 0;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [_locationManager requestWhenInUseAuthorization];
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager headingAvailable]) {
        [self.locationManager startUpdatingLocation];//开启定位服务
        [self.locationManager startUpdatingHeading];//开始获得航向数据
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"定位功能未开启" message:@"请在设置中打开定位功能" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    _compassImageView = [[CompassImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenWidth)];
    _compassImageView.image = [UIImage imageNamed:@"compass"];
    _compassImageView.center = CGPointMake(screenWidth * 0.5, self.view.frame.size.height * 0.5);
    _compassImageView.delegate = self;
    [self.view addSubview:_compassImageView];
    
    // 底部文字
    _bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _compassImageView.frame.size.height + _compassImageView.frame.origin.y + 15, screenWidth, 40)];
    _bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_bottomLabel];
    
    // 三角图片
    UIImageView *triangleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    triangleImageView.center = CGPointMake(screenWidth * 0.5, _compassImageView.frame.origin.y - 30 - 10);
    triangleImageView.image = [UIImage imageNamed:@"compass_triangle"];
    [self.view addSubview:triangleImageView];
    
    // 方向: 角度
    _degreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 22, triangleImageView.frame.origin.x - 15, 40)];
    _degreeLabel.font = [UIFont systemFontOfSize:15.0];
    _degreeLabel.textColor = [UIColor blackColor];
    [self.view addSubview:_degreeLabel];
    
    // 坐x向x
    _directionLable = [[UILabel alloc] initWithFrame:CGRectMake(triangleImageView.frame.origin.x + triangleImageView.frame.size.width, 22, screenWidth - 15 - triangleImageView.frame.origin.x - triangleImageView.frame.size.width, 40)];
    _directionLable.font = [UIFont systemFontOfSize:15.0];
    _directionLable.textColor = [UIColor blackColor];
    _directionLable.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:_directionLable];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    // 判断当前的方位
    NSString *direction;
    NSString *upDirection;
    NSString *bottomDirection;
    if ((newHeading.magneticHeading >= 337.5 && newHeading.magneticHeading <= 360) ||
        (newHeading.magneticHeading >= 0 && newHeading.magneticHeading <= 22.5)) {
        direction = @"北";
        if (newHeading.magneticHeading >= 337.5 && newHeading.magneticHeading <= 352.5) {
            upDirection = @"壬";
            bottomDirection = @"丙";
        } else if (newHeading.magneticHeading >= 352.5 || newHeading.magneticHeading <= 7.5) {
            upDirection = @"子";
            bottomDirection = @"午";
        } else {
            upDirection = @"葵";
            bottomDirection = @"丁";
        }
    } else if ((newHeading.magneticHeading >= 22.5) && (newHeading.magneticHeading <= 67.5)) {
        direction = @"东北";
        if (newHeading.magneticHeading <= 37.5) {
            upDirection = @"丑";
            bottomDirection = @"未";
        } else if (newHeading.magneticHeading >= 37.5 && newHeading.magneticHeading <= 52.5) {
            upDirection = @"艮";
            bottomDirection = @"坤";
        } else {
            upDirection = @"寅";
            bottomDirection = @"申";
        }
    } else if ((newHeading.magneticHeading >= 67.5) && (newHeading.magneticHeading <= 112.5)) {
        direction = @"东";
        if (newHeading.magneticHeading <= 82.5) {
            upDirection = @"甲";
            bottomDirection = @"庚";
        } else if (newHeading.magneticHeading >= 82.5 && newHeading.magneticHeading <= 97.5) {
            upDirection = @"卯";
            bottomDirection = @"酉";
        } else {
            upDirection = @"乙";
            bottomDirection = @"辛";
        }
    } else if ((newHeading.magneticHeading >= 112.5) && (newHeading.magneticHeading <= 157.5)) {
        direction = @"东南";
        if (newHeading.magneticHeading <= 127.5) {
            upDirection = @"辰";
            bottomDirection = @"戌";
        } else if (newHeading.magneticHeading >= 127.5 && newHeading.magneticHeading <= 142.5) {
            upDirection = @"巽";
            bottomDirection = @"乾";
        } else {
            upDirection = @"己";
            bottomDirection = @"亥";
        }
    } else if ((newHeading.magneticHeading >= 157.5) && (newHeading.magneticHeading <= 202.5)) {
        direction = @"南";
        if (newHeading.magneticHeading <= 172.5) {
            upDirection = @"丙";
            bottomDirection = @"壬";
        } else if (newHeading.magneticHeading >= 172.5 && newHeading.magneticHeading <= 182.5) {
            upDirection = @"午";
            bottomDirection = @"子";
        } else {
            upDirection = @"丁";
            bottomDirection = @"葵";
        }
    } else if ((newHeading.magneticHeading >= 202.5) && (newHeading.magneticHeading <= 247.5)) {
        direction = @"西南";
        if (newHeading.magneticHeading <= 217.5) {
            upDirection = @"未";
            bottomDirection = @"丑";
        } else if (newHeading.magneticHeading >= 217.5 && newHeading.magneticHeading <= 232.5) {
            upDirection = @"坤";
            bottomDirection = @"艮";
        } else {
            upDirection = @"申";
            bottomDirection = @"寅";
        }
    } else if ((newHeading.magneticHeading >= 247.5) && (newHeading.magneticHeading <= 292.5)) {
        direction = @"西";
        if (newHeading.magneticHeading <= 262.5) {
            upDirection = @"庚";
            bottomDirection = @"甲";
        } else if (newHeading.magneticHeading >= 262.5 && newHeading.magneticHeading <= 277.5) {
            upDirection = @"酉";
            bottomDirection = @"卯";
        } else {
            upDirection = @"辛";
            bottomDirection = @"乙";
        }
    } else if ((newHeading.magneticHeading >= 292.5) && (newHeading.magneticHeading <= 337.5)) {
        direction = @"西北";
        if (newHeading.magneticHeading <= 307.5) {
            upDirection = @"戌";
            bottomDirection = @"辰";
        } else if (newHeading.magneticHeading >= 307.5 && newHeading.magneticHeading <= 322.5) {
            upDirection = @"乾";
            bottomDirection = @"巽";
        } else {
            upDirection = @"亥";
            bottomDirection = @"己";
        }
    }
    
    CGFloat heading = -1 * ((newHeading.magneticHeading) / 180.0 * M_PI);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.compassImageView.transform = CGAffineTransformMakeRotation(heading);
        weakSelf.degreeLabel.text = [NSString stringWithFormat:@"%@ %i°", direction, (int)newHeading.magneticHeading];
        weakSelf.directionLable.text = [NSString stringWithFormat:@"坐%@向%@", bottomDirection, upDirection];
    }];
}

- (void)compassImageView:(CompassImageView *)imageView didSelectDirection:(CompassTapDirection)direction {
    switch (direction) {
        case CompassTapDirectionNorth:
            _bottomLabel.text = @"北";
            break;
        case CompassTapDirectionNorthEast:
            _bottomLabel.text = @"东北";
            break;
        case CompassTapDirectionEast:
            _bottomLabel.text = @"东";
            break;
        case CompassTapDirectionEastSouth:
            _bottomLabel.text = @"东南";
            break;
        case CompassTapDirectionSouth:
            _bottomLabel.text = @"南";
            break;
        case CompassTapDirectionSouthWest:
            _bottomLabel.text = @"西南";
            break;
        case CompassTapDirectionWest:
            _bottomLabel.text = @"西";
            break;
        case CompassTapDirectionWestNorth:
            _bottomLabel.text = @"西北";
            break;
            
        default:
            break;
    }
}

@end
