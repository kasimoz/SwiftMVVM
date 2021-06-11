//
//  TableViewController.swift
//  SwiftMVVM
//
//  Created by KasimOzdemir on 9.06.2021.
//

import UIKit
import Combine
import SDWebImage

class TableViewController: BaseTableViewController {
    
    lazy var photoViewModel: PhotoViewModel = {
        let viewModel = PhotoViewModel()
        return viewModel
    }()
    
    private var cancellables: Set<AnyCancellable> = []
    private var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel(viewModel: photoViewModel)
        
        photoViewModel.$photos.sink{ photos in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
    @IBAction func editing(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
    }
    @IBAction func fetchPhotos(_ sender: UIBarButtonItem) {
        photoViewModel.fetchPhotos()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return photoViewModel.photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let photo = photoViewModel.photos[indexPath.row]
        cell.textLabel?.text = photo.title
        cell.detailTextLabel?.text = photo.url
        let transformer = SDImageResizingTransformer(size: CGSize(width: 75, height: 75), scaleMode: .fill)
        cell.imageView?.sd_setImage(with: URL(string: photo.thumbnailUrl ?? ""), placeholderImage: UIImage.init(named: "placeholder"), context: [.imageTransformer: transformer])
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            photoViewModel.photos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let itemToMove = photoViewModel.photos[fromIndexPath.row]
        photoViewModel.photos.remove(at: fromIndexPath.row)
        photoViewModel.photos.insert(itemToMove, at: to.row)
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index =  photoViewModel.photos[indexPath.row].id ?? 0
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView,
                            contextMenuConfigurationForRowAt indexPath: IndexPath,
                            point: CGPoint) -> UIContextMenuConfiguration? {
        
        let favorite = UIAction(title: "Favorite", image: UIImage(systemName: "heart.fill")) { _ in  }
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in  }
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash.fill")) { _ in }
        let identifier = String(indexPath.row)
        return UIContextMenuConfiguration(identifier: identifier as NSCopying,
                                          previewProvider: nil) { _ in
            UIMenu(title: "Actions", children: [favorite, share, delete])
        }
    }
    
    override func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
        guard
            let identifier = configuration.identifier as? String,
            let index = Int(identifier)
            else {
              return
          }
          
          // 2
          let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
          
          // 3
          self.index =  photoViewModel.photos[index].id ?? 0
          animator.addCompletion {
            self.performSegue(
              withIdentifier: "detail",
              sender: cell)
          }
    }
    
    override func tableView(_ tableView: UITableView, previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return makeTargetedPreview(for: configuration)
    }
    
    override func tableView(_ tableView: UITableView, previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        return makeTargetedPreview(for: configuration)
    }
    
    private func makeTargetedPreview(for configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        guard
            // 1
            let identifier = configuration.identifier as? String,
            let index = Int(identifier),
            // 2
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
        else {
            return nil
        }
        
        return UITargetedPreview(view: cell.imageView!)
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ViewController {
            vc.index = index
        }
    }
    
    
}
