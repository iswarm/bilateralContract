pragma solidity ^0.4.16;

contract PtopFiatCurrencies {

    struct Signers {
        address ownerOne;
        address ownerTwo;
        bool signedOne;
        bool signedTwo;
    }

    mapping(bytes32 => Signers) signRecord; // 记录一个函数调用的签名双方及签名情况

    function startPtopDeposit(address _Bob, bytes32 _hash) return (bool) {}

    function endPtopDeposit(address _Bob, bytes32 _hash) return (bool) {}

    function withdrawPledge() return (bool) {}

    function askArbitrator(address _Alex) return (bool) {}

    function arbitrate(address _Bob, address _Alice, bytes32 _hash) return (bool) {}
}