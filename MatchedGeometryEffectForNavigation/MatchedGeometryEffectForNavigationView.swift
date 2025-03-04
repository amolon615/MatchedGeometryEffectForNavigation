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
                mainCardView()
                    .frame(height: 450)
                    .transition(.opacity)
            }
            
            // Detail View
            if showDetailView {
                detailView()
                    .frame(height: 450)
                    .transition(.opacity)
            }
        }
        .animation(.spring(response: 0.35, dampingFraction: 0.86), value: showDetailView)
        .animation(.spring(response: 0.35, dampingFraction: 0.86), value: selectedView)
    }
    
    @ViewBuilder
    func mainCardView() -> some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("iCloud Backup")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    // Dismiss action
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 15)
            
            Divider()
                .padding(.bottom, 15)
            
            // Buttons
            VStack(spacing: 12) {
                // Private Key Button
                Button(action: {
                    selectedView = "privateKey"
                    showDetailView = true
                }) {
                    HStack {
                        Image(systemName: "doc.text")
                            .font(.system(size: 20))
                            .frame(width: 24, height: 24)
                            .matchedGeometryEffect(id: "privateKeyIcon", in: animation)
                        
                        // Container to ensure consistent size during animation
                        ZStack(alignment: .leading) {
                            // Invisible text for proper sizing
                            Text("View Private Key")
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                                .opacity(0)
                            
                            // Actual visible text
                            Text("View Private Key")
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                                .matchedGeometryEffect(id: "privateKeyText", in: animation)
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
                            .matchedGeometryEffect(id: "privateKeyBackground", in: animation)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                // Recovery Phrase Button
                Button(action: {
                    selectedView = "recoveryPhrase"
                    showDetailView = true
                }) {
                    HStack(alignment: .center) {
                        Image(systemName: "rectangle.grid.3x2")
                            .font(.system(size: 20))
                            .frame(width: 24, height: 24)
                            .matchedGeometryEffect(id: "recoveryPhraseIcon", in: animation)
                        
                        // Container to ensure consistent size during animation
                        ZStack(alignment: .leading) {
                            // Invisible text for proper sizing
                            Text("View Recovery Phrase")
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                                .opacity(0)
                            
                            // Actual visible text
                            Text("View Recovery Phrase")
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                                .matchedGeometryEffect(id: "recoveryPhraseText", in: animation)
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
                            .matchedGeometryEffect(id: "recoveryPhraseBackground", in: animation)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                // Backup Group Button
                Button(action: {
                    selectedView = "backupGroup"
                    showDetailView = true
                }) {
                    HStack(alignment: .center) {
                        Image(systemName: "square.grid.2x2")
                            .font(.system(size: 20))
                            .frame(width: 24, height: 24)
                            .matchedGeometryEffect(id: "backupGroupIcon", in: animation)
                        
                        // Container to ensure consistent size during animation
                        ZStack(alignment: .leading) {
                            Text("View Backup Group")
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                                .opacity(0)
                            
                            // Actual visible text
                            Text("View Backup Group")
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                                .matchedGeometryEffect(id: "backupGroupText", in: animation)
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
                            .matchedGeometryEffect(id: "backupGroupBackground", in: animation)
                    )
                }
                .buttonStyle(PlainButtonStyle())
                
                // Remove Wallet Button (Action button, no chevron)
                Button(action: {
                    // Remove wallet action
                }) {
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
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(Color.white)
        .cornerRadius(28)
        .padding(.horizontal, 16)
        .padding(.vertical, 40)
    }
    
    @ViewBuilder
    func detailView() -> some View {
        VStack(spacing: 0) {
            // Header with icon
            HStack {
                if selectedView == "privateKey" {
                    Image(systemName: "doc.text")
                        .font(.system(size: 20))
                        .matchedGeometryEffect(id: "privateKeyIcon", in: animation)
                } else if selectedView == "recoveryPhrase" {
                    Image(systemName: "rectangle.grid.3x2")
                        .font(.system(size: 20))
                        .matchedGeometryEffect(id: "recoveryPhraseIcon", in: animation)
                } else if selectedView == "backupGroup" {
                    Image(systemName: "square.grid.2x2")
                        .font(.system(size: 20))
                        .matchedGeometryEffect(id: "backupGroupIcon", in: animation)
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
            
            // Title with proper animation container
            HStack {
                if selectedView == "privateKey" {
                    // Container to ensure text doesn't get cropped
                    ZStack(alignment: .leading) {
                        // Invisible text for sizing
                        Text("Private Key")
                            .font(.system(size: 28, weight: .bold))
                            .opacity(0)
                        
                        // Actual text with matched geometry
                        Text("Private Key")
                            .font(.system(size: 28, weight: .bold))
                            .fixedSize()
                            .matchedGeometryEffect(id: "privateKeyText", in: animation)
                    }
                    .frame(height: 36) // Fixed height to prevent layout shifts
                } else if selectedView == "recoveryPhrase" {
                    ZStack(alignment: .leading) {
                        Text("Recovery Phrase")
                            .font(.system(size: 28, weight: .bold))
                            .opacity(0)
                        
                        Text("Recovery Phrase")
                            .font(.system(size: 28, weight: .bold))
                            .fixedSize()
                            .matchedGeometryEffect(id: "recoveryPhraseText", in: animation)
                    }
                    .frame(height: 36)
                } else if selectedView == "backupGroup" {
                    ZStack(alignment: .leading) {
                        Text("Backup Group")
                            .font(.system(size: 28, weight: .bold))
                            .opacity(0)
                        
                        Text("Backup Group")
                            .font(.system(size: 28, weight: .bold))
                            .fixedSize()
                            .matchedGeometryEffect(id: "backupGroupText", in: animation)
                    }
                    .frame(height: 36)
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
            
            // Description
            if selectedView == "privateKey" {
                Text("Your Private Key is the key used to back up your wallet. Keep it secret and secure at all times.")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                
                // Security notes
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 12) {
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.gray)
                        Text("Keep your private key safe")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(spacing: 12) {
                        Image(systemName: "person.2.slash")
                            .foregroundColor(.gray)
                        Text("Don't share it with anyone else")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.gray)
                        Text("If you lose it we can't recover it")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                
                // Buttons
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
                .padding(.horizontal, 20)
            } else {
                // Placeholder content for other views
                Text("Content for \(selectedView ?? "") would go here")
                    .foregroundColor(.gray)
                    .padding()
                
                Spacer()
                
                // Buttons
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
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            
            Spacer()
        }
        .background(
            ZStack {
                if selectedView == "privateKey" {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.white)
                        .matchedGeometryEffect(id: "privateKeyBackground", in: animation)
                } else if selectedView == "recoveryPhrase" {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.white)
                        .matchedGeometryEffect(id: "recoveryPhraseBackground", in: animation)
                } else if selectedView == "backupGroup" {
                    RoundedRectangle(cornerRadius: 28)
                        .fill(Color.white)
                        .matchedGeometryEffect(id: "backupGroupBackground", in: animation)
                }
            }
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 40)
    }
}


#Preview {
    MatchedGeometryEffectForNavigationView()
}
