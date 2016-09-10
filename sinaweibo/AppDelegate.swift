//
//  AppDelegate.swift
//  sinaweibo
//
//  Created by 王云 on 16/8/29.
//  Copyright © 2016年 王云. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //测试解档
        // 解档
        let file = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as NSString).appendingPathComponent("userAccount.archive")
        let account = NSKeyedUnarchiver.unarchiveObject(withFile: file) as? HMUserAccount
        print(account)
        
        //注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(changeVC(noti:)), name: NSNotification.Name(HMChangeRootVCNotification), object: nil)
        
        
        //创建window
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //设置根控制器
        window?.rootViewController = WYNavigationController(rootViewController: WYComposeViewController())
        
//        window?.rootViewController = HMUserAccountViewModel.sharedModel.userLogon ? WYWelcomeViewController() : WYTabBarController()
        
        //显示
        window?.makeKeyAndVisible()
        
        
        return true
    }
    
    func changeVC(noti:Notification) {
        //如果不是空,代表是OAuth发的通知
        if noti.object != nil {
            window?.rootViewController = WYWelcomeViewController()
        }
        else
        {
            //欢迎页面过后跳转到主界面
            window?.rootViewController = WYTabBarController()
            
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

