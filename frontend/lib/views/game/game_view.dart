import 'package:flutter/material.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  _GameViewState createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  List<int> _board = List.filled(9, 0); // 0 empty, 1 X, 2 O
  int _currentPlayer = 1;
  bool _gameOver = false;
  String _message = "Player X's turn";

  void _handleTap(int index) {
    if (_board[index] == 0 && !_gameOver) {
      setState(() {
        _board[index] = _currentPlayer;
        if (_checkWinner(_currentPlayer)) {
          _gameOver = true;
          _message = 'Player ${_currentPlayer == 1 ? 'X' : 'O'} wins!';
        } else if (!_board.contains(0)) {
          _gameOver = true;
          _message = "It's a draw!";
        } else {
          _currentPlayer = _currentPlayer == 1 ? 2 : 1;
          _message = "Player ${_currentPlayer == 1 ? 'X' : 'O'}'s turn";
        }
      });
    }
  }

  bool _checkWinner(int player) {
    const wins = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (var win in wins) {
      if (_board[win[0]] == player &&
          _board[win[1]] == player &&
          _board[win[2]] == player) {
        return true;
      }
    }
    return false;
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(9, 0);
      _currentPlayer = 1;
      _gameOver = false;
      _message = "Player X's turn";
    });
  }

  Widget _buildCell(int index) {
    return GestureDetector(
      onTap: () => _handleTap(index),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent, width: 2),
        ),
        child: Center(
          child: Text(
            _board[index] == 1
                ? 'X'
                : _board[index] == 2
                    ? 'O'
                    : '',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Tic Tac Toe')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: 9,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) => _buildCell(index),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            _message,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _resetGame,
            child: const Text('Restart'),
          ),
        ],
      ),
    );
  }
}
