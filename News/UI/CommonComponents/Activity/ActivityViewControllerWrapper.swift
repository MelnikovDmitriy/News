//
//  ActivityViewControllerWrapper.swift
//  News
//
//  Created by Дмитрий Мельников on 10.01.2022.
//

import SwiftUI

final class ActivityViewControllerWrapper: UIViewController {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]?
    var isPresented: Binding<Bool>
    var completion: UIActivityViewController.CompletionWithItemsHandler?

    init(isPresented: Binding<Bool>, activityItems: [Any], applicationActivities: [UIActivity]? = nil, onComplete: UIActivityViewController.CompletionWithItemsHandler? = nil) {
        self.activityItems = activityItems
        self.applicationActivities = applicationActivities
        self.isPresented = isPresented
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        nil
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        updateState()
    }

    func updateState() {
        let isActivityPresented = presentedViewController != nil

        if isActivityPresented != isPresented.wrappedValue {
            if !isActivityPresented {
                let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
                controller.popoverPresentationController?.sourceView = view
                controller.completionWithItemsHandler = { [weak self] (activityType, success, items, error) in
                    self?.isPresented.wrappedValue = false
                    self?.completion?(activityType, success, items, error)
                }
                present(controller, animated: true, completion: nil)
            }
        }
    }

}
