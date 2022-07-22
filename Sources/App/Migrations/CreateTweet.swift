//
//  File.swift
//  
//
//  Created by Georgi Markov on 7/20/22.
//

import Fluent

// 1. Defines a new type, CreateTweet, that conforms to Migration
struct CreateTweet: Migration {
    // 2. Then implements prepare(on:) as required by Migration. You call this method when you run your migrations
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        // 3. Defines the table name for this model. This must match schema from the model.
        database.schema("tweets")
        // 4. Next, defines the ID column in the database
            .id()
        // 5. Defines columns for text and label. Sets the column type to string and marks the columns as required. This matches the non-optional String properties in the model. The field names must match the key of the property wrapper, not the name of the property itself.

            .field("text", .string, .required)
            .field("label", .string, .required)
        // 6. Then creates the table in the database
            .create()
    }
    
    // 7. Implements revert(on:) as required by Migration. You call this function when you revert your migrations. This deletes the table referenced with schema(_:).
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("tweets").delete()
    }
}


