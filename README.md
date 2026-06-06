# E-Prescription Smart Contract DApp

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
![Solidity](https://img.shields.io/badge/Solidity-%5E0.8.0-blue)
![JavaScript](https://img.shields.io/badge/JavaScript-ES6+-yellow)

A decentralized application (DApp) for secure and transparent electronic prescription management on the Ethereum blockchain.

## 📋 Overview

E-Prescription is a blockchain-based platform that enables:
- **Doctors (GPs)** to issue digital prescriptions securely
- **Patients** to access and manage their medical prescriptions
- **Pharmacists** to verify and dispense medications safely
- **Immutable audit trail** of all prescription transactions

### Key Features

✅ **Decentralized Architecture**: Built on Ethereum blockchain for transparency and security  
✅ **Role-Based Access Control**: Separate roles for doctors, patients, and pharmacists  
✅ **Prescription Expiration**: Automatic validation to prevent use of expired prescriptions  
✅ **Unique Identification**: PIP code system for medication traceability  
✅ **Smart Contract Validation**: Cryptographic verification of all transactions  
✅ **MetaMask Integration**: Easy wallet connection for users  

---

## 🏗️ Smart Contract Architecture

### Contract: `EPrescription`

**Location**: `Contracts/Prescription.sol`

#### Data Structures

```solidity
struct PrescriptionForm {
    address GP;                // Doctor who issued the prescription
    address Patient;           // Patient receiving the prescription
    string PIPcode;           // 7-digit unique medicine traceability code
    string medicationName;    // Scientific medication name
    uint256 dosage;           // Quantity per dose
    string dosageUnit;        // Unit (mg, ml, tablets, etc.)
    uint8 numPills;           // Total number of doses/pills
    uint8 repeat;             // Frequency per day
    string spicificTime;      // Timing (morning, afternoon, evening)
    string BeforeOrAfter;     // Timing relative to meals
    uint256 date;             // Issue timestamp (Epoch)
    uint256 expirationTime;   // Expiry timestamp (Epoch)
}
```

#### Core Functions

| Function | Description | Access Control |
|----------|-------------|----------------|
| `AddPrescrition()` | Create new prescription | Approved doctors only |
| `approved()` | Approve a doctor address | Contract owner only |
| `cancelPrescription()` | Revoke a prescription | Issuing doctor only |
| `giveMedication()` | Log medication dispensation | Approved pharmacists only |
| `permissionPhamacy()` | Check pharmacist permissions | Public view |
| `remove()` | Remove doctor approval | Contract owner only |

#### Modifiers

- `onlyOwner`: Restricts function access to contract owner
- `GPIsApproved()`: Ensures caller is an approved doctor
- `hasNotExpired()`: Validates prescription hasn't expired
- `onlyPrescribedPatient()`: Confirms caller is the intended patient

---

## 🚀 Getting Started

### Prerequisites

- Node.js (v14+)
- MetaMask browser extension
- Ethereum testnet account with test ETH
- Truffle or Hardhat (for contract deployment)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/bosszukung/E-Prescription.git
   cd E-Prescription
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Deploy smart contract**
   ```bash
   truffle compile
   truffle migrate --network rinkeby
   ```

4. **Update contract address**
   - Edit `src/index.html` and update `contractAddress` with your deployed address

5. **Start the application**
   - Open `src/index.html` in your browser
   - Connect MetaMask wallet

---

## 📁 Project Structure

```
E-Prescription/
├── Contracts/
│   ├── Prescription.sol      # Main smart contract
│   └── Migrations            # Migration utilities
├── src/
│   ├── index.html            # Doctor prescription form
│   ├── Login.html            # User authentication UI
│   ├── Test.html             # Testing interface
│   ├── Test.js               # Contract interaction logic
│   ├── abi.js                # Contract ABI (Application Binary Interface)
│   └── style.css             # UI styling
├── Build/                    # Compiled contract artifacts
├── Migrations/               # Deployment scripts
├── truffle-config.js         # Truffle configuration
└── README.md                 # This file
```

---

## 🔒 Security Features

✅ **Access Control Modifiers**: Role-based restrictions on sensitive functions  
✅ **Expiration Validation**: Prevents misuse of expired prescriptions  
✅ **Immutable Records**: All transactions recorded on blockchain  
✅ **Owner Verification**: Only authorized persons can approve doctors  
✅ **Patient Privacy**: Only prescribed patients can access their prescriptions  

---

## 💻 Usage Guide

### For Doctors

1. Connect MetaMask wallet
2. Fill prescription form with patient details
3. Enter medication information and timing
4. Set prescription validity period
5. Submit transaction
6. Prescription recorded on blockchain

### For Pharmacists

1. Connect wallet to DApp
2. Request medication from patient
3. Verify prescription hasn't expired
4. Confirm patient identity
5. Dispense medication

### For Patients

1. Connect wallet to DApp
2. View active prescriptions
3. Share prescription with pharmacist
4. Track prescription history

---

## 🧪 Testing

Test the contract locally:

```bash
# Run Truffle tests
truffle test

# Deploy to local Ganache network
ganache-cli
truffle migrate --network ganache
```

---

## 🌐 Network Deployment

### Supported Networks

- **Ethereum Mainnet**: For production use
- **Sepolia Testnet**: For testing
- **Ganache**: For local development

### Environment Configuration

Update `truffle-config.js` with your network details:

```javascript
module.exports = {
  networks: {
    sepolia: {
      provider: () => new HDWalletProvider(MNEMONIC, INFURA_KEY),
      network_id: 11155111,
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 200,
      skipDryRun: true
    }
  }
};
```

---

## 📊 Transaction Flow

```
1. Doctor connects wallet → Authenticated
   ↓
2. Doctor fills prescription form → Validated
   ↓
3. Submit transaction → Signed by MetaMask
   ↓
4. Smart contract processes → State updated
   ↓
5. Event emitted → PrescriptionAdded
   ↓
6. Patient & Pharmacist notified → Record accessible
```

---

## 🐛 Known Issues & Improvements

### Current Limitations

- ⚠️ Gas optimization needed for production
- ⚠️ Add event indexing for better filtering
- ⚠️ Implement prescription search functionality
- ⚠️ Add multi-signature approval for high-value prescriptions
- ⚠️ Integrate payment gateway for pharmacy fees

### Future Enhancements

- [ ] Mobile application (React Native)
- [ ] Insurance integration
- [ ] Prescription analytics dashboard
- [ ] Multi-language support
- [ ] Two-factor authentication
- [ ] Prescription renewal automation
- [ ] Drug interaction warnings

---

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

---

## 👥 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📧 Contact

**Author**: Aekkaraj K. (bosszukung)  
**Email**: bosszukung@gmail.com  
**GitHub**: [@bosszukung](https://github.com/bosszukung)  

---

## 🙏 Acknowledgments

- OpenZeppelin for secure contract standards
- Ethereum community for blockchain infrastructure
- MetaMask for wallet integration
- Truffle Suite for development tools
