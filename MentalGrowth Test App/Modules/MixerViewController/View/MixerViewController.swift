//
//  MixerViewController.swift
//  MentalGrowth Test App
//
//  Created by Emil Karimov on 17/04/2020.
//  Copyright © 2020 Emil Karimov. All rights reserved.
//

import UIKit
import DevHelper

struct ViewModel {
    let index: Int
    let button: UIButton
    let progres: UIProgressView
    let current_lbl: UILabel
    let overall_lbl: UILabel
}

class MixerViewController: BaseViewController {

    var presenter: MixerPresenterProtocol!

    private var viewModels = [ViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()

    }

    private func createUI() {
        self.title = "Mixer"
        let stack = DHUIBuilder.make.stackView(orientation: .vertical, distribution: .fill, spacing: 20)

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

    /// генератор контролов громкости, прогресса и старт/пауза
    private func generateControls(on stack: UIStackView, soundtrack: SoundtrackType) {

        let container = UIView()
        container.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(200)
        }

        let currentTime_lbl = UILabel.makeLabel(size: 15, weight: .regular, color: .black)
        let overallTime_lbl = UILabel.makeLabel(size: 15, weight: .regular, color: .black)
        currentTime_lbl.textAlignment = .left
        overallTime_lbl.textAlignment = .right

        container.addSubview(currentTime_lbl)
        container.addSubview(overallTime_lbl)

        currentTime_lbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalTo(container.snp.centerX)
        }

        overallTime_lbl.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.left.equalTo(container.snp.centerX)
            $0.right.equalToSuperview().offset(-32)
        }

        let durationProgress = UIProgressView()
        durationProgress.progressTintColor = .gray
        container.addSubview(durationProgress)
        durationProgress.snp.makeConstraints {
            $0.top.equalTo(currentTime_lbl.snp.bottom).offset(10)
            $0.left.equalToSuperview().offset(32)
            $0.right.equalToSuperview().offset(-32)
        }

        let volumeSlider = UISlider()
        volumeSlider.tag = soundtrack.rawValue
        container.addSubview(volumeSlider)
        volumeSlider.snp.makeConstraints {
            $0.top.equalTo(durationProgress.snp.bottom).offset(20)
            $0.left.right.equalTo(durationProgress)
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
            $0.top.equalTo(volumeSlider.snp.bottom).offset(16)
            $0.left.right.equalTo(volumeSlider)
            $0.bottom.equalToSuperview().offset(-10)
        }

        stack.addArrangedSubview(container)

        let viewModel = ViewModel(index: soundtrack.rawValue,
            button: playPauseButton,
            progres: durationProgress,
            current_lbl: currentTime_lbl,
            overall_lbl: overallTime_lbl)
        self.viewModels.append(viewModel)
    }
}

// MARK: - Actions
extension MixerViewController {

    @objc private func didClickPlayPause(_ sender: UIButton) {
        self.presenter.didClickPlay(tag: sender.tag)
    }

    @objc private func didChangeVolume(_ sender: UISlider) {
        self.presenter.didChange(volume: sender.value, at: sender.tag)
    }
}

// MARK: - MixerViewProtocol
extension MixerViewController: MixerViewProtocol {

    func setProgress(on tag: Int, with value: Float) {
        guard self.viewModels.count > tag else { return }
        self.viewModels[tag].progres.setProgress(value, animated: true)
    }

    func changeTitle(on tag: Int, status: PlayStatus) {
        guard self.viewModels.count > tag else { return }
        self.viewModels[tag].button.setTitle(status.title)
    }

    func updateLabel(on tag: Int, with currentTime: String, and overallTime: String) {
        guard self.viewModels.count > tag else { return }
        let model = self.viewModels[tag]
        model.current_lbl.text = currentTime
        model.overall_lbl.text = overallTime
    }
}
