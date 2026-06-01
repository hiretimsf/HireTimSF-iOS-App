import SwiftUI

struct PortfolioView: View {
    @Environment(PortfolioViewModel.self) private var portfolio

    var body: some View {
        List {
            Section {
                PortfolioHeaderView(isLoading: portfolio.isLoadingProjects, errorMessage: portfolio.projectError)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }

            ForEach(portfolio.projects) { project in
                NavigationLink {
                    ProjectDetailView(project: project)
                } label: {
                    ProjectCardView(project: project)
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.appBackground)
        .refreshable {
            await portfolio.loadProjects()
        }
    }
}
