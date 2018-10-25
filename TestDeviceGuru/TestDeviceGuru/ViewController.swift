//
//  ViewController.swift
//  TestDeviceGuru
//
//  Created by Inder Kumar Rathore on 21/09/16.
//  Copyright © 2016 Inder Kumar Rathore. All rights reserved.
//

import UIKit
import DeviceGuru

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let dg = DeviceGuru()
    print("\(String(describing: dg.hardware()))")
    print("\(String(describing: dg.platform()))")
    print("\(String(describing: dg.hardwareNumber()))")
    print("\(String(describing: dg.hardwareDescription()))")
    print("\(String(describing: dg.hardwareString()))")
  }
}

