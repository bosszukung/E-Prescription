# E-Prescription using Smart Contract
E-Prescription is a decentralized application (DApp) developed on the Ethereum blockchain using smart contracts. It provides a secure and transparent platform for managing electronic prescriptions between doctors, patients, and pharmacists. This project ensures the integrity of prescription data, automates prescription issuance, and facilitates efficient medication management.

## Smart Contract Overview
The smart contract, implemented in Solidity, consists of the following key features:
### Prescription Form Structure: 
  Defines the structure of prescription data, including details such as the issuing doctor, patient, medication information, dosage, timings, and expiration date.
### Doctor Approval: 
  Allows authorized doctors to issue prescriptions. Only approved doctors (GPs) can create valid prescriptions.
### Pharmacy Permission: 
  Permits pharmacists to view prescriptions, ensuring that medication dispensation is only done by authorized professionals.
### Prescription Issuance and Cancellation: 
  Enables doctors to issue prescriptions, which can be canceled if necessary. Prescriptions cannot be used after their expiration date.
