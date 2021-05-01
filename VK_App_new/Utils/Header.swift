//
//  Header.swift
//  VK_App_new
//
//  Created by Алексей Якуба on 06.04.2021.
//

import Foundation
import UIKit


class FriendHeader: UITableViewHeaderFooterView {
            
        static let reuseIdentifier = "FriendHeader"
            
        let headerTitle = UILabel()
            
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            //
            setupSubviews()
            setupConstraints()
        }
            
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            //
            setupSubviews()
            setupConstraints()
        }
        
        private func setupSubviews() {
            self.addSubview(headerTitle)
            //
            headerTitle.textColor = .darkGray
            headerTitle.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            headerTitle.textAlignment = .left
            //
            backgroundView = UIView()
            backgroundView?.backgroundColor = .systemGray4
            backgroundView?.tintColor = .none
        }
            
        private func setupConstraints() {
            
            headerTitle.translatesAutoresizingMaskIntoConstraints = false
            
            let xOffset: CGFloat = 20
            let yOffset: CGFloat = 10
            
            headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: xOffset).isActive = true
            headerTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -xOffset).isActive = true
            headerTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: -yOffset).isActive = true
            headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: yOffset).isActive = true
        }

    }

class GroupHeader: UITableViewHeaderFooterView {
        
    static let reuseIdentifier = "GroupHeader"
        
    let headerTitle = UILabel()
        
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        //
        setupSubviews()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        self.addSubview(headerTitle)
        //
        headerTitle.textColor = .darkGray
        headerTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerTitle.textAlignment = .left
        //
        backgroundView = UIView()
        backgroundView?.backgroundColor = .systemGray4
        backgroundView?.tintColor = .none
    }
        
    private func setupConstraints() {
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let xOffset: CGFloat = 20
        let yOffset: CGFloat = 10
        
        headerTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: xOffset).isActive = true
        headerTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -xOffset).isActive = true
        headerTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: -yOffset).isActive = true
        headerTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: yOffset).isActive = true
    }

}

