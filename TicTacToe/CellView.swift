//
//  Cell.swift
//  TicTacToe
//
//  Created by Sergey Telnov on 25/10/2024.
//

import Foundation
import UIKit

class CellView: UIView {
    weak var delegate: CellDelegate?
    
    private let symbolLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        symbolLabel.textAlignment = .center
        symbolLabel.font = UIFont.systemFont(ofSize: 40)
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
        print("Cell tapped!")
        updateSymbol(delegate!.activePlayer)
        delegate!.playerDidClick()
    }

    func updateSymbol(_ symbol: String) {
        symbolLabel.text = symbol
    }
}
