import SwiftUI

struct PortfolioView: View {
    let viewModel: PortfolioViewModel

    var body: some View {
        GeometryReader { proxy in
            let contentWidth = max(proxy.size.width - 36, 0)

            List {
                ForEach(viewModel.projects) { project in
                    NavigationLink {
                        ProjectDetailView(project: project)
                    } label: {
                        ProjectCardView(project: project, contentWidth: contentWidth)
                    }
                    .buttonStyle(.plain)
                    .listRowInsets(EdgeInsets(top: 8, leading: 18, bottom: 8, trailing: 18))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .refreshable {
                await viewModel.loadProjects()
            }
        }
    }
}
