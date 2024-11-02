// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MyCryptoCoin {
    // Kripto paranın adı
    string public name = "MyCryptoCoin";
    // Kripto paranın sembolü
    string public symbol = "MCC";
    // Ondalık basamak sayısı (genellikle 18 olarak belirlenir)
    uint8 public decimals = 18;
    // Toplam arz
    uint256 public totalSupply;

    // Her adresin bakiyesini tutan eşleme (mapping)
    mapping(address => uint256) public balanceOf;

    // Sahip değişikliği için olay (event)
    event Transfer(address indexed from, address indexed to, uint256 value);

    // İlk oluşturulurken toplam arzı kontrat sahibine verir
    constructor(uint256 _initialSupply) {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
    }

    // Transfer işlevi: Kripto paraları bir adresten diğerine aktarır
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value, "Yetersiz bakiye");
        
        // Transfer işlemini gerçekleştir
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        // Transfer olayını tetikle
        emit Transfer(msg.sender, _to, _value);

        return true;
    }
}
