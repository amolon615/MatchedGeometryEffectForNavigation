//
//  ContentView.swift
//  MatchedGeometryEffectForNavigation
//
//  Created by amolonus on 04/03/2025.
//

import SwiftUI

struct MatchedGeometryEffectForNavigationView: View {
    @State private var selectedView: String? = nil
    @State private var showDetailView = false
    @Namespace private var animation
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Background
            Color.gray.opacity(0.2)
                .ignoresSafeArea()
            
            // Main Card
            if !showDetailView {
                MainCardView(
                    selectedView: $selectedView,
                    showDetailView: $showDetailView,
                    animation: animation
                )
                .frame(height: 450)
                .transition(.opacity)
            }
            
            // Detail View
            if showDetailView {
                DetailView(
                    selectedView: $selectedView,
                    showDetailView: $showDetailView,
                    animation: animation
                )
                .frame(height: 450)
                .transition(.opacity)
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.86), value: showDetailView)
        .animation(.spring(response: 0.35, dampingFraction: 0.86), value: selectedView)
    }
}

// MARK: - Main Card View
struct MainCardView: View {
    @Binding var selectedView: String?
    @Binding var showDetailView: Bool
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            CardHeader()
            
            Divider()
                .padding(.bottom, 15)
            
            OptionButtonsStack(
                selectedView: $selectedView,
                showDetailView: $showDetailView,
                animation: animation
            )
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(28)
        .padding(.horizontal, 16)
        .padding(.vertical, 40)
    }
}

// MARK: - Card Header
struct CardHeader: View {
    var body: some View {
        HStack {
            Text("iCloud Backup")
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 15)
    }
}

// MARK: - Option Buttons Stack
struct OptionButtonsStack: View {
    @Binding var selectedView: String?
    @Binding var showDetailView: Bool
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 12) {
            OptionButton(
                title: "View Private Key",
                iconName: "doc.text",
                viewId: "privateKey",
                selectedView: $selectedView,
                showDetailView: $showDetailView,
                animation: animation
            )
            
            OptionButton(
                title: "View Recovery Phrase",
                iconName: "rectangle.grid.3x2",
                viewId: "recoveryPhrase",
                selectedView: $selectedView,
                showDetailView: $showDetailView,
                animation: animation
            )
            
            OptionButton(
                title: "View Backup Group",
                iconName: "square.grid.2x2",
                viewId: "backupGroup",
                selectedView: $selectedView,
                showDetailView: $showDetailView,
                animation: animation
            )
            
            RemoveWalletButton()
        }
        .padding(.horizontal, 20)
    }
}

// MARK: - Option Button
struct OptionButton: View {
    let title: String
    let iconName: String
    let viewId: String
    @Binding var selectedView: String?
    @Binding var showDetailView: Bool
    var animation: Namespace.ID
    
    var body: some View {
        Button(action: {
            selectedView = viewId
            showDetailView = true
        }) {
            HStack {
                Image(systemName: iconName)
                    .font(.system(size: 20))
                    .frame(width: 24, height: 24)
                    .matchedGeometryEffect(id: "\(viewId)Icon", in: animation)
                
                // Container to ensure consistent size during animation
                ZStack(alignment: .leading) {
                    // Invisible text for proper sizing
                    Text(title)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .opacity(0)
                    
                    // Actual visible text
                    Text(title)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .matchedGeometryEffect(id: "\(viewId)Text", in: animation)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.systemGray6))
                    .matchedGeometryEffect(id: "\(viewId)Background", in: animation)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Remove Wallet Button
struct RemoveWalletButton: View {
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: "exclamationmark.triangle")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
                    .frame(width: 24, height: 24)
                
                Text("Remove Wallet")
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                    .foregroundColor(.red)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.red.opacity(0.1))
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Detail View
struct DetailView: View {
    @Binding var selectedView: String?
    @Binding var showDetailView: Bool
    var animation: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            DetailHeader(
                selectedView: $selectedView,
                showDetailView: $showDetailView,
                animation: animation
            )
            
            DetailTitle(
                selectedView: selectedView,
                animation: animation
            )
            
            if selectedView == "privateKey" {
                PrivateKeyContent()
            } else {
                OtherDetailContent(selectedView: selectedView)
            }
            
            
            ActionButtons(
                selectedView: $selectedView,
                showDetailView: $showDetailView
            )
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(
            DetailBackground(selectedView: selectedView, animation: animation)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 40)
    }
}

// MARK: - Detail Header
struct DetailHeader: View {
    @Binding var selectedView: String?
    @Binding var showDetailView: Bool
    var animation: Namespace.ID
    
