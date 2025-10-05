// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 作业 1：ERC20 代币
// 任务：参考 openzeppelin-contracts/contracts/token/ERC20/IERC20.sol实现一个简单的 ERC20 代币合约。要求：
// 1. 合约包含以下标准 ERC20 功能：
// - balanceOf：查询账户余额。
// - transfer：转账。
// - approve 和 transferFrom：授权和代扣转账。
// 2. 使用 event 记录转账和授权操作。
// 3. 提供 mint 函数，允许合约所有者增发代币。
// 提示：
// - 使用 mapping 存储账户余额和授权信息。
// - 使用 event 定义 Transfer 和 Approval 事件。
// - 部署到sepolia 测试网，导入到自己的钱包

// 不使用OpenZeppelin库，手动实现ERC20标准
contract MyToken {
    // 代币的基本信息
    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    
    // 使用mapping存储账户余额
    mapping(address => uint256) public balanceOf;
    
    // 使用嵌套mapping存储授权信息
    // 格式：allowance[owner][spender] = amount
    mapping(address => mapping(address => uint256)) public allowance;
    
    // 合约所有者地址
    address public owner;
    
    // 定义Transfer事件
    event Transfer(address indexed from, address indexed to, uint256 value);
    
    // 定义Approval事件
    event Approval(address indexed owner, address indexed spender, uint256 value);
    
    // 构造函数，初始化合约
    constructor() {
        // 设置合约创建者为所有者
        owner = msg.sender;
        // 初始供应量为1,000,000，考虑18位小数
        uint256 initialSupply = 1000000 * (10 ** uint256(decimals));
        // 调用mint函数创建初始代币
        mint(msg.sender, initialSupply);
    }
    
    // 修饰符：限制只有所有者可以调用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    
    // 实现balanceOf函数
    // 返回指定账户的代币余额
    // function balanceOf(address account) public view returns (uint256) {
    //     return balanceOf[account];
    // }
    
    // 实现transfer函数
    // 从调用者账户向目标账户转账
    function transfer(address to, uint256 amount) public returns (bool) {
        require(to != address(0), "Transfer to the zero address is not allowed");
        require(balanceOf[msg.sender] >= amount, "Insufficient balance");
        
        // 执行转账
        balanceOf[msg.sender] -= amount;
        balanceOf[to] += amount;
        
        // 触发Transfer事件
        emit Transfer(msg.sender, to, amount);
        return true;
    }
    
    // 实现approve函数
    // 授权spender可以转移一定数量的代币
    function approve(address spender, uint256 amount) public returns (bool) {
        require(spender != address(0), "Approve to the zero address is not allowed");
        
        // 设置授权额度
        allowance[msg.sender][spender] = amount;
        
        // 触发Approval事件
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    
    // 实现transferFrom函数
    // 从授权账户向目标账户转账
    function transferFrom(address from, address to, uint256 amount) public returns (bool) {
        require(from != address(0), "Transfer from the zero address is not allowed");
        require(to != address(0), "Transfer to the zero address is not allowed");
        require(balanceOf[from] >= amount, "Insufficient balance");
        require(allowance[from][msg.sender] >= amount, "Insufficient allowance");
        
        // 减少授权额度
        allowance[from][msg.sender] -= amount;
        
        // 执行转账
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        
        // 触发Transfer事件
        emit Transfer(from, to, amount);
        return true;
    }
    
    // 实现mint函数，允许合约所有者增发代币
    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "Mint to the zero address is not allowed");
        
        // 增加总供应量
        totalSupply += amount;
        
        // 增加目标账户余额
        balanceOf[to] += amount;
        
        // 触发Transfer事件，from为0地址表示新发行的代币
        emit Transfer(address(0), to, amount);
    }
}