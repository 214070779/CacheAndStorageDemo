//
//  ContentView.swift
//  CacheAndStorageDemo
//
//  Created by Yangyang Wen on 2022/8/4.
//

import SwiftUI
import Foundation

struct ContentView: View {
  var Messages = [
    Message(name: "Cache", destination: AnyView(CacheUIView())),
    Message(name: "Plists", destination: AnyView(PlistsUIView())),
    Message(name: "UserDefaults", destination: AnyView(UserDefaultsUIView())),
    Message(name: "CoreData", destination: AnyView(CoreDataUIView()))
  ]
  
  var body: some View {
    NavigationView{
      List(Messages,id: \.name){ message in
        NavigationLink {
          message.destination
        } label: {
          Text(message.name)
        }
      }
    }
  }
}

struct Message: Identifiable {
  let id = UUID()
  let name: String
  var destination: AnyView?
}


