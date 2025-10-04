// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, ERC20Permit {
   // 不需要重复定义name和symbol，因为它们会在ERC20构造函数中设置
    address public owner;
    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {
        owner = msg.sender;
        // 铸造初始代币给部署者
        _mint(msg.sender, 1000000 * 10 ** decimals());
    }

}