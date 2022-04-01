//
//  ActivityView.swift
//  News
//
//  Created by Дмитрий Мельников on 10.01.2022.
//

import SwiftUI

struct ActivityView: UIViewControllerRepresentable {
    @Binding var isPresented: Bool

    let activityItems: [URL]
    let applicationActivities: [UIActivity]?
    let completion: UIActivityViewController.CompletionWithItemsHandler?

    func makeUIViewController(context: Context) -> ActivityViewControllerWrapper {
        ActivityViewControllerWrapper(
            isPresented: $isPresented,
            activityItems: activityItems,
            applicationActivities: applicationActivities,
            onComplete: completion
        )
    }

    func updateUIViewController(_ uiViewController: ActivityViewControllerWrapper, context: Context) {
        uiViewController.isPresented = $isPresented
        uiViewController.activityItems = activityItems
        uiViewController.completion = completion
        uiViewController.updateState()
    }
}
