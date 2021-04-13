//
//  ViewController.swift
//  JADatePicker
//
//  Created by enan on 04/07/2021.
//  Copyright (c) 2021 enan. All rights reserved.
//

import UIKit
import JADatePicker
@available(iOS 13.0, *)
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let button:UIButton = UIButton()
        button.frame = CGRect(x: 100, y:200, width: 180, height: 50)
        button.center = self.view.center
        button.backgroundColor = UIColor.orange
        self.view.addSubview(button)
        button.setTitle("选择时间", for: UIControl.State.normal)
        button.setTitleColor(UIColor.white, for: UIControl.State.normal)
        button.layer.cornerRadius = 10;
        //不传递触摸对象（即点击的按钮）
        button.addTarget(self,action:#selector(clickBtn),for:.touchUpInside)
    }
    /*按钮点击实现方法*/
    @objc  private func clickBtn(button:UIButton){
        let vc:JADateViewController = JADateViewController()
        vc.title = "开始时间"
        vc.format = DateFormat.default.value
        //vc.current_time = "2021-04-27 09:57"
        vc.current_time = vc.date2String(NSDate(timeIntervalSinceNow: 0) as Date, format: vc.format)
        vc.callBackBlock  = {(time:String, date:Date) -> Void in
            print("==最终时间=="+time)
        }
        vc.showDatePicker(viewController: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

