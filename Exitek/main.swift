//
//  main.swift
//  Exitek
//
//  Created by Sergey Simashov on 04.09.2022.
//

// Implement mobile phone storage protocol
// Requirements:
// - Mobiles must be unique (IMEI is an unique number)
// - Mobiles must be stored in memory

import Darwin

protocol MobileStorage {
func getAll() -> Set<Mobile>
func findByImei(_ imei: String) -> Mobile?
func save(_ mobile: Mobile) throws -> Mobile
func delete(_ product: Mobile) throws
func exists(_ product: Mobile) -> Bool
}

struct Mobile: Hashable {
let imei: String
let model: String
}

enum Errors: Error{
    case thisMobileIsNotUniq
    case noSuchProduct
}

class Storage: MobileStorage {
    
   private var storage = Set<Mobile>()

    func getAll() -> Set<Mobile> {
        return storage
    }
    
    func findByImei(_ imei: String) -> Mobile?{
        let mobile = storage.first(where: {$0.imei == imei})
        return mobile
    }
    
    func save(_ mobile: Mobile) throws -> Mobile{
        guard !storage.contains(mobile) else {
            throw Errors.thisMobileIsNotUniq
        }
        storage.insert(mobile)
        return mobile
    }
    
    func delete(_ product: Mobile) throws{
        guard storage.contains(product) else {
            throw Errors.noSuchProduct
        }
        storage.remove(product)
    }
    
    func exists(_ product: Mobile) -> Bool{
        return storage.contains(product)
    }
}
