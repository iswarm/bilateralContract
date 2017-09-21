pragma solidity ^0.4.15;

contract PtopFiatCurrencies {

    struct Signers {
        address aliceBank;
        address bobCustomer;
        bool[2] signedBank;
        bool[2] signedCustomer;
        uint256 blockNumForTransfer;
        uint256 blockNumForAskAbitrator;
        uint256 startBlock;
        address arbitrator;
        bool arbitrateResult; // true: bobCustomer win; false 
    }

    struct PledgeStatus {
        uint256 cashPledge;
        bool locked;
    }

    mapping(bytes32 => Signers) public signRecord; // 记录一个函数调用的签名双方及签名情况
    mapping(address => PledgeStatus) public cashPledge; // 记录aliceBank的押金

    event StartDeposit(address _aliceBank, address _bobCustomer, bytes32 _hash);
    event EndDeposit(address _aliceBank, address _bobCustomer, bytes32 _hash);
    event AskArbitrator(address _arbitrator, bytes32 _hash);
    event UnlockCashpledge(bytes32 _hash);

    function startPtopDeposit(address _party, bytes32 _hash, uint256 _blockNumForTransfer, uint256 _blockNumForAskAbitrator) returns (bool) {
        require(msg.sender!=_party);
        require(cashPledge[signRecord[_hash].aliceBank].cashPledge>10**18 && !cashPledge[signRecord[_hash].aliceBank].locked); // 检查数字资产持有方的ETH余额大于零且没有作为押金
        
        // 检查签名

        if (!signRecord[_hash].signedBank[0]) {
            signRecord[_hash].aliceBank = msg.sender;
            signRecord[_hash].bobCustomer = _party;
            signRecord[_hash].signedBank[0] = true;
            return true;
        } else if ( (msg.sender == signRecord[_hash].bobCustomer) && (signRecord[_hash].aliceBank == _party) && (!signRecord[_hash].signedCustomer[0]) ) {
            signRecord[_hash].signedCustomer[0] = true;
        } else {
            return false;
        }     
        cashPledge[signRecord[_hash].aliceBank].locked = true; // 数字资产持有方的ETH用做押金：只能在一次交易中使用
        signRecord[_hash].startBlock = block.number;
        signRecord[_hash].blockNumForTransfer = _blockNumForTransfer; // 转账所需时间（转换为区块数，出一个块的时间平均14s。）
        signRecord[_hash].blockNumForAskAbitrator = _blockNumForAskAbitrator; // 可以请求仲裁的时间（转换为区块数）

        StartDeposit(signRecord[_hash].aliceBank,signRecord[_hash].bobCustomer,_hash);

        return true;

    }

    function endPtopDeposit(address _party, bytes32 _hash) returns (bool) {
        require(msg.sender!=_party);
        require(cashPledge[signRecord[_hash].aliceBank].locked);
        require(signRecord[_hash].signedBank[0]);
        require(signRecord[_hash].signedCustomer[0]);

        // 检查签名
        
        if (msg.sender == signRecord[_hash].aliceBank && _party == signRecord[_hash].bobCustomer) {
            signRecord[_hash].signedBank[1] = true;
            return true;
        } else if (msg.sender == signRecord[_hash].bobCustomer && _party == signRecord[_hash].aliceBank) {
            signRecord[_hash].signedCustomer[1] = true;
        } else {
            return false;
        }
         

        cashPledge[signRecord[_hash].aliceBank].locked = false; // 释放押金

        EndDeposit(signRecord[_hash].aliceBank,signRecord[_hash].bobCustomer,_hash);

        return true;
    }

    function withdrawPledge() returns (bool) {
        require(cashPledge[msg.sender].cashPledge>0);
        require(!cashPledge[msg.sender].locked);
        // require(block.number>)
        msg.sender.transfer(cashPledge[msg.sender].cashPledge);
        return true;
    }

    function askArbitrator(address _arbitrator, bytes32 _hash) returns (bool) {
        require(block.number >= signRecord[_hash].startBlock + signRecord[_hash].blockNumForTransfer); // 检查进入仲裁请求时间段，但还没结束
        require(block.number <= signRecord[_hash].blockNumForAskAbitrator + signRecord[_hash].startBlock + signRecord[_hash].blockNumForTransfer);
        require(cashPledge[_arbitrator].cashPledge>0);
        require(!cashPledge[_arbitrator].locked);
        signRecord[_hash].arbitrator = _arbitrator;
        AskArbitrator(_arbitrator,_hash);
        return true;
    }

    function arbitrate(address _bob, address _alice, bytes32 _hash, bool _result) returns (bool) {
        
    }

    function unlockCashpledge(bytes32 _hash) returns (bool) {
        require(cashPledge[msg.sender].locked);        
        require(block.number > signRecord[_hash].blockNumForAskAbitrator + signRecord[_hash].startBlock + signRecord[_hash].blockNumForTransfer);
        require(msg.sender == signRecord[_hash].aliceBank || msg.sender == signRecord[_hash].bobCustomer);
        cashPledge[msg.sender].locked = false;
        UnlockCashpledge(_hash);
        return true;
    }

    function () payable {
        cashPledge[msg.sender].cashPledge += msg.value;
    }
}