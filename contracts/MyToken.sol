// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ERC-20 standardı için gerekli işlevleri tanımlayan arayüz (interface)
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    // Transfer ve onay işlemleri için olaylar (events)
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

// MyToken kontratı, ERC-20 standardına uygun olarak geliştirilmiştir
contract MyToken is IERC20 {
    // Token adı
    string public name = "ZHA";
    // Token sembolü
    string public symbol = "ZHA";
    // Ondalık basamak sayısı
    uint8 public decimals = 18;
    // Toplam arz (supply)
    uint256 public override totalSupply;

    // Her adresin bakiyesini saklayan eşleme (mapping)
    mapping(address => uint256) private _balances;
    // Her adresin bir diğer adrese transfer yetkisini saklayan eşleme
    mapping(address => mapping(address => uint256)) private _allowances;

    // Kontrat oluşturulduğunda toplam arz sahibin hesabına atanır
    constructor(uint256 initialSupply) {
        totalSupply = initialSupply * (10 ** uint256(decimals)); // Toplam arz belirlenir
        _balances[msg.sender] = totalSupply; // Tüm token’lar kontratı yaratan hesaba atanır
        emit Transfer(address(0), msg.sender, totalSupply); // Transfer olayı tetiklenir
    }

    // Belirli bir hesabın bakiyesini döndürür
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    // Token transferi işlevi, belirtilen adrese belirtilen miktarda token gönderir
    function transfer(address recipient, uint256 amount) public override returns (bool) {
        require(_balances[msg.sender] >= amount, "Insufficient balance"); // Bakiyeyi kontrol eder
        _balances[msg.sender] -= amount; // Gönderenin bakiyesi azaltılır
        _balances[recipient] += amount; // Alıcının bakiyesi artırılır
        emit Transfer(msg.sender, recipient, amount); // Transfer olayı tetiklenir
        return true;
    }

    // Sahibin belirli bir harcama izni verdiği miktarı döndürür
    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    // Bir adrese (spender) belirli miktarda harcama izni verir
    function approve(address spender, uint256 amount) public override returns (bool) {
        _allowances[msg.sender][spender] = amount; // İzin verilen miktar ayarlanır
        emit Approval(msg.sender, spender, amount); // Onay olayı tetiklenir
        return true;
    }

    // Belirli bir miktarda token’ı bir adresten diğerine transfer eder (izinli işlemler için)
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        require(_balances[sender] >= amount, "Insufficient balance"); // Gönderenin bakiyesini kontrol eder
        require(_allowances[sender][msg.sender] >= amount, "Allowance exceeded"); // Harcama iznini kontrol eder

        _balances[sender] -= amount; // Gönderenin bakiyesi azaltılır
        _balances[recipient] += amount; // Alıcının bakiyesi artırılır
        _allowances[sender][msg.sender] -= amount; // Kullanılan izin miktarı düşürülür

        emit Transfer(sender, recipient, amount); // Transfer olayı tetiklenir
        return true;
    }
}















// pragma solidity ^0.8.0;

// contract MyToken {
//     // Token adı
//     string public name = "MyToken";
//     // Token sembolü (kısaltması)
//     string public symbol = "MTK";
//     // Token'ın ondalık basamak sayısı (standart olarak 18)
//     uint8 public decimals = 18;
//     // Toplam token arzı
//     uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));

//     // Her adresin sahip olduğu token miktarını tutan eşleme (mapping)
//     mapping(address => uint256) public balanceOf;

//     // Constructor: kontrat oluşturulurken çalışır ve tüm tokenları kontratı oluşturan kişiye verir
//     constructor() {
//         balanceOf[msg.sender] = totalSupply;
//     }

//     // Transfer fonksiyonu: Token'ları bir adresten diğerine transfer eder
//     function transfer(address _to, uint256 _value) public returns (bool success) {
//         // Gönderen kişinin bakiyesinin yeterli olup olmadığını kontrol et
//         require(balanceOf[msg.sender] >= _value, "Yetersiz bakiye");

//         // Gönderenin bakiyesinden düş, alıcıya ekle
//         balanceOf[msg.sender] -= _value;
//         balanceOf[_to] += _value;
        
//         // İşlem başarılı olduğunda true döndür
//         return true;
//     }
// }
