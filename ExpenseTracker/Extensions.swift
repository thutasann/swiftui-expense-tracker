//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/2/22.
//

import Foundation
import SwiftUI


// MARK: - Color Extensions
extension Color{
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)
}


// MARK: - Color Formatter
extension DateFormatter{
    static let allNumericUSA: DateFormatter = {
        print("Initializing DateFormatter")
        let formatter = DateFormatter();
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()
}

// MARK: - String
extension String{
    func dateParsed() -> Date{
        guard let parsedDate = DateFormatter.allNumericUSA.date(from: self) else { return Date() }
        return parsedDate
    }
}

// MARK: - To Make Date Strideable For Stride in Transaction ListView Model
extension Date: Strideable{
    func formatted() -> String{
        return self.formatted(.dateTime.year().month().day())
    }
}

// MARK: - Double Rounded Value
extension Double {
    func roundedTo2Digits() -> Double{
        return (self * 100).rounded() / 100
    }
}
