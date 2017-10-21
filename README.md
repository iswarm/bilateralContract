# 点对点充值 

在CNY和其它加密数字货币及法币间安全地交易而且无需信任：To safely exchange between CNY and other digital crypt-currencies and fiat currencies without trust

# 缘起

######

在一些国家，人们非常希望金融行业保持稳定。数字加密货币和法币间的交易有可能改变现行的金融规则。取缔比特币交易所（中心化）【或资金流转量比较大的网关】的消息不胫而走。一些网关和交易所已经主动停止充值CNY。一时间数字经济体市场风声鹤唳，币价波动很大。
　　
######
　　
悲哀的牛蛙持有20万邮局的USD。国内比特币、以太币等价格急剧下跌时，邮局USD由比特币途径CNY--->BTC.okcoin--->BTC.bitstamp--->USD传导链也随之急剧下跌。汇率一度达到5.5。青蛙觉得可以抄底USD，想跟牛蛙以5.6价格交易。可惜青蛙没有CNY。

######
　　
怎么办呢？一种是找二狗站长充值。虽然二狗已经暂停了充值业务。但是死缠滥打地、死皮烂脸地求求也许也可以的。但想想算了吧。关键时刻，二狗扛不住人情，充了个百八十万，钱没多赚多少，真被请去喝茶就不好了。虽然道士是可以死道友不死贫道的，但终究还是不好的。青蛙还提议和牛蛙草签合同，分多笔交易。可以到达交易的目的，也可以把风险控制在一定范围内。但蚊子再小也是肉不是，要是能没风险还能PP多好？
　　

# 转账

　　
青蛙觉得办法还是有的。青蛙在以太坊链上部署了一智能合约。牛蛙转价值1万CNY的ETH到智能合约账户做为交易押金。交易分多次进行，每次不超过1万CNY。青蛙先转1万CNY给牛蛙的银行账户，牛蛙转等值的邮局USD给青蛙。第一次成功后，双方无异议，则开始第二次转账。以此类推，直至整个交易最终完成，牛蛙撤回押金。

###### 仲裁

青蛙和牛蛙还邀请二狗做智能合约的仲裁人（arbitrator）。交易顺利，并没有二狗什么事情。万一交易双方有异议，则二狗的生意就来了。二狗根据双方当前的转账记录，判断谁的押金给另外一方，并收取点仲裁费。
　　
　　
# 价格


USD和CNY的价格怎么确定呢？牛蛙见多识广，说按照火币和邮局的市价来确定。青蛙觉得好有道理。细细一想，要是火币、okcoin等也只能币币交易了呢？如何确定CNY和USD在数字经济体内的价格呢？Ripple或者Stellar可以像淘宝一样作为市场吗？点对点充值，实际也是点对点场外交易，即CNY和各种数字货币交易。有数字货币的人可以在淘宝上或者自己的网站上开网店，卖自己的比特币。交易也可分多次完成，且交易一次，转账一次。双方无异议，则继续。如有异议，就可以使用二狗这样的仲裁人了。


钱包将提供简单的类似Openbazaar的功能，以供用户可以一键式地交易。


# 风控

仲裁人恶意或者无意地不公地判断，可能带来风险。根据BFT共识协议，要4个人才能容错1个。要在智能合约里实现BFT，代码性能会下降，实现代价颇大。一种经济解决方案是考虑互助保险。双方可以购买一定保险，当出现损失时，可以向智能合约申请理赔。

保险方案要求估算风险。点对点充值不正常率可以参考点对点贷款。根据<a href="https://content.lvhuadai.com/p2p_xydd_20160324983028.html" title="不良贷款率">点对点贷款不良率 </a>，对比点对点贷款平台的催款团队和智能合约押金对交易双方的约束能力，估计点对点充值的不正常率会大大低于点对点贷款不良率，估计仲裁申请率1%%，仲裁错误率1%。

每笔充值保费金额：押金的1%。

# 保险储备金及利润分成

保险储备金采用ICO方式募集。发行代币EIN，数量固定10000，其中2000个为研发团队和推广团队持有，8000个用于募集资金。资金总额5000 000 CNY. 所有资金为ETH，存放于智能合约。

保险业务分成：每年多于5000 000 CNY的资金按10000份分成，智能合约自动分到每个持有EIN的账户。


# 优势

   * 资金安全，不用担心对方跑路或赖账，几乎杜绝交易风险，没有诈骗生成的空间

   * 上述（USD，CNY）交易对的故事可以推广到（BTC,CNY）,(LTC,CNY),(JPY,CNY)等别的加密货币和外汇

   * 没有中心化的网关或者localBitcoins场外交易这样的中心化撮合网站。无论面临何种外部压力，都能像比特币系统一样不停机工作

   * 最便宜的交易方法，没有充值费或者提现费（除了银行的转账费用外）

   * 有效杜绝市场操纵行为（比如中心化交易所亏空问题、超发问题）

   * 可以更好地保护隐私

   * 充值、提现速度快，不会出现像交易所或网关那样等待很长时间才能到账的情况

# 劣势

   * 转账需押金，多次转账。押金越少，转账次数可能越多。具体转账次数依赖于押金和转账金额

   * 要求交易双方都有ETH

   * 用户需理解基于智能合约押金转账与依赖中心化机构信任背书的转账的不同，需一定时间习惯操作方式

# 智能合约代码

   阅读ptopCNY.sol


