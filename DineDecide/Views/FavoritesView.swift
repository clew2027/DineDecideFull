//
//  FavoritesView.swift
//  DineDecide
//
//  Created by Charlotte Lew on 4/22/25.
//

import SwiftUI

struct FavoritesView: View {
    var favorites: [Restaurant]
    
    var body: some View {
        Group {
            if favorites.isEmpty {
                emptyStateView
            } else {
                favoritesList
            }
        }
        .navigationTitle("Favorites")
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 20) {
            Image(systemName: "heart.fill")
                .font(.system(size: 60))
                .foregroundColor(.pink)
                .opacity(0.3)
            
            VStack(spacing: 8) {
                Text("No Favorites Yet")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Tap the heart icon on restaurants to add them to your favorites")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 40)
            }
        }
        .frame(maxHeight: .infinity)
    }
    
    private var favoritesList: some View {
        List {
            ForEach(favorites, id: \.name) { restaurant in
                NavigationLink(destination: DetailView(restaurant: restaurant)) {
                    RestaurantRow(restaurant: restaurant)
                }
                .listRowSeparator(.hidden)
                .listRowInsets(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
    }
}

struct RestaurantRow: View {
    let restaurant: Restaurant
    
    var body: some View {
        HStack(spacing: 16) {
            // Restaurant image
            Image(restaurant.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipped()
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                // Name and rating
                HStack(alignment: .top) {
                    Text(restaurant.name)
                        .font(.headline)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.caption)
                        
                        Text(String(format: "%.1f", restaurant.rating))
                            .font(.subheadline)
                    }
                }
                
                // Cuisine type
                Text(restaurant.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // Price and parking
                HStack(spacing: 12) {
                    Text(String(repeating: "$", count: restaurant.numDollarSigns))
                        .font(.subheadline)
                    
                    if restaurant.parking {
                        HStack(spacing: 4) {
                            Image(systemName: "parkingsign")
                                .font(.caption)
                            Text("Parking")
                                .font(.caption)
                        }
                        .foregroundColor(.green)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }
}

// Preview
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                FavoritesView(favorites: [])
            }
            .previewDisplayName("Empty State")
            
            NavigationView {
                FavoritesView(favorites: [
                    Restaurant(
                        name: "Gourmet Bistro",
                        latitude: 37.7749,
                        longitude: -122.4194,
                        numDollarSigns: 3,
                        cuisine: "French Contemporary",
                        popularDishes: ["Duck Confit", "Bouillabaisse", "Crème Brûlée"],
                        atmosphere: "Elegant dining with a modern twist",
                        parking: true,
                        imageName: "restaurant1",
                        rating: 4.5
                    ),
                    Restaurant(
                        name: "Pasta Paradise",
                        latitude: 37.7750,
                        longitude: -122.4184,
                        numDollarSigns: 2,
                        cuisine: "Italian",
                        popularDishes: ["Spaghetti Carbonara", "Tiramisu"],
                        atmosphere: "Cozy family restaurant",
                        parking: false,
                        imageName: "restaurant2",
                        rating: 4.2
                    )
                ])
            }
            .previewDisplayName("With Favorites")
        }
    }
}
