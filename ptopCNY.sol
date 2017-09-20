pragma solidity ^0.4.15;

contract PtopFiatCurrencies {

    struct Signers {
        address aliceBank;
        address bobCustomer;
        bool signedBank;
        bool signedCustomer;
    }

    struct PledgeStatus {
        uint256 cashPledge;
        bool locked;
    }

    mapping(bytes32 => Signers) signRecord; // 记录一个函数调用的签名双方及签名情况
    mapping(address => PledgeStatus) cashPledge; // 记录aliceBank的押金

    event StartDeposit(address _aliceBank, address _bobCustomer, bytes32 _hash);

    function startPtopDeposit(address _party, bytes32 _hash) returns (bool) {
        require(msg.sender!=_party);
        if (!signRecord[_hash].signedBank) {
            signRecord[_hash].aliceBank = msg.sender;
            signRecord[_hash].bobCustomer = _party;
            signRecord[_hash].signedBank = true;
            return true;
        } else if ( (msg.sender == signRecord[_hash].bobCustomer) && (signRecord[_hash].aliceBank == _party) && (!signRecord[_hash].signedCustomer) ) {
            signRecord[_hash].signedCustomer = true;
        }
        
        require(cashPledge[signRecord[_hash].aliceBank].cashPledge>0);

        cashPledge[signRecord[_hash].aliceBank].locked = true;

        StartDeposit(signRecord[_hash].aliceBank,signRecord[_hash].bobCustomer,_hash);

        return true;

    }

    function endPtopDeposit(address _party, bytes32 _hash) returns (bool) {}

    function withdrawPledge() returns (bool) {}

    function askArbitrator(address _alex) returns (bool) {}

    function arbitrate(address _bob, address _alice, bytes32 _hash) returns (bool) {}
}