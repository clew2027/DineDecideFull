//
//  HomeView.swift
//  DineDecide
//
//  Created by Charlotte Lew on 4/22/25.
//

import SwiftUI

struct HomeView: View {
    @Environment(LocationManager.self) private var locationManager: LocationManager
    @State private var maxPriceLevel = 3
    @State private var selectedCuisine = "Any"
    @State private var minRating = 0.0

    let cuisineOptions = ["Any", "American", "Asian", "Mexican", "Italian", "Mediterranean"]

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 28) {
                Text(locationManager.getUserLocationString())

                Spacer(minLength: 30)

                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.orange)

                Text("DineDecide")
                    .font(.largeTitle)
                    .bold()

                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Cuisine")
                            .font(.headline)
                        Picker("Cuisine", selection: $selectedCuisine) {
                            ForEach(cuisineOptions, id: \.self) { cuisine in
                                Text(cuisine)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Stepper("Max Price: \(String(repeating: "$", count: maxPriceLevel))", value: $maxPriceLevel, in: 1...4)
                        Stepper("Minimum Stars: \(String(format: "%.1f", minRating)) \u{2B50}", value: $minRating, in: 0.0...5.0, step: 0.5)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                NavigationLink(destination: SwipingView(filters: FilterOptions(
                    maxPriceLevel: maxPriceLevel,
                    selectedCuisine: selectedCuisine,
                    minRating: minRating
                ))) {
                    Text("Find Food")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .font(.headline)
                }

                Spacer(minLength: 10)
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
    }
}

