async function main() {
  // 获取部署者账户
  const [deployer] = await ethers.getSigners();
  
  console.log("部署合约的账户地址:", deployer.address);
  console.log("账户余额:", (await deployer.getBalance()).toString());
  
  // 获取合约工厂
  const MyToken = await ethers.getContractFactory("MyToken");
  
  // 部署合约
  const myToken = await MyToken.deploy();
  
  // 等待部署完成
  await myToken.deployed();
  
  console.log("MyToken合约已部署到地址:", myToken.address);
}

// 运行主函数并处理错误
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });