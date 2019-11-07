//
//  Expense.swift
//  iExpense
//
//  Created by Levit Kanner on 07/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable{
    let id = UUID()
    var name: String
    var type: String
    var amount: Double
}

class Expense: ObservableObject{
   @Published var items = [ExpenseItem]()
}
