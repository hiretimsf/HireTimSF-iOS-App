import SwiftUI

struct PortfolioView: View {
    let viewModel: PortfolioViewModel
    @State private var selectedProjectID: String?

    var body: some View {
        GeometryReader { proxy in
            let contentWidth = max(proxy.size.width - 36, 0)

            List {
                ForEach(viewModel.projects) { project in
                    Button {
                        selectedProjectID = project.id
                    } label: {
                        ProjectCardView(project: project, contentWidth: contentWidth)
                    }
                    .buttonStyle(.plain)
                    .listRowInsets(EdgeInsets(top: 12, leading: 18, bottom: 12, trailing: 18))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.appBackground)
            .navigationDestination(item: $selectedProjectID) { projectID in
                if let project = viewModel.projects.first(where: { $0.id == projectID }) {
                    ProjectDetailView(project: project)
                }
            }
            .refreshable {
                await viewModel.loadProjects()
            }
        }
    }
}
