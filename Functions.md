### 开始P2P充值


     

<pre><code>

function startPtopDeposit(address _Bob, bytes32 _hash) twosign(bytes32 _data) return (bool) { }

</code></pre>


<p>输入参数说明：</P>



+  _Bob----充值用户地址

+  _hash----充值协议的sha3-256哈希值：Bob和Alice的CNY银行账户，Ripple账户，Ethereum账户，约定的每次转账时间(以区块为单位计算)，金额，总的金额，Bob发起仲裁的时间(以区块为单位计算)，Alice可撤回押金的时间(以区块为单位计算)。可以使用在线hash工具算得。<http://tools.jb51.net/password/hash_md5_sha>

<p>注释：需要Alice和Bob双方签名</p>

###  结束P2P充值

<p>结束条件：</p>

* 充值结束

* Bob没有在规定时间内转CNY到Alice的银行账户

* 仲裁人裁定Alice没在约定时间内转账加密数字货币给Bob


<pre><code>

function endPtopDeposit(address _Bob, bytes32 _hash) twosign(bytes32 _data) return (bool) { }

</code></pre>

<p>输入参数说明：同开始</P>

<p>注释：需要Alice和Bob双方签名</p>


### 撤回押金

<p>撤回押金的条件 </p> 

* 充值结束

* Bob没有在规定时间内转CNY到Alice的银行账户



<pre><code>

function withdrawPledge() return (bool) {}

</code></pre>

### 发起仲裁请求

<p>Bob发起仲裁请求的条件：</p>

* 没有在约定时间内收到加密数字货币

<pre><code>

function askArbitrator(address _Alex) return (bool) {}

</code></pre>


### 仲裁

<p>仲裁人根据P2P转账设置资料的hash验证资料（协议），并查验在约定的时间内Bob的转账。如果情况属实，Alice的押金90%转账给Bob，10%作为仲裁费由仲裁人收取。</p>

<pre><code>

function arbitrate(address _Bob, address _Alice, bytes32 _hash) return (bool)

</code></pre>



