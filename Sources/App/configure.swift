import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? PostgresConfiguration.ianaPortNumber,
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)


    // 1. Adds CreateTweet to the list of migrations to run
    app.migrations.add(CreateTweet())
      
    // 2. Sets the log level for the app to debug. This provides more information and lets you see your migrations
    app.logger.logLevel = .debug

    // 3. Automatically runs migrations and waits for the result. Fluent lets you choose when to run your migrations. This is helpful when you need to schedule them. You can use wait() here since you’re not running on an EventLoop.
    try app.autoMigrate().wait()
    
    // register routes
    try routes(app)
}
