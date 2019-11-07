//
//  Expense.swift
//  iExpense
//
//  Created by Levit Kanner on 07/11/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable , Codable{
    let id = UUID()
    var name: String
    var type: String
    var amount: Double
}

class Expense: ObservableObject{
    
    @Published var items: [ExpenseItem] {
        didSet{
            let jsonEncoder = JSONEncoder()
            if let encodedData = try? jsonEncoder.encode(items){
                UserDefaults.standard.set(encodedData, forKey: "Items")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decodedData
                return
            }
        }
        self.items = []
    }
}
