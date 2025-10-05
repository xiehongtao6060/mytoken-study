const { expect } = require("chai");

describe("MyToken合约测试", function () {
  let MyToken, myToken, owner, addr1, addr2;

  beforeEach(async function () {
    // 获取合约工厂和测试账户
    MyToken = await ethers.getContractFactory("MyToken");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    // 部署合约
    myToken = await MyToken.deploy();
    await myToken.deployed();
  });

  describe("部署测试", function () {
    it("应该正确设置代币名称和符号", async function () {
      expect(await myToken.name()).to.equal("MyToken");
      expect(await myToken.symbol()).to.equal("MTK");
    });

    it("应该将初始代币分配给部署者", async function () {
      const ownerBalance = await myToken.balanceOf(owner.address);
      expect(await myToken.totalSupply()).to.equal(ownerBalance);
    });
  });

  describe("转账功能测试", function () {
    it("应该允许从所有者账户转账", async function () {
      const initialOwnerBalance = await myToken.balanceOf(owner.address);
      
      // 转账100个代币给addr1
      await myToken.transfer(addr1.address, 100);
      
      // 检查余额变化
      const finalOwnerBalance = await myToken.balanceOf(owner.address);
      expect(finalOwnerBalance).to.equal(initialOwnerBalance.sub(100));
      
      const addr1Balance = await myToken.balanceOf(addr1.address);
      expect(addr1Balance).to.equal(100);
    });
  });
});