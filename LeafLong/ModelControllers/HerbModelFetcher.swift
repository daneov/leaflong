//
//  HerbModelFetcher.swift
//  LeafLong
//
//  Created by Daneo Van Overloop on 17/08/2024.
//

import Foundation
import Combine

protocol HerbModelFetcher {
    func fetchHerbOfTheDay() -> AnyPublisher<Herb, Never>
}

extension HerbModelController: HerbModelFetcher {
    func fetchHerbOfTheDay() -> AnyPublisher<Herb, Never> {
        let imageURL = URL(string: "https://fydn.imgix.net/m/gen/art-print-std-portrait-p1/a012baa0-bd65-4618-9a28-dbd8a976b5ae.jpg?auto=format%2Ccompress&q=75")!
        
        return Just(Herb(
            id: UUID(),
            name: "Caraway",
            detail: "The plant is similar in appearance to other members of the carrot family, with finely divided, feathery leaves with thread-like divisions, growing on 20–30 cm (8–12 in) stems. The main flower stem is 30–60 cm (12–24 in) tall, with small white or pink flowers in compound umbels composed of 5–16 unequal rays 1–6 cm (0.4–2.4 in) long. Caraway fruits, informally called seeds, are smooth, crescent-shaped, laterally compressed achenes, around 3 mm (1⁄8 in) long, with five pale ridges and a distinctive pleasant smell when crushed.[7] It flowers in June and July.",
            imageSource: imageURL
        ))
        .delay(for: 3, scheduler: RunLoop.current)
        .eraseToAnyPublisher()
    }
}
