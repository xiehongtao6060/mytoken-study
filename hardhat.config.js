require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.19", // 使用与您的合约兼容的Solidity版本
  networks: {
    sepolia: {
      url: "https://api.zan.top/node/v1/eth/sepolia/0e10960fd7034a87807c5fec7b7531b3",
      accounts: ["2ab4febb62af9d9833dcac3346c17a6ba7463be830b4db184813c3c73fcd4b2b"]
    },
    // 可选：添加本地网络配置
    // localhost: {
    //   url: "http://127.0.0.1:8545"
    // }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  }
};