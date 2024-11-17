//
//  RecipeList.swift
//  FetchStaffAssessment
//
//  Created by Patrick Roteman on 11/16/24.
//

import Foundation

/**
 Represents the top level response from the service endpoint
 */
struct RecipeList: Decodable, Equatable {
	let recipes: [Recipe]
}
