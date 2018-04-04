//
//  ViewController1.h
//  LZBLEManager
//
//  Created by luyoudui on 2017/4/17.
//  Copyright © 2017年 Hangzhou Lianzhong Medical Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZBluetooth.h"
@interface ViewController1 : UIViewController

@property (nonatomic,strong) LZBluetooth *LZBle;
@property (nonatomic,strong) CBPeripheral *peripheral;

@end
