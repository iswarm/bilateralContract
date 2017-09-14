###### 开始P2P充值


     

<pre><code>

function startPtopDeposit(address _Bob, bytes32 _hash) twosign(bytes32 _data) return (bool) { }

</code></pre>


<p>输入参数说明：</P>



+  _Bob----充值用户地址

+  _hash----充值协议的sha3-256哈希值：Bob和Alice的CNY银行账户，Ripple账户，Ethereum账户，约定的每次转账时间(以区块为单位计算)，金额，总的金额，Bob发起仲裁的时间(以区块为单位计算)，Alice可撤回押金的时间(以区块为单位计算)。可以使用在线hash工具算得。<http://tools.jb51.net/password/hash_md5_sha>

<p>注释：需要Alice和Bob双方签名</p>

######  结束P2P充值


<pre><code>

function endPtopDeposit(address _Bob, bytes32 _hash) twosign(bytes32 _data) return (bool) { }

</code></pre>

<p>输入参数说明：同开始</P>

<p>注释：需要Alice和Bob双方签名</p>



