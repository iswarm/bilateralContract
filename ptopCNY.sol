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
    address public owner;

    event StartDeposit(address _aliceBank, address _bobCustomer, bytes32 _hash);
    event EndDeposit(address _aliceBank, address _bobCustomer, bytes32 _hash);
    event AskArbitrator(address _arbitrator, bytes32 _hash);
    event UnlockCashpledge(bytes32 _hash);
    event Arbitrate(address _bob, address _alice, bytes32 _hash, bool _bobResult);

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
        owner.transfer(cashPledge[signRecord[_hash].aliceBank].cashPledge/1000); // 收取充值押金的千分之一
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

    function arbitrate(address _bob, address _alice, bytes32 _hash, bool _bobResult) returns (bool) {
        require(msg.sender == signRecord[_hash].arbitrator);
        cashPledge[msg.sender].locked = true;
        if (signRecord[_hash].aliceBank == _alice && signRecord[_hash].bobCustomer == _bob ) {
            signRecord[_hash].arbitrateResult = _bobResult;
        } else if (signRecord[_hash].aliceBank == _bob && signRecord[_hash].bobCustomer == _alice) {
            if (true == _bobResult) {
                 signRecord[_hash].arbitrateResult = false;
            } else {
                signRecord[_hash].arbitrateResult = true;
            }
        }

        if (true == signRecord[_hash].arbitrateResult) {
            // 说明Alice并没有转等值的加密数字货币给Bob
            uint256 alicePledge = cashPledge[signRecord[_hash].aliceBank].cashPledge;
            owner.transfer(alicePledge/1000); // 收取充值押金的千分之一
            alicePledge = alicePledge - alicePledge/1000;
            msg.sender.transfer(alicePledge / 10);
            address bobCustomer = signRecord[_hash].bobCustomer;
            bobCustomer.transfer(alicePledge - alicePledge / 10);
            cashPledge[signRecord[_hash].aliceBank].cashPledge = 0;
            cashPledge[signRecord[_hash].aliceBank].locked = false;
            Arbitrate(_bob,  _alice,  _hash,  _bobResult);
        } else {
            // 哦，系统出错：Alice按约定转出了，但Bob没在约定时间内收到。我也不知道怎么办。
            Arbitrate(_bob,  _alice,  _hash,  _bobResult); 
        }

        return true;
        
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