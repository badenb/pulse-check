import Fluent
import SQLKit

struct CreateReport: AsyncMigration {
    func prepare(on database: any Database) async throws {
        try await database.schema("reports")
            .id()
            .field("user_id", .uuid, .required)
            .field("morale", .int, .required)
            .field("stress", .int, .required)
            .field("workload", .int, .required)
            .field("high", .string, .required)
            .field("low", .string, .required)
            .field("notes", .string)
            .field("created_at", .datetime, .required, .sql(.default(SQLFunction("now"))))
            .field("updated_at", .datetime)
            .create()
    }
    
    func revert(on database: any Database) async throws {
        try await database.schema("reports").delete()
    }
}
