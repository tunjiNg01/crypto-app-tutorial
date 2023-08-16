//
//  PortfolioDataService.swift
//  cryptoApp
//
//  Created by MACBOOK PRO on 16/08/2023.
//

import Foundation
import CoreData

class PortfolioDataService {
    private let container: NSPersistentContainer
    private let containerName = "PortfolioContainer"
    private let entityName = "PortfolioEntity"
    @Published var savedEntity: [PortfolioEntity] = []
    
    init(){
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores {( _, error) in
            if let error = error {
                print("Error loading core container: \(error)")
            }
        }
        
        self.getPortfolio()
    }
    func updatePortfolio(coin: CoinModel, amount: Double) {
        // check item exist
        if let entity = savedEntity.first(where: {$0.coinID == coin.id}){
            if amount > 0 {
                update(entity: entity, amount: amount)
            }else {
                delete(entity: entity)
            }
        }else{
            add(coin: coin, amount: amount)
        }
            
    }
    
    // MARK: Private
    private func getPortfolio() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
           savedEntity = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching portfolio: \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double){
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.amount = amount
        applyChanges()
    }
    
    private func save(){
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving in to core data: \(error)")
        }
    }
    
    private func update(entity: PortfolioEntity, amount: Double){
        entity.amount = amount
        applyChanges()
    }
    
    private func delete(entity: PortfolioEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}
