// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract MyContract {
    enum Mood {Surprise, Sadness, Disgust, Fear, Happiness, Anger}
    Mood currentMood;

    modifier modMood(Mood _expectedMood) {
        require(_expectedMood == currentMood, "Wrong mood!");
        _;
    }
    function someAction(Mood _expectedMood) public modMood(_expectedMood){
        currentMood = Mood.Surprise;
    }

    function setMood() public {
        currentMood = Mood.Happiness;
    }

}  