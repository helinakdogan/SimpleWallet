const { ethers } = require("hardhat");

async function main() {
    const [account2, account3] = await ethers.getSigners();

    const MyToken = await ethers.getContractFactory("MyToken");
    const myToken = await MyToken.deploy("1000000000000000000000000");

    console.log("ZHA deployed to:", myToken.address || "Adres alınamadı");

    // Account 3'ü token sahibi yapıyoruz
    await myToken.transfer(account3.address, "1000000000000000000000000"); // Account 3'e 1,000,000 ZHA
    console.log("Initial transfer completed: Account 3'e 1,000,000 ZHA gönderildi.");

    // Account 2 ve Account 3'ün başlangıç bakiyelerini kontrol ediyoruz
    const balanceAccount2 = await myToken.balanceOf(account2.address);
    const balanceAccount3 = await myToken.balanceOf(account3.address);
    console.log("Account 2 Bakiyesi:", balanceAccount2.toString());
    console.log("Account 3 Bakiyesi:", balanceAccount3.toString());

    // Account 3'ten Account 2'ye 1000 ZHA gönderme işlemi
    try {
        const tx = await myToken.connect(account3).transfer(account2.address, "5000000000000000000000"); // 1000 * 10^18 ZHA
        await tx.wait();
        console.log("Transfer başarılı! Account 3'ten Account 2'ye 5000 ZHA gönderildi.");

        // Güncellenmiş bakiyeleri kontrol ediyoruz
        const updatedBalanceAccount2 = await myToken.balanceOf(account2.address);
        const updatedBalanceAccount3 = await myToken.balanceOf(account3.address);
        console.log("Güncellenmiş Account 2 Bakiyesi:", updatedBalanceAccount2.toString());
        console.log("Güncellenmiş Account 3 Bakiyesi:", updatedBalanceAccount3.toString());
    } catch (error) {
        console.error("Transfer işlemi başarısız:", error.message);
    }
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});












// async function main() {
//     // Kontratın üretim fabrikasını al
//     const MyToken = await ethers.getContractFactory("MyToken");
    
//     // Kontratı dağıt
//     const myToken = await MyToken.deploy();
  
//     // Kontratın adresini terminalde göster
//     console.log("MyToken deployed to:", myToken.address);
//   }
  
//   // Hata yönetimi
//   main().catch((error) => {
//     console.error(error);
//     process.exitCode = 1;
//   });
  

