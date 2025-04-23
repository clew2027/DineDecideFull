//
//  SwipingView.swift
//  DineDecide
//
//  Created by Charlotte Lew on 4/22/25.
//


import SwiftUI

struct SwipingView: View {
    let filters: FilterOptions
    let filteredRestaurants: [Restaurant]
    //charlotte edited:
    @State private var favoriteRestaurants: [Restaurant] = []

    @State private var currentIndex = 0
    @State private var dragOffset: CGSize = .zero
    @State private var navigateToDetail = false
    @State private var selectedRestaurant: Restaurant?
    @State private var swipeFeedbackIcon: String? = nil
    @State private var showSwipeFeedback = false


    init(filters: FilterOptions) {
        self.filters = filters

        let mockRestaurants: [Restaurant] = [
            Restaurant(
                name: "Chipotle",
                latitude: 39.952,
                longitude: -75.193,
                numDollarSigns: 1,
                cuisine: "Mexican",
                popularDishes: ["Burrito", "Bowl"],
                atmosphere: "Casual",
                parking: false,
                imageName: "chipotle",
                rating: 4.3
            ),
            Restaurant(
                name: "Sabrina's Cafe",
                latitude: 39.950,
                longitude: -75.199,
                numDollarSigns: 2,
                cuisine: "American",
                popularDishes: ["Stuffed French Toast"],
                atmosphere: "Cozy",
                parking: true,
                imageName: "sabrinas",
                rating: 4.7
            )
        ]

        self.filteredRestaurants = mockRestaurants.filter { restaurant in
            (filters.selectedCuisine == "Any" || restaurant.cuisine == filters.selectedCuisine) &&
            restaurant.numDollarSigns <= filters.maxPriceLevel &&
            restaurant.rating >= filters.minRating
        }
    }

    var body: some View {
        VStack(spacing: 10) {
            
            Text("Recommendations")
                .font(.largeTitle)
                .bold()

            if currentIndex < filteredRestaurants.count {
                let restaurant = filteredRestaurants[currentIndex]
                
                Text(restaurant.name)
                    .font(.title2)
                    .bold()
                    .padding(.top, 2)

                RestaurantCardView(
                    restaurant: restaurant,
                    dragOffset: dragOffset,
                    showSwipeFeedback: showSwipeFeedback,
                    swipeFeedbackIcon: swipeFeedbackIcon
                )
                
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Prevent dragging down
                            if value.translation.height >= 0 {
                                dragOffset = CGSize(width: value.translation.width, height: 0)
                            } else {
                                dragOffset = value.translation
                            }
                            // Update live swipe direction icon
                            updateSwipeIcon(for: value.translation)
                        }

                        .onEnded { value in
                            let dx = value.translation.width
                            let dy = value.translation.height
                            let angle = atan2(dy, dx) * 180 / .pi

                            withAnimation(.easeInOut(duration: 0.2)) {
                                if dy < -30 && abs(dx) < 100 {
                                    // Swipe up
                                    selectedRestaurant = restaurant
                                    dragOffset = .zero
                                    navigateToDetail = true

                                } else if dx > 30 && abs(angle) < 60 {
                                    // Swipe right to fav
                                    dragOffset = CGSize(width: 500, height: 0)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        favoriteRestaurants.append(restaurant)
                                        advanceToNextRestaurant()
                                    }

                                } else if dx < -30 && abs(angle) > 150 {
                                    // Swipe left to skip
                                    dragOffset = CGSize(width: -500, height: 0)
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        advanceToNextRestaurant()
                                    }

                                } else {
                                    // Not enough swipe — reset
                                    dragOffset = .zero
                                }
                            }

                            // Always reset icon after swipe ends
                            showSwipeFeedback = false
                            swipeFeedbackIcon = nil
                        }
                )

            } else {
                Text("No new restaurants to show.")
                    .padding()
            }
            if (selectedRestaurant != nil) {
                NavigationLink(
                    destination: DetailView(restaurant: selectedRestaurant!),
                    isActive: $navigateToDetail
                ) {
                    EmptyView()
                }
                .onChange(of: navigateToDetail) { newValue in
                    if !newValue {
                        dragOffset = .zero
                    }
                }
            }
            
            
            if currentIndex < filteredRestaurants.count {
            VStack(spacing: 4) {
                Text("⬅️ Swipe left to skip")
                Text("➡️ Swipe right to favorite")
                Text("⬆️ Swipe up for details")
                Text(" ")
                Text("App resets after going back")
            }
            .font(.footnote)
            .foregroundColor(.gray)
            .padding(.top, 8)
        }
        }
        
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGray6))
        .navigationBarBackButtonHidden(false)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: FavoritesView(favorites: favoriteRestaurants)) {
                    Text("show favsss")//favorite view
                }
            }
        }
    }


    // MARK: - Helpers

    private func advanceToNextRestaurant() {
        withAnimation {
            dragOffset = .zero
            currentIndex += 1
        }
    }
    
    private func triggerSwipeFeedback() {
        withAnimation(.easeIn(duration: 0.1)) {
            showSwipeFeedback = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation(.easeOut(duration: 0.3)) {
                showSwipeFeedback = false
            }
        }
    }
    
    private func updateSwipeIcon(for translation: CGSize) {
        let dx = translation.width
        let dy = translation.height

        if dy < -20 && abs(dx) < 100 {
            swipeFeedbackIcon = "arrow.up"
            showSwipeFeedback = true
        } else if dx > 20 && abs(dy) < 100 {
            swipeFeedbackIcon = "heart.fill"
            showSwipeFeedback = true
        } else if dx < -20 && abs(dy) < 100 {
            swipeFeedbackIcon = "xmark"
            showSwipeFeedback = true
        } else {
            showSwipeFeedback = false
        }
    }


}