# 智能合约地址

   * rinkeby测试地址：0xa06C9a63d83e16dFb5D11422ED078444Caa1a2e6
   * ABI接口：

   ```js

   [ { "constant": false, "inputs": [], "name": "withdrawPledge", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "_arbitrator", "type": "address" }, { "name": "_hash", "type": "bytes32" } ], "name": "askArbitrator", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [], "name": "owner", "outputs": [ { "name": "", "type": "address", "value": "0x1eb3162901545cb116b780f3456186b5d1396142" } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "_party", "type": "address" }, { "name": "_hash", "type": "bytes32" } ], "name": "endPtopDeposit", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "_party", "type": "address" }, { "name": "_hash", "type": "bytes32" }, { "name": "_blockNumForTransfer", "type": "uint256" }, { "name": "_blockNumForAskAbitrator", "type": "uint256" } ], "name": "startPtopDeposit", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": false, "inputs": [ { "name": "_bob", "type": "address" }, { "name": "_alice", "type": "address" }, { "name": "_hash", "type": "bytes32" }, { "name": "_bobResult", "type": "bool" } ], "name": "arbitrate", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [ { "name": "", "type": "bytes32" } ], "name": "signRecord", "outputs": [ { "name": "aliceBank", "type": "address", "value": "0x0000000000000000000000000000000000000000" }, { "name": "bobCustomer", "type": "address", "value": "0x0000000000000000000000000000000000000000" }, { "name": "blockNumForTransfer", "type": "uint256", "value": "0" }, { "name": "blockNumForAskAbitrator", "type": "uint256", "value": "0" }, { "name": "startBlock", "type": "uint256", "value": "0" }, { "name": "arbitrator", "type": "address", "value": "0x0000000000000000000000000000000000000000" }, { "name": "arbitrateResult", "type": "bool", "value": false } ], "payable": false, "stateMutability": "view", "type": "function" }, { "constant": false, "inputs": [ { "name": "_hash", "type": "bytes32" } ], "name": "unlockCashpledge", "outputs": [ { "name": "", "type": "bool" } ], "payable": false, "stateMutability": "nonpayable", "type": "function" }, { "constant": true, "inputs": [ { "name": "", "type": "address" } ], "name": "cashPledge", "outputs": [ { "name": "cashPledge", "type": "uint256", "value": "0" }, { "name": "locked", "type": "bool", "value": false } ], "payable": false, "stateMutability": "view", "type": "function" }, { "inputs": [], "payable": false, "stateMutability": "nonpayable", "type": "constructor" }, { "payable": true, "stateMutability": "payable", "type": "fallback" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "_aliceBank", "type": "address" }, { "indexed": false, "name": "_bobCustomer", "type": "address" }, { "indexed": false, "name": "_hash", "type": "bytes32" } ], "name": "StartDeposit", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "_aliceBank", "type": "address" }, { "indexed": false, "name": "_bobCustomer", "type": "address" }, { "indexed": false, "name": "_hash", "type": "bytes32" } ], "name": "EndDeposit", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "_arbitrator", "type": "address" }, { "indexed": false, "name": "_hash", "type": "bytes32" } ], "name": "AskArbitrator", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "_hash", "type": "bytes32" } ], "name": "UnlockCashpledge", "type": "event" }, { "anonymous": false, "inputs": [ { "indexed": false, "name": "_bob", "type": "address" }, { "indexed": false, "name": "_alice", "type": "address" }, { "indexed": false, "name": "_hash", "type": "bytes32" }, { "indexed": false, "name": "_bobResult", "type": "bool" } ], "name": "Arbitrate", "type": "event" } ]

   ```
# 使用教程

## 钱包

## 新用户（无CNY或者其它任何数字加密货币的用户）

新用户需要一点ETH。可以和提供P2P CNY充值服务的用户交易。一般而言，提供充值服务的用户P有某种加密数字货币储量。用户P通过公开市场将加密数字货币换成ETH，向智能合约转账充值。新用户验证P在智能合约的锁定金额，并在规定时间内转等值CNY给用户P。这样新用户就可安全地获得ETH，并可以通过公开币币交易市场换成别的加密数字货币。充值服务可收取0.2%手续费。

新用户充值有别于有交易押金的情况。用户P的押金分3种状态：双方相互转账期---->新用户申诉期---->交易完成后用户P可撤销期。









# 路线图

  * 2017年9月，完成智能合约并部署测试

  * 2017年10月，正式上线，基于Mist和ethereum wallet等钱包完成使用教程

  * 2018年 2 月， 提供汉化定制版钱包

  * 2018年 6 月， 提供Ripple支持

  * 2018年 12月， 提供Stellar支持

  * 2019年 3 月， 提供bitcoin支持

  * 2019年 6 月， 提供zcash支持

  * 2019年 9 月， 提供跳转银行（支持免费转账）、支付宝和微信支持

  * 2020年 12 月， 提供可定制的交易系统（含搬砖路径支持系统）

  * 2021年 12 月， 提供基于counterfactual regret minimization 算法的分布式投资辅助决策系统

    

# 打赏

######

  Ripple地址： rhbaA9xBaBjzgRwAghAbCVz4Ym7qw9UnWy

###### 

  Bitcoin地址：1BBw45CQxieVkxoC8o2G2Jfcz7EdeeVbXs


###### 

  以太坊地址： 0x1eb3162901545cb116b780f3456186b5d1396142

###### 

  Stellar地址： GBXXGZGNA6DQ5U4LKF6FP3QNXIZ4X3OTSRXYRV36N5UPKB5JG6Y3ROCK


