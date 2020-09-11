//it will generate a game automatically

import GameplayKit

public class ComputerInputState: GameState {

  // MARK: - Instance Properties
  public let player: Player
  private let random = GKRandomSource.sharedRandom()

  // MARK: - Object Lifecycle
  public init(gameMode: GameManager, player: Player) {
    self.player = player
    super.init(gameManager: gameMode)
  }

  // MARK: - Computed Properties
  public var referee: Referee {
    return gameManager.referee
  }

  // MARK: - Actions
  public override func begin() {
    var positions = generateRandomWinningCombination()
    while positions.count < gameManager.turnsPerPlayer {
      positions.append(generateRandomPosition())
    }
    positions = random.arrayByShufflingObjects(in: positions) as! [GameboardPosition]

    movesForPlayer[player] = positions.map { MoveCommand(gameboard: gameboard, gameboardView: gameboardView, player: player, position: $0) }
    gameManager.transitionToNextState()
  }
    

  private func generateRandomWinningCombination() -> [GameboardPosition] {
    let index = random.nextInt(upperBound: referee.winningCombinations.count)
    return referee.winningCombinations[index]
  }

  private func generateRandomPosition() -> GameboardPosition {
    let column = random.nextInt(upperBound: gameboard.size.columns)
    let row = random.nextInt(upperBound: gameboard.size.rows)
    return GameboardPosition(column: column, row: row)
  }
}

