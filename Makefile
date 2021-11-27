JFLAGS = -g
JC = javac
BIN_FOLDER = bin
SRC_FOLDER = src

MAIN_FILE = edu/uqac/aop/chess/Chess
ASPECTJRT = /usr/share/java/aspectjrt.jar

SRC = \
		edu/uqac/aop/chess/agent/AiPlayer.java		\
		edu/uqac/aop/chess/agent/HumanPlayer.java	\
		edu/uqac/aop/chess/agent/Move.java			\
		edu/uqac/aop/chess/agent/Player.java		\
		edu/uqac/aop/chess/piece/Bishop.java		\
		edu/uqac/aop/chess/piece/King.java			\
		edu/uqac/aop/chess/piece/Knight.java		\
		edu/uqac/aop/chess/piece/Pawn.java			\
		edu/uqac/aop/chess/piece/Piece.java			\
		edu/uqac/aop/chess/piece/Queen.java			\
		edu/uqac/aop/chess/piece/Rook.java			\
		edu/uqac/aop/chess/Board.java				\
		edu/uqac/aop/chess/Chess.java				\
		edu/uqac/aop/chess/Spot.java				\
		utils/Logger.java							\
		utils/MoveValidator.java					\
		utils/Vector.java

ASP	=	\
		MyAspects/LoggerAspect.aj					\
		MyAspects/ValidateMoveAspect.aj

.SUFFIXES: .java .class
.java.class:
		$(JC) $(JFLAGS) $(SRC)

default:
	cd $(SRC_FOLDER) && ajc -source 1.8 $(JFLAGS) $(ASP) -d ../$(BIN_FOLDER) $(SRC)

clean:
	rm -rf $(BIN_FOLDER)

run: default
	cd $(BIN_FOLDER) && java -cp $(ASPECTJRT):. $(MAIN_FILE)

.PHONY: default clean run