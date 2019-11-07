//
//  ContentView.swift
//  iExpense
//
//  Created by Levit Kanner on 06/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI

enum Type {
    case business
    case domestic
}

struct ExpenseItem: Identifiable{
    let id = UUID()
    var name: String
    var type: Type
    var amount: Double
}

class Expense: ObservableObject{
   @Published var items = [ExpenseItem]()
}



struct FormView: View {
    @State var itemName = ""
    @State var itemType: Type = .business
    
    var body: some View {
        Form{
            Section(header: Text("Item")) {
                TextField("item name", text: $itemName)
            }
        }
    }
}






struct ContentView: View {
    @ObservedObject var expense = Expense()
    @State private var showingForm = false
    
    
    
  var body: some View {
    NavigationView{
        VStack{
            List{
                ForEach(expense.items){ item in
                    Text("\(item.name)")
                }
                .onDelete { (IndexSet) in
                    self.deleteRows(offsets: IndexSet)
                }
            }
        }
    .navigationBarTitle("iExpense")
        .navigationBarItems(trailing: Button(action: {
            //Perform button action
            let expen = ExpenseItem(name: "Rice", type: .business, amount: 12)
            self.expense.items.append(expen)
            
            self.showingForm.toggle()
        }){
            Image(systemName: "plus")
        })
            .sheet(isPresented: $showingForm) {
                FormView()
        }
    }
    }
    
    
    
    //Methods
    func deleteRows(offsets: IndexSet){
        self.expense.items.remove(atOffsets: offsets)
    }
}










struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
