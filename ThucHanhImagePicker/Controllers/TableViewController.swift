//
//  TableViewController.swift
//  ThucHanhImagePicker
//
//  Created by Hoàng Đức on 19/11/2022.
//

import UIKit
import Photos
import AVKit

class TableViewController: UITableViewController {
    // Array to hold videos
        var videos: [PHAsset] = []
        
        // Create cell identifier for UITableView
        let tableViewCellIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: tableViewCellIdentifier)
        title = "Video"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Request access to PhotosApp
               PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                   
                   // Handle restricted or denied state
                   if status == .restricted || status == .denied
                   {
                       print("Status: Restricted or Denied")
                   }
                   
                   // Handle limited state
                   if status == .limited
                   {
                       self?.fetchVideos()
                       print("Status: Limited")
                   }
                   
                   // Handle authorized state
                   if status == .authorized
                   {
                       self?.fetchVideos()
                       print("Status: Full access")
                   }
               }
    }
    
       func fetchVideos()
       {
           // Fetch all video assets from the Photos Library as fetch results
           let fetchResults = PHAsset.fetchAssets(with: PHAssetMediaType.video, options: nil)
           
           // Loop through all fetched results
           fetchResults.enumerateObjects({ [weak self] (object, count, stop) in
               
               // Add video object to our video array
               self?.videos.append(object)
           })
           
           // Reload the table view on the main thread
           DispatchQueue.main.async {
               self.tableView.reloadData()
           }
       }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier)!
        
        // Get video asset at current index
        let videoAsset = videos[indexPath.row]
        
        // Display video creation date
        cell.textLabel?.text = "Video from \(videoAsset.creationDate ?? Date())"
        
        // Load video thumbnail
        PHCachingImageManager.default().requestImage(for: videoAsset,
                                                     targetSize: CGSize(width: 100, height: 100),
                                                     contentMode: .aspectFill,
                                                     options: nil) { (photo, _) in
            
            cell.imageView?.image = photo
            
        }
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
       {
           // Get video asset at current index
           let videoAsset = videos[indexPath.row]
           
           // Fetch the video asset
           PHCachingImageManager.default().requestAVAsset(forVideo: videoAsset, options: nil) { [weak self] (video, _, _) in
               if let video = video
               {
                   // Launch video player in the main thread
                   DispatchQueue.main.async {
                       self?.playVideo(video)
                   }
               }
           }
       }
    private func playVideo(_ video: AVAsset)
       {
           let playerItem = AVPlayerItem(asset: video)
           let player = AVPlayer(playerItem: playerItem)
           let playerViewController = AVPlayerViewController()
           playerViewController.player = player
           
           present(playerViewController, animated: true) {
               playerViewController.player!.play()
           }
       }
   }
  
