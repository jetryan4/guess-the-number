pragma solidity ^0.8.1;
contract guess_number{

    address payable player;
    uint private secretNumber;
    enum State {OPEN, COMPLETE}
    State public currState;
    uint public balance;

    constructor (uint _secretNumber) payable {
        require(msg.value >= 10*10**18, 'this contract needs to be funded with 10 Eth');
        secretNumber = _secretNumber;
        currState = State.OPEN;
        balance = balance + msg.value;
    }

    function getBalance() public view returns (uint) {
        return balance;
    }

    function play(uint guessedNumber, address _player) external payable {
        require(msg.value == 10**18, 'you must pay to play');
        require(currState == State.OPEN);
        player = payable(_player);
        balance = balance + msg.value;
        if (guessedNumber == secretNumber){
            player.transfer(address(this).balance);
            currState = State.COMPLETE;
            balance = 0;
        }
    }

}