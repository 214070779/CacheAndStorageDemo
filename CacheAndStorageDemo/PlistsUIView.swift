//
//  PlistsUIView.swift
//  CacheAndStorageDemo
//
//  Created by Yangyang Wen on 2022/8/1.
//

import SwiftUI

struct PlistsUIView: View {
  var body: some View {
    VStack(alignment: .leading, spacing: nil) {
      Button {
        usePlist()
      } label: {
        Text("测试Plist")
      }
    }
  }
  
  func usePlist()  {
    let arrayPath = NSHomeDirectory() + "/Library" + "/temp" + "arrayToPlist.plist"
    let dictionaryPath = NSHomeDirectory() + "/Library" + "/temp" + "dictonaryToPlist.plist"
  
    // 待写入数据
    let array:NSArray = ["bei", "jing", "huan", "ying", "nin"]
    // 待写入数据
    let dictionary:NSDictionary = ["name":"chen chao", "age":"18", "info":"Good Teacher"]
    
    // 写 Plist 文件
    // 数组写入 plist 文件
    array.write(toFile: arrayPath, atomically: true)
    
    // 字典写入 plist 文件
    dictionary.write(toFile: dictionaryPath, atomically:true)
    
    // 读 Plist 文件
    let arrayFromPlist:NSArray? = NSArray(contentsOfFile: arrayPath)
    let dicFromPList:NSDictionary? = NSDictionary(contentsOfFile: dictionaryPath)
    print(arrayFromPlist as Any)
    print(dicFromPList as Any)
  }
}
