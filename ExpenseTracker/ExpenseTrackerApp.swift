//
//  ExpenseTrackerApp.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/2/22.
//

// @StateObject -> Follows the lifecycle of the App
// EnvironmentObject -> a property wrapper that we use to share data between many views

import SwiftUI

@main
struct ExpenseTrackerApp: App {
    
    @StateObject var transactionListVM = TransactionListViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
