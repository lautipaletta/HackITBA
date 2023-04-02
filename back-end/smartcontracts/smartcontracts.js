const Web3 = require("web3");
const fs = require("fs");

const web3 = new Web3('http://ganache:8545');

const contractBytecode = fs.readFileSync("/app/smartcontracts/crowdfunding_sol_Crowdfund.bin").toString();

const contractABIRaw = fs.readFileSync("/app/smartcontracts/crowdfunding_sol_Crowdfund.abi").toString();
const contractABI = JSON.parse(contractABIRaw);

const crowdfundingContract = new web3.eth.Contract(contractABI);

async function createCrowfundingContract(signerAddress, recipientAddress, amount, expiryDateSinceUNIXEpoch) {
    const deployCrowdfundingContract = crowdfundingContract.deploy({
        data: contractBytecode,
        arguments: [recipientAddress, web3.utils.toWei(amount), expiryDateSinceUNIXEpoch]
    });

    const deployedCrowdfundingContract = await deployCrowdfundingContract.send({
        from: signerAddress,
        gas: await deployCrowdfundingContract.estimateGas()
    });

    return deployedCrowdfundingContract.options.address;
}

async function addDonor(contractAddress, senderAddress, donationAmount) {
    const contract = new web3.eth.Contract(contractABI, contractAddress);

    const amountCollectedWei = web3.utils.toBN(await contract.methods.getBalance().call());
    const targetAmountWei = web3.utils.toBN(await contract.methods.targetAmount().call());

    let donationAmountWei = web3.utils.toBN(web3.utils.toWei(donationAmount));

    let crowdfundingCompleted = 0;
    if (targetAmountWei.lte(amountCollectedWei.add(donationAmountWei))) {
        donationAmountWei = targetAmountWei.sub(amountCollectedWei); 
        crowdfundingCompleted = 1;
    }

    await contract.methods.addDonor().send({
        from: senderAddress,
        value: donationAmountWei 
    });

    await transferMoneyToRecipientIfAmountCollected(contractAddress, senderAddress);
    await checkExpirationDate(contractAddress, senderAddress);

    return crowdfundingCompleted;
}

async function checkExpirationDate(contractAddress, senderAddress) {
    const contract = new web3.eth.Contract(contractABI, contractAddress);
    await contract.methods.checkExpirationDate().send({
        from: senderAddress
    });
}

async function transferMoneyToRecipientIfAmountCollected(contractAddress, senderAddress) {
    const contract = new web3.eth.Contract(contractABI, contractAddress);
    await contract.methods.transfer().send({
        from: senderAddress
    });
}

async function getCollectedAmount(contractAddress) {
    const contract = new web3.eth.Contract(contractABI, contractAddress);
    const amountWei = await contract.methods.getBalance().call();
    const amountEther = web3.utils.fromWei(amountWei, "ether");

    return amountEther; 
}

module.exports = { createCrowfundingContract, addDonor, getCollectedAmount, checkExpirationDate };
