//
//  MixerViewController.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit
import DevHelper

class MixerViewController: BaseViewController {

    var presenter: MixerPresenterProtocol!
    private var buttons = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {
        self.title = "Mixer"
        let stack = DHUIBuilder.make.stackView(orientation: .vertical, distribution: .equalSpacing, spacing: 20)

        self.view.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        let spacer1 = UIView()
        stack.addArrangedSubview(spacer1)
        spacer1.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(1)
        }
        SoundtrackType.allCases.forEach {
            self.generateControls(on: stack, soundtrack: $0)
        }

        let spacer2 = UIView()
        stack.addArrangedSubview(spacer2)
        spacer2.snp.makeConstraints {
            $0.height.equalTo(spacer1)
        }
    }
}

// MARK: - Private
extension MixerViewController {

    private func generateControls(on stack: UIStackView, soundtrack: SoundtrackType) {

        let container = UIView()
        container.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(150)
        }

        let volumeSlider = UISlider()
        volumeSlider.tag = soundtrack.rawValue
        container.addSubview(volumeSlider)
        volumeSlider.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-32)
        }
        volumeSlider.setValue(0.5, animated: false)
        volumeSlider.addTarget(self, action: #selector(didChangeVolume(_:)), for: .valueChanged)

        let playPauseButton = UIButton(type: .custom)
        playPauseButton.tag = soundtrack.rawValue
        playPauseButton.setTitle("Play")
        playPauseButton.setTitleColor(.black)
        playPauseButton.addTarget(self, action: #selector(didClickPlayPause(_:)), for: .touchUpInside)

        container.addSubview(playPauseButton)
        playPauseButton.snp.makeConstraints {
            $0.top.equalTo(volumeSlider.snp.bottom).offset(6)
            $0.left.right.equalTo(volumeSlider)
            $0.bottom.equalToSuperview()
        }

        stack.addArrangedSubview(container)
        self.buttons.append(playPauseButton)
    }

    @objc private func didClickPlayPause(_ sender: UIButton) {
        self.presenter.didClickPlay(tag: sender.tag)
    }

    @objc private func didChangeVolume(_ sender: UISlider) {
        self.presenter.didChange(volume: sender.value, at: sender.tag)
    }
}

// MARK: - MixerViewProtocol
extension MixerViewController: MixerViewProtocol {
    func changeTitle(on tag: Int, status: PlayStatus) {
        guard self.buttons.count > tag else { return }
        let button = self.buttons[tag]
        button.setTitle(status.title)
    }
}
