//
//  AddExpense.swift
//  iExpense
//
//  Created by Levit Kanner on 07/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI

struct AddExpense: View {
    @State private var itemName = ""
    @State private var itemAmount = ""
    @State private var itemType = "business"
    @ObservedObject var expenses: Expense
    @State private var alertShowing = false
    
   static let types = ["business" , "domestic"]
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Item name" , text: $itemName)
                Section{
                    Picker("Select Item type" , selection: $itemType){
                        ForEach(Self.types , id: \.self){
                            Text($0)
                        }
                    }
                .pickerStyle(SegmentedPickerStyle())
                }
                Section{
                    TextField("Enter Amount", text: $itemAmount)
                        .keyboardType(.numberPad)
                }
                Button(action: {
                    self.saveItem()
                }){
                    HStack{
                        Text("Save")
                        Image(systemName: "arrow.down.to.line.alt")
                    }
                }
            }
        .navigationBarTitle("Add New Expense")
            .navigationBarItems(trailing: Button(action: {
                //Perform button action
            }){
                Text("Cancel")
            })
            
        }
    }
    
    //Methods
    func saveItem() {
        guard let amount = Double(itemAmount) else { return }
        let item = ExpenseItem(name: self.itemName , type: self.itemType , amount: amount)
        self.expenses.items.append(item)
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense(expenses: Expense())
    }
}
