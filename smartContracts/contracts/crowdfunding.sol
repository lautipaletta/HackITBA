// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Crowdfund {
    address payable public destination;
    uint public targetAmount; 

    uint public contractExpiration;

    struct Donor {
        address payable addr;
        uint donation;
    }

    Donor[] public donors;

    constructor (address payable dest, uint target, uint contractExpirationUNIXEpoch) {
        destination = dest;
        targetAmount = target;
        contractExpiration = contractExpirationUNIXEpoch;
    }

    event donationReceived(uint value);

    function addDonor () public payable {
        donors.push(Donor(payable(msg.sender), msg.value));        

        emit donationReceived(msg.value);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    event crowdfundRefunded(uint donorsRefunded, uint totalDonors); 
    function checkExpirationDate() public payable {
        if (block.timestamp * 1000 >= contractExpiration) {
            uint donorsRefunded = 0;
            for (uint i = 0; i < donors.length; i++) {
                (bool success, ) = donors[i].addr.call{value: donors[i].donation}(""); 
                if (success)
                    donorsRefunded++;
            }
            emit crowdfundRefunded(donorsRefunded, donors.length);
        }
    }

    event crowdfundSuccess(address payable dest, uint amount);
    function transfer() public payable {
        if (address(this).balance >= targetAmount) {
            (bool success, ) = destination.call{value: address(this).balance}("");

            if (success)
                emit crowdfundSuccess(destination, targetAmount);
        }
    }
}
