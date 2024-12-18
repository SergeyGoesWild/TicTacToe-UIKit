//
//  Cell.swift
//  TicTacToe
//
//  Created by Sergey Telnov on 25/10/2024.
//

import Foundation
import UIKit

class CellView: UIView {
    let id: Int
    var blocked: Bool = false
    weak var delegate: CellDelegate?
    private let symbolLabel = UILabel()
    
    var gameOverObserver: NSObjectProtocol?
    var resetObserver: NSObjectProtocol?
    
    init(frame: CGRect, id: Int) {
        self.id = id
        super.init(frame: frame)
        setupView()
        gameOverObserver = NotificationCenter.default
            .addObserver(
                forName: MainViewController.didWinNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.blocked = true
            }
        resetObserver = NotificationCenter.default
            .addObserver(
                forName: MainViewController.didRestartNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.updateSymbol(" ")
                self.blocked = false
            }
    }
    
    override init(frame: CGRect) {
        self.id = 0
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.id = 0
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        symbolLabel.textAlignment = .center
        symbolLabel.font = UIFont.systemFont(ofSize: 25)
        symbolLabel.translatesAutoresizingMaskIntoConstraints = false
        symbolLabel.text = " "
        addSubview(symbolLabel)

        NSLayoutConstraint.activate([
            symbolLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            symbolLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])

        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        if !blocked {
            updateSymbol(delegate!.activePlayer)
            blocked = true
            delegate!.playerDidClick(id: id)
        }
    }

    func updateSymbol(_ symbol: String) {
        symbolLabel.text = symbol
    }
}
