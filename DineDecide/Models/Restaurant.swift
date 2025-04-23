//
//  Restaurant.swift
//  DineDecide
//
//  Created by Charlotte Lew on 4/22/25.
//


import SwiftUI


public struct Restaurant {
    public var name: String
    public var latitude: Double
    public var longitude: Double
    public var numDollarSigns: Int
    
    public var cuisine: String
    public var popularDishes: [String]
    public var atmosphere: String
    public var parking: BooleanLiteralType
    public var imageName: String
    public var rating: Double
}
