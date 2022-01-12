//
//  ActivityView.swift
//  News
//
//  Created by Дмитрий Мельников on 10.01.2022.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {

    private let activityItems: [URL]
    private let applicationActivities: [UIActivity]?
    private let completion: UIActivityViewController.CompletionWithItemsHandler?

    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>, items: [URL], activities: [UIActivity]? = nil, onComplete: UIActivityViewController.CompletionWithItemsHandler? = nil) {
        _isPresented = isPresented
        activityItems = items
        applicationActivities = activities
        completion = onComplete
    }

    func makeUIViewController(context: Context) -> ActivityViewControllerWrapper {
        ActivityViewControllerWrapper(isPresented: $isPresented, activityItems: activityItems, applicationActivities: applicationActivities, onComplete: completion)
    }

    func updateUIViewController(_ uiViewController: ActivityViewControllerWrapper, context: Context) {
        uiViewController.isPresented = $isPresented
        uiViewController.activityItems = activityItems
        uiViewController.completion = completion
        uiViewController.updateState()
    }
}
