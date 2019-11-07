//
//  ItemDetailController.swift
//  Ways
//
//  Created by Felipe Luna Tersi on 16/09/19.
//  Copyright © 2019 IBM. All rights reserved.
//

import UIKit
import Firebase

class ItemDetailController: UITableViewController {
    
    var item: Item!

    var likePressed: Bool = false
    var isPerfilHidden = false
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var products: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var contenteStack: UIStackView!
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photo2: UIImageView!
    @IBOutlet weak var titleItem: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var exchange: UILabel!
    @IBOutlet weak var descriptionItem: UITextView!
   
    @IBOutlet weak var favorite: UIBarButtonItem!
    
    @IBAction func actionSheet(_ sender: Any) {
        // 1
        let optionMenu = UIAlertController(title: nil, message: "Mande uma mensagem", preferredStyle: .actionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Whatsapp", style: .default)
        
        // 3
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        // 4
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.present(optionMenu, animated: true, completion: nil)
    }
    
    @IBAction func favoriteButtom(_ sender: UIBarButtonItem) {
        
        if likePressed == false {
            likePressed = true
            self.item.isFavorite = true
            if ArrayControl.shared.itensList.contains(self.item){
                if let index = ArrayControl.shared.itensList.firstIndex(of: self.item){
                    ArrayControl.shared.itensList[index].isFavorite = true
                }
            }
            
            if ArrayControl.shared.sellerItemArray.contains(self.item){
                if let index = ArrayControl.shared.sellerItemArray.firstIndex(of: self.item){
                    ArrayControl.shared.sellerItemArray[index].isFavorite = true
                }
            }
            favorite.image = UIImage (named: "favorito")
            ArrayControl.shared.favoriteArray.append(self.item)
        } else {
            likePressed = false
            self.item.isFavorite = false
            favorite.image = UIImage (named: "heart")
            
            if ArrayControl.shared.itensList.contains(self.item){
                if let index = ArrayControl.shared.itensList.firstIndex(of: self.item){
                    ArrayControl.shared.itensList[index].isFavorite = false
                }
            }
            
            if ArrayControl.shared.sellerItemArray.contains(self.item){
                if let index = ArrayControl.shared.sellerItemArray.firstIndex(of: self.item){
                    ArrayControl.shared.sellerItemArray[index].isFavorite = false
                }
            }
            
            while ArrayControl.shared.favoriteArray.contains(self.item) {
                if let index = ArrayControl.shared.favoriteArray.firstIndex(of: self.item){
                    ArrayControl.shared.favoriteArray.remove(at: index)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 200
        case 1:
            return 160
        case 2:
            return 144
        case 3:
            return 53
        case 4:
            if isPerfilHidden == true  {
                return 0
            } else {
                return 105
            }
        default:
            return 0
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        titleItem.text = self.item.title
        price.text = "R$ \(self.item.price)"
        condition.text = self.item.condition
        photo.image = self.item.photo
        photo2.image = self.item.photo2
        exchange.text = self.item.exchange
        descriptionItem.text = self.item.description
        
        fetchSeller()
        
        if let index = ArrayControl.shared.itensList.firstIndex(of: self.item) {
            if ArrayControl.shared.itensList[index].isFavorite == true {
                likePressed = true
                favorite.image = UIImage (named: "favorito")
            } else {
                likePressed = false
                favorite.image = UIImage (named: "heart")
            }
        }
        self.view.setNeedsLayout()
        
    }
    
    func fetchSeller(){
        Database.database().reference().child("User-Info").child(self.item.seller).observe(.value, with: { (snapshot) in
            
            let userDict = snapshot.value as! [String: Any]
            
            self.name.text = userDict["name"] as? String
            self.type.text = userDict["profileType"] as? String
            
        }, withCancel: nil)
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
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
    }
    
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
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.imgTapped(_:)))
        photo.addGestureRecognizer(tap)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.imgTapped(_:)))
        photo2.addGestureRecognizer(tap2)

        // numero de paginas que vao aparecer com o page control
        pageView.currentPage = 0
        pageView.numberOfPages = 2
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSeller" {
            if let detail = segue.destination as? SellerPerfilController {
                detail.sellerID = self.item.seller
                detail.sellerName = self.name.text
                detail.sellerType = self.type.text
            }
        }
    }
    
}


