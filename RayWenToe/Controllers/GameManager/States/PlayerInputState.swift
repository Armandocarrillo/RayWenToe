
public class PlayerInputState: GameState {

  // MARK: - Instance Properties
  public let actionTitle: String
  public let player: Player

  // MARK: - Object Lifecycle
  public init(gameMode: GameManager, player: Player, actionTitle: String) {
    self.actionTitle = actionTitle
    self.player = player
    super.init(gameManager: gameMode)
  }

  // MARK: - Actions
  public override func begin() {
    gameplayView.actionButton.setTitle(actionTitle, for: .normal)
    gameplayView.gameboardView.clear()
    updatePlayerLabel()
    updateMoveCountLabel()
  }

  public override func addMove(at position: GameboardPosition) {
    
    let moveCount = movesForPlayer[player]!.count
    guard moveCount < turnsPerPlayer else { return }
    
    displayMarkView(at: position, turnNumber: moveCount + 1)
    //both require to use MoveCommand
    enqueueMoveCommand(at: position)
    updateMoveCountLabel()
    
  }

  private func enqueueMoveCommand(at position: GameboardPosition) {
    
    let newMove = MoveCommand(gameboard: gameboard, gameboardView: gameboardView, player: player, position: position)
    movesForPlayer[player]!.append(newMove)
  }

  private func displayMarkView(at position: GameboardPosition, turnNumber: Int) {
    guard let markView = gameplayView.gameboardView.markViewForPosition[position] else {
      let markView = player.markViewPrototype.copy() as MarkView
      markView.turnNumbers = [turnNumber]
      gameplayView.gameboardView.placeMarkView(markView, at: position, animated: false)
      return
    }
    markView.turnNumbers.append(turnNumber)
  }

  private func updatePlayerLabel() {
    gameplayView.playerLabel.text = player.turnMessage
  }

  private func updateMoveCountLabel() {
    
    let turnRemaining = turnsPerPlayer - movesForPlayer[player]!.count
    gameplayView.moveCountLabel.text = "\(turnRemaining) Moves Left"
    
  }

  public override func handleActionPressed() {
   //check if the player has made all of her selections
    guard movesForPlayer[player]!.count == turnsPerPlayer else { return }
    gameManager.transitionToNextState()
    
  }

  public override func handleUndoPressed() {
    
    var moves = movesForPlayer[player]!
    guard let position = moves.popLast()?.position else { return }
    
    movesForPlayer[player] = moves
    updateMoveCountLabel()
    
    let markView = gameboardView.markViewForPosition[position]!
    //uses turnNumbers in order to display the order that it was selected
    _ = markView.turnNumbers.popLast()
    
    guard markView.turnNumbers.count == 0 else { return }
    gameboardView.removeMarkView(at: position, animated: false)
    
  }
}

