//
//  MyPerfilItemController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit

class PerfilItemController: UITableViewController {
    
    var item: Item!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contenteStack: UIStackView!
    @IBOutlet weak var pageView: UIPageControl!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photo2: UIImageView!
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var exchange: UILabel!
    @IBOutlet weak var descriptionItem: UITextView!
    
    @objc func imgTapped(_ sender: UITapGestureRecognizer? = nil) {
        let imageView = sender?.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        let statusView = UIView(frame: CGRect(x: 0, y: 0, width:     self.view.bounds.width, height: 20))
        statusView.backgroundColor = UIColor.white.withAlphaComponent(0.45)
        self.view.addSubview(statusView)
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(item.title)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imgTapped(_:)))
        photo.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.imgTapped(_:)))
        photo2.addGestureRecognizer(tap2)

        if let oItem = self.item {
            photo.image = oItem.photo
            photo2.image = oItem.photo2
            titleItem.text = oItem.title
            price.text = oItem.price
            condition.text = oItem.condition
            exchange.text = oItem.exchange
            descriptionItem.text = oItem.description
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        // calcula o tamanho do conteúdo da scrollview
        scrollView.contentSize = self.contenteStack.bounds.size
        scrollView.contentInset = UIEdgeInsets.zero
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // calcula o numero da página baseado no quanto o scrollview está deslocado em X
        let page = floor(scrollView.contentOffset.x / self.view.frame.width)
        
        // Para atualizar o current page é necessário converter o float para Int
        pageView.currentPage = Int(page)
    }
    
}
