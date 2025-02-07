// 
// Copyright 2022 New Vector Ltd
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import SwiftUI

struct UserSessionsOverview: View {

    // MARK: - Properties
    
    // MARK: Private
    
    @Environment(\.theme) private var theme: ThemeSwiftUI
    
    // MARK: Public
    
    @ObservedObject var viewModel: UserSessionsOverviewViewModel.Context
    
    var body: some View {
        ScrollView {
            
            // Security recommendations section
            if viewModel.viewState.unverifiedSessionsViewData.isEmpty == false || viewModel.viewState.inactiveSessionsViewData.isEmpty == false {
                
                // TODO:
            }
            
            // Current session section
            if let currentSessionViewData = viewModel.viewState.currentSessionViewData {
                // TODO:
            }
            
            // Other sessions section
            if viewModel.viewState.otherSessionsViewData.isEmpty == false {
                self.otherSessionsSection
            }
        }
        .background(theme.colors.system.ignoresSafeArea())
        .frame(maxHeight: .infinity)
        .navigationTitle(VectorL10n.userSessionsOverviewTitle)
        .activityIndicator(show: viewModel.viewState.showLoadingIndicator)
        .onAppear() {
            viewModel.send(viewAction: .viewAppeared)
        }
    }
    
    var otherSessionsSection: some View {
        
        SwiftUI.Section {
            // Device list
            LazyVStack(spacing: 0) {
                ForEach(viewModel.viewState.otherSessionsViewData) { viewData in
                    UserSessionListItem(viewData: viewData, onBackgroundTap: { sessionId in
                        viewModel.send(viewAction: .tapUserSession(sessionId))
                    })
                }
            }
            .background(theme.colors.background)
        } header: {
            VStack(alignment: .leading) {
                Text(VectorL10n.userSessionsOverviewOtherSessionsSectionTitle)
                    .font(theme.fonts.footnote)
                    .foregroundColor(theme.colors.secondaryContent)
                    .padding(.bottom, 10)
                
                Text(VectorL10n.userSessionsOverviewOtherSessionsSectionInfo)
                    .font(theme.fonts.footnote)
                    .foregroundColor(theme.colors.secondaryContent)
                    .padding(.bottom, 11)
            }
            .padding(.horizontal, 16)
        }
    }
}

// MARK: - Previews

struct UserSessionsOverview_Previews: PreviewProvider {
    static let stateRenderer = MockUserSessionsOverviewScreenState.stateRenderer
    static var previews: some View {
        stateRenderer.screenGroup()
    }
}
