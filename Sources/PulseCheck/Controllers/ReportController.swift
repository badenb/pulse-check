import Fluent
import Vapor

struct ReportController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let reports = routes.grouped("reports")
        
        reports.get(use: index)
        reports.post(use: create)
        reports.group(":id") { report in
            report.delete(use: delete)
            report.get(use: show)
        }
    }
    
    @Sendable
    func index(req: Request) async throws -> [ReportDTO] {
        try await Report.query(on: req.db).all().map { $0.toDTO() }
    }
    
    @Sendable
    func create(req: Request) async throws -> ReportDTO {
        let report = try req.content.decode(ReportDTO.self).toModel()
        
        try await report.save(on: req.db)
        return report.toDTO()
    }
    
    @Sendable
    func show(req: Request) async throws -> ReportDTO {
        guard let report = try await Report.find(req.parameters.require("id"), on: req.db) else {
            throw Abort(.notFound)
        }
        return report.toDTO()
    }

    
    @Sendable
    func delete(req: Request) async throws -> HTTPStatus {
        guard let report = try await Report.find(req.parameters.get("id"), on: req.db) else {
            throw Abort(.notFound)
        }

        try await report.delete(on: req.db)
        return .noContent
    }
}
