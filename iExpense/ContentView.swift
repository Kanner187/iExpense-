//
//  ContentView.swift
//  iExpense
//
//  Created by Levit Kanner on 06/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expense = Expense()
    @State private var showingForm = false
    

  var body: some View {
    NavigationView{
        VStack{
            List{
                ForEach(expense.items){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text("\(item.name)")
                                .fontWeight(.bold)
                            Text("\(item.type)")
                                .font(.system(size: 10))
                        }
                        Spacer()
                        Text("$\(item.amount , specifier: "%.2f")")
                    }
                }
                .onDelete { (IndexSet) in
                    self.deleteRows(offsets: IndexSet)
                }
            }
        }
    .navigationBarTitle("iExpense")
    .navigationBarItems(leading: EditButton(), trailing: Button(action: {
        self.showingForm = true
    }){
        Image(systemName: "plus")
    })
    .sheet(isPresented: $showingForm) {
        AddExpense(expenses: self.expense)
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
