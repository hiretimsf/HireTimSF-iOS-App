import Foundation

func mailURL(subject: String? = nil, body: String? = nil) -> URL {
    var components = URLComponents()
    components.scheme = "mailto"
    components.path = PortfolioData.profile.email

    var queryItems: [URLQueryItem] = []
    if let subject { queryItems.append(URLQueryItem(name: "subject", value: subject)) }
    if let body { queryItems.append(URLQueryItem(name: "body", value: body)) }

    components.queryItems = queryItems.isEmpty ? nil : queryItems
    guard let url = components.url else {
        preconditionFailure("Invalid support email address: \(PortfolioData.profile.email)")
    }
    return url
}

func deletionEmailBody(id: String) -> String {
    """
    Hello Tim,

    Please delete app-related data for the HireTimSF Portfolio iOS app that can be associated with this deletion identifier:

    \(id)

    Approximate date range of app use:

    Additional details:
    """
}
