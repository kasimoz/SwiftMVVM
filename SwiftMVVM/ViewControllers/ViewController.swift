//
//  ViewController.swift
//  SwiftMVVM
//
//  Created by KasimOzdemir on 27.05.2021.
//

import UIKit
import Combine
import SDWebImage
import AlamofireNetworkActivityLogger

class ViewController: BaseViewController , UIContextMenuInteractionDelegate
{
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var url: UILabel!
    lazy var photoViewModel: PhotoViewModel = {
                let viewModel = PhotoViewModel()
                return viewModel
            }()

    private var cancellables: Set<AnyCancellable> = []
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        initViewModel(viewModel: photoViewModel)
        
        photoViewModel.$photo.sink{ photo in
            self.url.text = photo?.url
            if let imageUrl = photo?.url {
                self.image.sd_setImage(with: URL.init(string: imageUrl), completed: {_,_,_,_ in
                    
                })
            }
        }.store(in: &cancellables)
        
        photoViewModel.fetchPhoto(id: index)
        
        let interaction = UIContextMenuInteraction(delegate: self)
        image.addInteraction(interaction)
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        let favorite = UIAction(title: "Favorite", image: UIImage(systemName: "heart.fill")) { _ in  }
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in  }
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill")) { _ in }

      return UIContextMenuConfiguration(identifier: nil,
        previewProvider: nil) { _ in
        UIMenu(title: "Actions", children: [favorite, share, delete])
      }
    }
    
}




