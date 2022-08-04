//
//  CoreDataUIView.swift
//  CacheAndStorageDemo
//
//  Created by Yangyang Wen on 2022/8/1.
//

import SwiftUI
import CoreData

struct CoreDataUIView: View {
  @Environment(\.managedObjectContext) var viewContext
  
  @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
  
  var body: some View {
    List{
      ForEach(students, id:\.id){ student in
        Text(student.name ?? "")
      }.onDelete(perform: deleteRow(at:))
    }
    
    Button(action: {
      let firstNames = ["赵", "钱", "孙", "李", "周"]
      let lastNames = ["三", "四", "五", "六"]
      
      let chosenFirstName = firstNames.randomElement()!
      let chosenLastName = lastNames.randomElement()!
      
      let student = Student(context: self.viewContext)
      //      let fec:NSFetchRequest = Student.fetchRequest()
      //      let sortDescriptor = NSSortDescriptor(key: "time", ascending: true)
      //      fec.sortDescriptors = [sortDescriptor]
      //      let items = try! viewContext.fetch(fec)
      //      for item in items {
      //        print("测一下\(item.time)")
      //      }
      student.id = UUID()
      student.name = chosenFirstName + chosenLastName
      student.time = Date()
      try? self.viewContext.save()
    }) {
      Text("添加")
    }
  }
  
  func deleteRow(at offsets: IndexSet)  {
    withAnimation {
      offsets.map {students[$0]}.forEach(viewContext.delete)
      do {
        try viewContext.save()
      } catch {
        let nsError = error as NSError
        fatalError("Unresolved error\(nsError)")
      }
    }
  }
}



