
public class GameState {

  // MARK: - Instance Properties
  public unowned let gameManager: GameManager

  // MARK: - Compute Properties
  public var gameboard: Gameboard {
    return gameManager.gameboard
  }
  public var gameboardView: GameboardView {
    return gameManager.gameplayView.gameboardView
  }
  public var gameplayView: GameplayView {
    return gameManager.gameplayView
  }
  
  public var movesForPlayer: [Player: [MoveCommand]] {
    get { return gameManager.movesForPlayer }
    set { gameManager.movesForPlayer = newValue }
  }

  internal var turnsPerPlayer: Int {
    return gameManager.turnsPerPlayer
  }

  // MARK: - Object Lifecycle
  public init(gameManager: GameManager) {
    self.gameManager = gameManager
  }

  // MARK: - Actions
  public func addMove(at position: GameboardPosition) { }
  public func begin() { }
  public func handleActionPressed() { }
  public func handleUndoPressed() { }
}

