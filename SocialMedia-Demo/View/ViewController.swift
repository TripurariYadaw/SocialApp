//
//  ViewController.swift
//  SocialMedia-Demo
//
//  Created by User on 21/06/22.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel = {
        FeedViewModel()
    }()
    
    //MARK: - View life
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.handleScroll()
    }
    
    //MARK: - Init tableview cells
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ImageTableViewCell.nib, forCellReuseIdentifier: ImageTableViewCell.identifier)
        tableView.register(TextTableViewCell.nib, forCellReuseIdentifier: TextTableViewCell.identifier)
        tableView.register(VideoPlayerCell.nib, forCellReuseIdentifier: VideoPlayerCell.identifier)
        tableView.register(UrlTableViewCell.nib, forCellReuseIdentifier: UrlTableViewCell.identifier)
    }
    
    //Intialise view model
    func initViewModel() {
        viewModel.getFeeds()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    /// Play video in full screen
    /// videoURL as first argument
    func playVideoFullScreen(videoURL: URL) {
        let player = AVPlayer(url: videoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
}

/// tableview data source and delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.feedCellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var defaultCell = UITableViewCell()
        switch (viewModel.feedCellViewModel[indexPath.row].postType) {
        case CellType.video.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoPlayerCell.identifier, for: indexPath) as? VideoPlayerCell else { fatalError("xib does not exists") }
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            defaultCell = cell
        case CellType.image.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageTableViewCell.identifier, for: indexPath) as? ImageTableViewCell else { fatalError("xib does not exists") }
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            defaultCell = cell
            
        case CellType.text.rawValue:
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextTableViewCell.identifier, for: indexPath) as? TextTableViewCell else { fatalError("xib does not exists") }
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            defaultCell = cell
       
        case CellType.url.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UrlTableViewCell.identifier, for: indexPath) as? UrlTableViewCell else { fatalError("xib does not exists") }
            let cellVM = viewModel.getCellViewModel(at: indexPath)
            cell.cellViewModel = cellVM
            defaultCell = cell

            default:
               return defaultCell
            }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (viewModel.feedCellViewModel[indexPath.row].postType) {
        case CellType.video.rawValue:
            return 400
        case CellType.image.rawValue:
            return 400
        case CellType.text.rawValue:
            return UITableView.automaticDimension
        case CellType.url.rawValue:
            return UITableView.automaticDimension
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? VideoPlayerCell {
            cell.player?.pause()
            playVideoFullScreen(videoURL: URL(string: viewModel.feedCellViewModel[indexPath.row].content)!)
            }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.handleScroll()
    }

    //Handle scroll here for video auto play and pause
    func handleScroll() {
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows, indexPathsForVisibleRows.count > 0 {
            var focusCell: VideoPlayerCell?
            
            for indexPath in indexPathsForVisibleRows {
                if let cell = tableView.cellForRow(at: indexPath) as? VideoPlayerCell {
                    if focusCell == nil {
                        let rect = tableView.rectForRow(at: indexPath)
                        if tableView.bounds.contains(rect) {
                            cell.player?.play()
                            focusCell = cell
                        } else {
                            cell.player?.stop()
                            cell.player?.pause()
                        }
                    } else {
                        cell.player?.pause()
                    }
                }
            }
        }
    }
}

extension AVPlayer {
   func stop(){
    self.seek(to: CMTime.zero)
    self.pause()
   }
}
