//
//  LZBLECentralManager.h
//  LZBLEManager
//
//  Created by luyoudui on 2017/4/11.
//  Copyright © 2017年 Hangzhou Lianzhong Medical Technology Co., Ltd. All rights reserved.
//

/******说明******/

/*
 所有蓝牙操作会发生的代理的都在这里，都以block形式传出去
 */

#import <Foundation/Foundation.h>
#import "LZBLESpeaker.h"

@interface LZBLECentralManager : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
@public
    // 主设备
    CBCentralManager *centralManager;
    
    // 回叫方法
    LZBLESpeaker *speaker;
}

// 扫描Peripherals
- (void)scanPeripherals;
// 连接Peripherals
- (void)connectToPeripheral:(CBPeripheral *)peripheral;
// 断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral;
// 停止扫描
- (void)cancelScan;

@end
