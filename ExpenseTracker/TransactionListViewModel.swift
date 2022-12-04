//
//  TransactionListViewModel.swift
//  ExpenseTracker
//
//  Created by Thuta sann on 12/3/22.
// @Published -> send notifications to the subscribers whenever its value is changed

import Foundation
import Combine

final class TransactionListViewModel: ObservableObject {
    
    
    @Published var transctions: [Transaction] = [];
    
    // MARK: Cancellables
    private var cancellables = Set<AnyCancellable>();
    
    // MARK: - Get Transactions Ini
    init(){
        getTransactions()
    }
    
    // MARK: - Fetch Transacations from the Network
    func getTransactions(){
        
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        // Fetching from URL
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print("Error Fetching Transactions", error.localizedDescription)
                case .finished:
                    print("Finish Fetching Transctions")
                }
            } receiveValue: { [weak self] result in
                self?.transctions = result
                dump(self?.transctions)
            }
            .store(in: &cancellables)
    }
    
}
