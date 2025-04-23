//
//  RestaurantCardView.swift
//  DineDecide
//
//  Created by Charlotte Lew on 4/22/25.
//

import SwiftUI

struct RestaurantCardView: View {
    let restaurant: Restaurant
    let dragOffset: CGSize
    let showSwipeFeedback: Bool
    let swipeFeedbackIcon: String?

    var body: some View {
        VStack(spacing: 10) {
            Image(restaurant.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 250)
                .clipped()
                .cornerRadius(10)

            ZStack {
                VStack(spacing: 5) {
                    Text("Cuisine: \(restaurant.cuisine)")
                    Text("Price: \(String(repeating: "$", count: restaurant.numDollarSigns))")
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(restaurant.rating.rounded()) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                        Text("(\(String(format: "%.1f", restaurant.rating)))")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Text("Atmosphere: \(restaurant.atmosphere)")
                    Text("Popular: \(restaurant.popularDishes.joined(separator: ", "))")
                    Text(restaurant.parking ? "🚗 Parking Available" : "No Parking")
                    
                    // Placeholder distance
                    Text("~1.2 mi from you") // distance backend
                }

                if showSwipeFeedback, let icon = swipeFeedbackIcon {
                    Image(systemName: icon)
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(icon == "heart.fill" ? .red :
                                         icon == "xmark" ? .gray : .blue)
                        .opacity(showSwipeFeedback ? 1 : 0.6)
                        .transition(.opacity)
                }
            }
            .font(.subheadline)
            .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding(.horizontal)
        .offset(dragOffset)
    }
}
