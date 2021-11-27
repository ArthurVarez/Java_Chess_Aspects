package utils;

import java.lang.Math.*;
import edu.uqac.aop.chess.agent.Move;
import edu.uqac.aop.chess.agent.HumanPlayer;
import edu.uqac.aop.chess.piece.Knight;
import edu.uqac.aop.chess.Board;
import edu.uqac.aop.chess.Spot;
import utils.Vector;

public class MoveValidator {
    public MoveValidator(Board board, Move move, HumanPlayer player) {
        _board = board;
        _move = move;
        _player = player;
    }

    public boolean isValidSpot() {
        if(!_board.getGrid()[_move.xI][_move.yI].isOccupied()) {
			System.out.println("You can't select an empty spot");
			return false;
        }
        return true;
    }

    public boolean isPlayerPiece() {
        if (_board.getGrid()[_move.xI][_move.yI].getPiece().getPlayer() == _player.getColor()) {
			System.out.println("You can't select a piece that is not yours");
            return false;
        }
        return true;
    }

    public boolean isValidMovement() {
        if (!_board.getGrid()[_move.xI][_move.yI].getPiece().isMoveLegal(_move)) {
			System.out.println("This piece can't realize this movement");
            return false;
        }
        return true;
    }

    public boolean isInBoard() {
        if (_move.xF < 0 || _move.xF >= Board.SIZE || _move.yF < 0 || _move.yF >= Board.SIZE) {
			System.out.println("Your piece can't go out of the board");
            return false;
        }
        return true;
    }

    public boolean notComingOnAlly() {
        Spot finalPos = _board.getGrid()[_move.xF][_move.yF];
        if (finalPos.isOccupied() && finalPos.getPiece().getPlayer() != _player.getColor()) {
			System.out.println("You can't eat a piece that is yours");
            return false;
        }
        return true;
    }

    public boolean notGoingThroughOtherPiece() {
        if (_board.getGrid()[_move.xI][_move.yI].getPiece().getClass() == Knight.class)
            return true;
        Vector startPos = new Vector(_move.xI, _move.yI);
        Vector finalPos = new Vector(_move.xF, _move.yF);
        Vector movement = new Vector(finalPos.x - startPos.x, finalPos.y - startPos.y);
        Vector unitMovement = new Vector(movement.x == 0 ? 0 : movement.x / Math.abs(movement.x),
                                        movement.y == 0 ? 0 : movement.y / Math.abs(movement.y));
        int power = Math.abs(movement.x) >= Math.abs(movement.y) ? Math.abs(movement.x) : Math.abs(movement.y);

        for (int i = 1; i != power; ++i) {
            Vector pos = new Vector(startPos.x + i * unitMovement.x, startPos.y + i * unitMovement.y);

            if (_board.getGrid()[pos.x][pos.y].isOccupied()) {
			    System.out.println("The piece can't go through other pieces");
                return false;
            }
        }
        return true;
    }

    private Board _board;
    private Move _move;
    private HumanPlayer _player;
}