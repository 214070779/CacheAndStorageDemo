//
//  CacheUI.swift
//  CacheAndStorageDemo
//
//  Created by Yangyang Wen on 2022/8/1.
//https://github.com/apple/swift-corelibs-foundation/blob/bfe81824d9b8a98b84dcc5c022c5a9d567dbc224/Foundation/NSCache.swift

import SwiftUI

struct CacheUIView: View {
  
  var body: some View {
    Button(action: {
      testCache()
    }) {
      Text("测试cache")
    }
  }
  
  func testCache()  {
    let cache = NSCache<NSString, NSString>()
//    cache.countLimit = 2;
//    cache.totalCostLimit = 0;
    //存放字符串
    let arr:[NSString] = ["张三","李四","王五","赵六"]
    
    for i in 0..<arr.count {
      cache.setObject(arr[i], forKey: "\(i)" as NSString)
    }
    cache.object(forKey: "\(1)" as NSString)
    for i in 0..<arr.count {
      let content =  cache.object(forKey: "\(i)" as NSString)
      print(content as Any)
    }
  }
}
