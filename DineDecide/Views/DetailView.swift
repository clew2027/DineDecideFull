//
//  DetailView.swift
//  DineDecide
//
//  Created by Charlotte Lew on 4/22/25.
//

import SwiftUI

struct DetailView: View {
    let restaurant: Restaurant
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Header
                ZStack(alignment: .bottomLeading) {
                    Image(restaurant.imageName) //CHANGE THIS
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                    
                    LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                                 startPoint: .top,
                                 endPoint: .bottom)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(restaurant.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        HStack {
                            Text(restaurant.cuisine)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Text(String(repeating: "$", count: restaurant.numDollarSigns))
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        
                        HStack {
                            ForEach(0..<5, id: \.self) { star in
                                Image(systemName: "star.fill")
                                    .foregroundColor(star < Int(restaurant.rating) ? .yellow : .gray)
                            }
                        }
                    }
                    .padding()
                }
                
                // Details section
                VStack(alignment: .leading, spacing: 16) {
                    // Atmosphere
                    if !restaurant.atmosphere.isEmpty {
                        DetailSection(title: "Atmosphere", content: restaurant.atmosphere)
                    }
                    
                    // Popular dishes
                    if !restaurant.popularDishes.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Popular Dishes")
                                .font(.headline)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 12) {
                                    ForEach(restaurant.popularDishes, id: \.self) { dish in
                                        Text(dish)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 12)
                                            .background(Color.blue.opacity(0.1))
                                            .cornerRadius(12)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                            )
                                    }
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                    
                    // Parking
                    HStack(spacing: 8) {
                        Image(systemName: restaurant.parking ? "parkingsign.circle.fill" : "exclamationmark.circle.fill")
                            .foregroundColor(restaurant.parking ? .green : .orange)
                        
                        Text(restaurant.parking ? "Parking Available" : "No Parking")
                            .font(.subheadline)
                    }                    
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            
            Text(content)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}
