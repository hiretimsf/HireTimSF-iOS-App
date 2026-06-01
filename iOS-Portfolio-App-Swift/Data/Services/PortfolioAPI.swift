import Foundation

struct PortfolioAPI: Sendable {
    private let baseURL: URL
    private let session: URLSession

    init(
        baseURL: URL = URL(string: "https://hiretimsf.com")!,
        session: URLSession = .shared
    ) {
        self.baseURL = baseURL
        self.session = session
    }

    func fetchProjects() async throws -> [Project] {
        let response: ProjectsResponseDTO = try await get(path: "/api/projects")
        return response.data
            .filter(\.showOnPortfolio)
            .sorted { $0.weight > $1.weight }
            .map(\.project)
    }

    func fetchBlogPosts() async throws -> [BlogPost] {
        let response: BlogPostsResponseDTO = try await get(path: "/api/blog-posts")
        return response.data.map(\.blogPost)
    }

    func fetchBlogPost(slug: String) async throws -> BlogPost {
        let encodedSlug = slug.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? slug
        let response: BlogPostDetailResponseDTO = try await get(path: "/api/blog-posts/\(encodedSlug)")
        return response.data.blogPost
    }

    private func get<T: Decodable>(path: String) async throws -> T {
        let url = baseURL.appending(path: path)
        var request = URLRequest(url: url)
        request.timeoutInterval = 20

        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        guard 200..<300 ~= httpResponse.statusCode else {
            throw PortfolioAPIError.badStatusCode(httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

enum PortfolioAPIError: LocalizedError {
    case badStatusCode(Int)

    var errorDescription: String? {
        switch self {
        case .badStatusCode(let statusCode):
            "Unexpected server response: \(statusCode)"
        }
    }
}

private struct ProjectsResponseDTO: Decodable {
    let data: [ProjectDTO]
}

private struct ProjectDTO: Decodable {
    let id: Int
    let title: String
    let description: String
    let imageUrl: String
    let imageAlt: String
    let fromDate: String
    let toDate: String
    let category: String
    let websiteUrl: String?
    let githubUrl: String?
    let videoEmbedUrl: String?
    let techStacks: [String]
    let featured: Bool
    let showOnPortfolio: Bool
    let comingSoon: Bool
    let weight: Int
    let slug: String
    let portfolioUrl: String?

    var project: Project {
        let projectId = slug.isEmpty ? "project-\(id)" : slug
        let links = [
            websiteUrl.flatMap { URL(string: $0) }.map { ProjectLink(title: "Live Demo", url: $0, systemImage: "safari") },
            githubUrl.flatMap { URL(string: $0) }.map { ProjectLink(title: "GitHub", url: $0, systemImage: "chevron.left.forwardslash.chevron.right") },
            portfolioUrl.flatMap { URL(string: $0) }.map { ProjectLink(title: "Portfolio", url: $0, systemImage: "rectangle.stack") }
        ].compactMap { $0 }

        return Project(
            id: projectId,
            title: title,
            subtitle: title,
            header: category,
            coverImage: URL(string: imageUrl) ?? PortfolioData.fallbackImageURL,
            logo: nil,
            imageDescription: imageAlt,
            info: techStacks.joined(separator: ", "),
            text: description,
            start: Self.displayDate(fromDate),
            end: Self.displayDate(toDate),
            links: links
        )
    }

    private static func displayDate(_ value: String) -> String {
        let inputFormats = ["yyyy-MM-dd", "MM/dd/yyyy"]
        for format in inputFormats {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = format
            if let date = formatter.date(from: value) {
                let output = DateFormatter()
                output.locale = Locale(identifier: "en_US_POSIX")
                output.dateFormat = "MMM yyyy"
                return output.string(from: date)
            }
        }
        return value
    }
}

private struct BlogPostsResponseDTO: Decodable {
    let data: [BlogPostDTO]
}

private struct BlogPostDetailResponseDTO: Decodable {
    let data: BlogPostDTO
}

private struct BlogPostDTO: Decodable {
    let title: String
    let description: String
    let created: String
    let lastUpdated: String
    let imageUrl: String
    let thumbnailUrl: String?
    let imageAlt: String
    let author: String
    let authorAvatarUrl: String
    let authorAvatarAlt: String
    let category: String
    let tags: [String]
    let seo: [String]
    let readingTime: String
    let readingTimeMinutes: Int
    let slug: String
    let url: String
    let excerpt: String?
    let score: Int?
    let content: String?
    let sections: [BlogPostSectionDTO]?

    var blogPost: BlogPost {
        BlogPost(
            slug: slug,
            title: title,
            date: created,
            category: category,
            readTime: readingTime,
            excerpt: excerpt ?? description,
            coverImageUrl: URL(string: thumbnailUrl ?? imageUrl) ?? PortfolioData.fallbackImageURL,
            imageAlt: imageAlt,
            url: URL(string: url),
            sections: (sections ?? []).map { BlogPostSection(title: $0.title, content: $0.content) },
            content: content ?? "",
            author: author,
            authorAvatarUrl: URL(string: authorAvatarUrl),
            tags: tags
        )
    }
}

private struct BlogPostSectionDTO: Decodable {
    let title: String
    let content: String
}
