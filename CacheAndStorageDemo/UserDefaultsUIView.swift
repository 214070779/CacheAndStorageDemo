//
//  UserDefaultsUIView.swift
//  CacheAndStorageDemo
//
//  Created by Yangyang Wen on 2022/8/1.
//

import SwiftUI

struct UserDefaultsUIView: View {
  
  var testName = Configuration.name
 
  var body: some View {
    VStack(alignment: .leading, spacing: 20) {
      Button {
        useUserDefault()
      } label: {
        Text("测试用户名==\(testName.wrappedValue)")
      }
  
      Button {
        deleteUserName()
      } label: {
        Text("删除用户名")
      }

      Button {
        changeUserName()
      } label: {
        Text("更换用户名")
      }
      
      Button {
        useUserDefaultSaveModel()
      } label: {
        Text("测试自定义Model")
      }
    }
  }
  
  func useUserDefault() {
    let username="张三"
    let password=188888666
    
    // 设置数据到沙盒中
    let userDefault = UserDefaults.standard
    
    // 为 key 注册初始值。
    userDefault.register(defaults: [UserDefaults.key.passWord: "333"])
    userDefault.set(username,forKey:UserDefaults.key.userName)
    userDefault.set(password,forKey:UserDefaults.key.passWord)
    // 设置同步，会立即保存到磁盘 已弃用//userDefault.synchronize()
    
    // 取数据
    print("用户名:\(userDefault.value(forKey:UserDefaults.key.userName)!)")
    print("@AppStorage===\(testName.wrappedValue)")
    
    userDefault.set("名字换了",forKey:UserDefaults.key.userName)
    //打印地址
    printPath()
  }
  
  func deleteUserName()  {
    // 设置数据到沙盒中
    let userDefault = UserDefaults.standard
    // 删除数据
    userDefault.removeObject(forKey: UserDefaults.key.userName)
    print("删除名字:\(userDefault.integer(forKey: UserDefaults.key.userName))")
  }
  
  func changeUserName()  {
    // 设置数据到沙盒中
    //  let userDefault = UserDefaults.standard
    //  userDefault.set("李四",forKey:UserDefaults.key.username)
    testName.wrappedValue = "王五"
  }
  
  func useUserDefaultSaveModel()  {
    let girl = Girl(name: "李明", age: 10)
    
    UserDefaults.standard.setCodableObject(girl, forKey: "girl")
    
    let getPerson = UserDefaults.standard.getCodableObject(Girl.self, with: "girl")
    print(getPerson!.name)
    //打印地址
    printPath()
  }
  
  func printPath() {
    guard let bundleIdentifier = Bundle.main.bundleIdentifier else {
      return
    }
    let path = NSHomeDirectory() + "/Library" + "/Preferences" + "/\(bundleIdentifier)" + ".plist"
    print(path)
  }
}


enum Configuration{
  static let name = AppStorage(wrappedValue: "fatbobman", "userName")
}

extension UserDefaults {
  enum key {
    static let userName = "userName"
    static let passWord = "passWord"
  }
}

extension UserDefaults {
  /// - Parameters:
  /// - object: 泛型的对象
  /// - key: 键
  /// - encoder: 序列化器
  /// 遵守Codable协议的set方法
  public func setCodableObject<T: Codable>(_ object: T, forKey key: String, usingEncoder encoder: JSONEncoder = JSONEncoder()) {
    let data = try? encoder.encode(object)
    set(data, forKey: key)
  }
  /// 遵守Codable协议的get方法
  ///- Parameters:
  ///- type: 泛型的类型
  ///- key: 键
  ///- decoder: 反序列器
  ///Returns: 可选类型的泛型的类型对象
  public func getCodableObject<T: Codable>(_ type: T.Type, with key: String, usingDecoder decoder: JSONDecoder = JSONDecoder()) -> T? {
    guard let data = value(forKey: key) as? Data else { return nil }
    return try? decoder.decode(type.self, from: data)
  }
}


struct Girl: Decodable,Encodable {
  let name: String
  let age: Int
}
