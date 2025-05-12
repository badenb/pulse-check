import Fluent
import struct Foundation.UUID

final class Report: Model, @unchecked Sendable {
    static let schema = "reports"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "user_id")
    var userId: UUID
    
    @Field(key: "morale")
    var morale: Int
    
    @Field(key: "stress")
    var stress: Int
    
    @Field(key: "workload")
    var workload: Int
    
    @Field(key: "high")
    var high: String
    
    @Field(key: "low")
    var low: String
    
    @OptionalField(key: "notes")
    var notes: String?

    init() {}
    
    init(
        id: UUID? = nil,
        userId: UUID,
        morale: Int,
        stress: Int,
        workload: Int,
        high: String,
        low: String,
        notes: String? = nil
    ) {
        self.id = id
        self.userId = userId
        self.morale = morale
        self.stress = stress
        self.workload = workload
        self.high = high
        self.low = low
        self.notes = notes
    }
    
    func toDTO() -> ReportDTO {
        .init(
            id: self.id,
            userId: self.userId,
            morale: self.morale,
            stress: self.stress,
            workload: self.workload,
            high: self.high,
            low: self.low,
            notes: self.notes
        )
    }
}
