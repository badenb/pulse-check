import Fluent
import Vapor

struct ReportDTO: Content {
    let id: UUID?
    let userId: UUID
    let morale: Int
    let stress: Int
    let workload: Int
    let high: String
    let low: String
    let notes: String?
    
    func toModel() -> Report {
        let model = Report()
        
        model.id = self.id
        model.userId  = self.userId
        model.morale = self.morale
        model.stress = self.stress
        model.workload = self.workload
        model.high = self.high
        model.low = self.low
        
        if let notes = self.notes {
            model.notes = notes
        }
        
        return model
    }
}

