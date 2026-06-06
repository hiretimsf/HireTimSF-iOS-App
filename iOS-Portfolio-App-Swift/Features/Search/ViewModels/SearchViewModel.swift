import Foundation
import Observation

@MainActor
@Observable
final class SearchViewModel {
    var query = ""

    func results(
        projects: [Project],
        blogPosts: [BlogPost],
        aboutSections: [AboutSection] = PortfolioData.aboutSections
    ) -> [SearchResult] {
        let allResults = projects.map {
            SearchResult(id: "project-\($0.id)", title: $0.title, subtitle: $0.text)
        } + blogPosts.map {
            SearchResult(id: "blog-\($0.id)", title: $0.title, subtitle: $0.excerpt)
        } + aboutSections.map {
            SearchResult(id: "about-\($0.id)", title: $0.title, subtitle: $0.content)
        }

        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else { return [] }

        return allResults.filter { result in
            result.title.localizedCaseInsensitiveContains(trimmedQuery)
                || result.subtitle.localizedCaseInsensitiveContains(trimmedQuery)
        }
    }
}
