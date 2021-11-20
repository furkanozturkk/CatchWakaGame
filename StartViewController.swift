//
//  StartViewController.swift
//  CatchWakaGame
//
//  Created by Furkan Öztürk on 19.11.2021.
//

import UIKit

class StartViewController: UIViewController {

  
    
    var startImageView: UIImageView = {
            let imageView = UIImageView(frame: .zero)
            imageView.image = UIImage(named: "wakabbg")
            imageView.contentMode = .scaleToFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(startImageView, at: 0)
                NSLayoutConstraint.activate([
                    startImageView.topAnchor.constraint(equalTo: view.topAnchor),
                    startImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    startImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    startImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])

        startImageView.isUserInteractionEnabled = true
        let startgesture = UITapGestureRecognizer(target: self, action: #selector(playGame))
        startImageView.addGestureRecognizer(startgesture)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func playGame(){
        performSegue(withIdentifier: "startGameVC", sender: nil)
        
    }
    

   

}