    var body: some View {
        HStack {
            if let selectedView = selectedView {
                let iconName = iconNameForView(selectedView)
                Image(systemName: iconName)
                    .font(.system(size: 20))
                    .matchedGeometryEffect(id: "\(selectedView)Icon", in: animation)
            }
            
            Spacer()
            
            Button(action: {
                showDetailView = false
                selectedView = nil
            }) {
                Image(systemName: "xmark")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 10)
    }
    
    private func iconNameForView(_ view: String) -> String {
        switch view {
        case "privateKey": return "doc.text"
        case "recoveryPhrase": return "rectangle.grid.3x2"
        case "backupGroup": return "square.grid.2x2"
        default: return "doc"
        }
    }
}

// MARK: - Detail Title
struct DetailTitle: View {
    let selectedView: String?
    var animation: Namespace.ID
    
    var body: some View {
        HStack {
            if let selectedView = selectedView {
                let title = titleForView(selectedView)
                
                ZStack(alignment: .leading) {
                    // Invisible text for sizing
                    Text(title)
                        .font(.system(size: 28, weight: .bold))
                        .opacity(0)
                    
                    // Actual text with matched geometry
                    Text(title)
                        .font(.system(size: 28, weight: .bold))
                        .fixedSize()
                        .matchedGeometryEffect(id: "\(selectedView)Text", in: animation)
                }
                .frame(height: 36) // Fixed height to prevent layout shifts
            }
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    private func titleForView(_ view: String) -> String {
        switch view {
        case "privateKey": return "Private Key"
        case "recoveryPhrase": return "Recovery Phrase"
        case "backupGroup": return "Backup Group"
        default: return "Detail"
        }
    }
}

// MARK: - Private Key Content
struct PrivateKeyContent: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Your Private Key is the key used to back up your wallet. Keep it secret and secure at all times.")
                .font(.system(size: 17))
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            
            SecurityNotes()
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
        }
    }
}

// MARK: - Security Notes
struct SecurityNotes: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SecurityNote(icon: "checkmark.circle", text: "Keep your private key safe")
            SecurityNote(icon: "person.2.slash", text: "Don't share it with anyone else")
            SecurityNote(icon: "exclamationmark.triangle", text: "If you lose it we can't recover it")
        }
    }
}

// MARK: - Security Note
struct SecurityNote: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
            Text(text)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Other Detail Content
struct OtherDetailContent: View {
    let selectedView: String?
    
    var body: some View {
        Text("Content for \(selectedView ?? "") would go here")
            .foregroundColor(.gray)
            .padding()
        
        Spacer()
    }
}

// MARK: - Action Buttons
struct ActionButtons: View {
    @Binding var selectedView: String?
    @Binding var showDetailView: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            Button(action: {
                showDetailView = false
                selectedView = nil
            }) {
                Text("Cancel")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.gray.opacity(0.15))
                    .cornerRadius(30)
            }
            
            Button(action: {
                // Reveal action
            }) {
                HStack {
                    Image(systemName: "qrcode.viewfinder")
                        .font(.system(size: 17))
                    Text("Reveal")
                        .font(.system(size: 17, weight: .medium))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(Color.blue)
                .cornerRadius(30)
            }
        }
    }
}

// MARK: - Detail Background
struct DetailBackground: View {
    let selectedView: String?
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            if let selectedView = selectedView {
                RoundedRectangle(cornerRadius: 28)
                    .fill(Color.white)
                    .matchedGeometryEffect(id: "\(selectedView)Background", in: animation)
            }
        }
    }
}

#Preview {
    MatchedGeometryEffectForNavigationView()
}
