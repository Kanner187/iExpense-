//
//  AddExpense.swift
//  iExpense
//
//  Created by Levit Kanner on 07/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI

struct AddExpense: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var itemName = ""
    @State private var itemAmount = ""
    @State private var itemType = "business"
    @ObservedObject var expenses: Expense
    @State private var alertShowing = false
    @State private var message = ""
    @State private var title = ""
    
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
                self.presentationMode.wrappedValue.dismiss()
            }){
                Text("Cancel")
            })
            
        }
        .alert(isPresented: $alertShowing) { () -> Alert in
            Alert(title: Text(self.title), message: Text(self.message), dismissButton: .default(Text("Okay")))
        }
    }
    
    //Methods
    func saveItem() {
        guard let amount = Double(itemAmount) else {
            configureAlert(title: "Invalid amount", message: "Enter item's amount")
            return
        }
        guard itemName != "" else {
            configureAlert(title: "Name can not be empty", message: "Enter item name")
            return
        }
        let item = ExpenseItem(name: self.itemName , type: self.itemType , amount: amount)
        self.expenses.items.append(item)
        presentationMode.wrappedValue.dismiss()
    }
    
    func configureAlert(title: String , message: String){
        alertShowing = true
        self.title = title
        self.message = message
    }
}

struct AddExpense_Previews: PreviewProvider {
    static var previews: some View {
        AddExpense(expenses: Expense())
    }
}
