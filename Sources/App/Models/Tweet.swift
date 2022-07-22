//
//  File.swift
//  
//
//  Created by Georgi Markov on 7/20/22.
//

import Vapor
import Fluent
import Foundation

// 1. Define a class that conforms to Model.
final class Tweet: Model {
    // 2. Then specify the schema as required by Model. This is the table’s name in the database.
    static var schema: String = "tweets"
    
    // 3. Define an optional id property that stores the ID of the model, if one has been set. This is annotated with Fluent’s @ID property wrapper which tells Fluent what to use to look up the model in the database.
    @ID
    var id: UUID?
    
    // 4. Define two String properties to hold the Tweet and its label. These use the @Field property wrapper to denote a generic database field. The key parameter is the name of the column in the database.

    @Field(key: "text")
    var text: String
    
    @Field(key: "label")
    var label: String
    
    // 5. Provide an empty initializer as required by Model. Fluent uses this to initialize models returned from database queries.
    init() {}
    
    // 6. Finally, provide an initializer to create the model as required
    init(id: UUID? = nil, text: String, label: String) {
        self.id = id
        self.text = text
        self.label = label
    }
}

extension Tweet: Content {}

