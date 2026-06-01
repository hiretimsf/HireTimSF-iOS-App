import Foundation

struct Profile: Sendable {
    let greeting: String
    let name: String
    let title: String
    let email: String
    let socials: [SocialLink]
}

struct SocialLink: Identifiable, Sendable {
    let id: String
    let name: String
    let url: URL
    let systemImage: String
}

struct AboutSection: Identifiable, Sendable {
    let id = UUID()
    let title: String
    let content: String
}

struct AboutPhoto: Identifiable, Sendable {
    let id = UUID()
    let url: URL
    let alt: String
}

struct Project: Identifiable, Sendable {
    let id: String
    let title: String
    let subtitle: String
    let header: String
    let coverImage: URL
    let logo: URL?
    let imageDescription: String
    let info: String
    let text: String
    let start: String
    let end: String
    let links: [ProjectLink]

    var techStacks: [String] {
        info.split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }
    }
}

struct ProjectLink: Identifiable, Sendable {
    let id = UUID()
    let title: String
    let url: URL
    let systemImage: String
}

struct BlogPost: Identifiable, Sendable {
    var id: String { slug }
    let slug: String
    let title: String
    let date: String
    let category: String
    let readTime: String
    let excerpt: String
    let coverImageUrl: URL
    let imageAlt: String
    let url: URL?
    let sections: [BlogPostSection]
    let content: String
    let author: String
    let authorAvatarUrl: URL?
    let tags: [String]
}

struct BlogPostSection: Identifiable, Sendable {
    let id = UUID()
    let title: String
    let content: String
}

struct AppInfoItem: Identifiable, Sendable {
    let id = UUID()
    let title: String
    let text: String
}

struct WelcomePage: Identifiable, Sendable {
    let id = UUID()
    let title: String
    let subtitle: String
    let text: String
    let imageName: String
}
