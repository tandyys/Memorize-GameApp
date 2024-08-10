//
//  SwiftDataView.swift
//  MemorizeApp
//
//  Created by tandyys on 10/07/24.
//

import SwiftUI
import SwiftData

struct SwiftDataView: View {
    
    @Environment (\.modelContext) private var context
    @Query private var items: [TestModel]
    
    var body: some View {
        VStack {
            Button("Save data") {
                addItem()
            }
            
            List {
                ForEach(items) { i in
                    HStack {
                        Text(i.type)
                        Divider()
                        Text(String(i.glutenAmount))
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteItem(items[index])
                    }
                }
            }
        }
    }
    
    func addItem() {
        let item = TestModel(glutenAmount: 124, type: "Before eat")
        context.insert(item)
    }
    
    func deleteItem(_ item: TestModel) {
        context.delete(item)
    }
}

#Preview {
    SwiftDataView()
}
