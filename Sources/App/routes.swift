import Fluent
import Vapor
import Foundation

func routes(_ app: Application) throws {
    // get tweets
    app.get("api", "tweets") { req in
        Tweet.query(on: req.db).all()
    }

    // 1. Register a new route at /api/tweets that accepts a POST request and returns EventLoopFuture. It returns the acronym once it’s saved.

    app.post("api", "tweets") { req -> EventLoopFuture<Tweet> in
      // 2. Decode the request’s JSON into an Acronym model using Codable
      let tweet = try req.content.decode(Tweet.self)
      // 3. Save the model using Fluent and the database from Request
      return tweet.save(on: req.db).map {
        // 4. Because save(on:) returns EventLoopFuture use map to return the tweet when the save completes
        tweet
      }
    }

    // /app/tweet/id DELETE
    app.delete("api", "tweets", ":tweetID") { req -> EventLoopFuture<HTTPStatus> in
        Tweet.find(req.parameters.get("tweetID", as: UUID.self), on: req.db)
            .unwrap(or: Abort(.notFound))
        .flatMap { $0.delete(on: req.db) }.transform(to: .ok)
    }
    
}
