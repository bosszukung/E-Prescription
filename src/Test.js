
// window.addEventListener('load', async () => 
//  { 
//       var contract; 
//     const contractAddress = "0xAD833CF6fd545e722A920fb9e56492Ff48F39e90";
//       const abi = "./abi.js"
//       async function contractMessage() {
//           contract = new web3.eth.Contract(abi, contractAddress);
//       }
//       if (window.ethereum) 
//       {
//           window.web3 = new Web3(ethereum); 
//           try 
//           {
//               await ethereum.enable(); 
//           } 
//           catch (error) 
//           { 

//           }
//           }
//           else
//           { 
//               console.log('Non-Ethereum browser detected. You should consider trying MetaMask!');
//           }      
//   } );
import detectEthereumProvider from '@metamask/detect-provider';
import {ethers} from 'ethers';

const { ethers } = require("ethers");

async function connect() {
    if (typeof window.ethereum !== "undefined") {
        try {
            await ethereum.request({ method: "eth_requestAccounts" });
        } 
        catch (error) {
            console.log(error);
        }
        document.getElementById("connectButton").innerHTML = "Connected";
        const accounts = await ethereum.request({ method: "eth_accounts" });
        console.log(accounts);
    } 
    else {
        document.getElementById("connectButton").innerHTML = "Please install MetaMask";
    }
}

async function execute() {
    if (typeof window.ethereum !== "undefined") {
        const contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138" ;
        const abi = [
            [
                {
                    "inputs": [],
                    "stateMutability": "nonpayable",
                    "type": "constructor"
                },
                {
                    "inputs": [
                        {
                            "internalType": "address",
                            "name": "_Patient",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "_PIPcode",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "_medicationName",
                            "type": "string"
                        },
                        {
                            "internalType": "uint8",
                            "name": "_dosage",
                            "type": "uint8"
                        },
                        {
                            "internalType": "string",
                            "name": "_dosageUnit",
                            "type": "string"
                        },
                        {
                            "internalType": "uint8",
                            "name": "_numPills",
                            "type": "uint8"
                        },
                        {
                            "internalType": "uint8",
                            "name": "_repeat",
                            "type": "uint8"
                        },
                        {
                            "internalType": "string",
                            "name": "_spicificTime",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "_BeforeOrAfter",
                            "type": "string"
                        },
                        {
                            "internalType": "uint256",
                            "name": "_date",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "_expirationTime",
                            "type": "uint256"
                        }
                    ],
                    "name": "AddPrescrition",
                    "outputs": [],
                    "stateMutability": "nonpayable",
                    "type": "function"
                },
                {
                    "inputs": [
                        {
                            "internalType": "address",
                            "name": "",
                            "type": "address"
                        }
                    ],
                    "name": "GP",
                    "outputs": [
                        {
                            "internalType": "bool",
                            "name": "",
                            "type": "bool"
                        }
                    ],
                    "stateMutability": "view",
                    "type": "function"
                },
                {
                    "inputs": [
                        {
                            "internalType": "address",
                            "name": "_GPToApprove",
                            "type": "address"
                        }
                    ],
                    "name": "approved",
                    "outputs": [],
                    "stateMutability": "nonpayable",
                    "type": "function"
                },
                {
                    "inputs": [],
                    "name": "cancelPrescription",
                    "outputs": [],
                    "stateMutability": "view",
                    "type": "function"
                },
                {
                    "inputs": [
                        {
                            "internalType": "address",
                            "name": "",
                            "type": "address"
                        }
                    ],
                    "name": "chemists",
                    "outputs": [
                        {
                            "internalType": "bool",
                            "name": "",
                            "type": "bool"
                        }
                    ],
                    "stateMutability": "view",
                    "type": "function"
                },
                {
                    "inputs": [
                        {
                            "internalType": "address",
                            "name": "_phamacist",
                            "type": "address"
                        }
                    ],
                    "name": "giveMedication",
                    "outputs": [],
                    "stateMutability": "view",
                    "type": "function"
                },
                {
                    "inputs": [
                        {
                            "internalType": "address",
                            "name": "_phamacist",
                            "type": "address"
                        }
                    ],
                    "name": "permissionPhamacy",
                    "outputs": [
                        {
                            "internalType": "bool",
                            "name": "",
                            "type": "bool"
                        }
                    ],
                    "stateMutability": "view",
                    "type": "function"
                },
                {
                    "inputs": [],
                    "name": "prescriptionId",
                    "outputs": [
                        {
                            "internalType": "uint256",
                            "name": "",
                            "type": "uint256"
                        }
                    ],
                    "stateMutability": "view",
                    "type": "function"
                },
                {
                    "inputs": [
                        {
                            "internalType": "uint256",
                            "name": "",
                            "type": "uint256"
                        }
                    ],
                    "name": "prescriptions",
                    "outputs": [
                        {
                            "internalType": "address",
                            "name": "GP",
                            "type": "address"
                        },
                        {
                            "internalType": "address",
                            "name": "Patient",
                            "type": "address"
                        },
                        {
                            "internalType": "string",
                            "name": "PIPcode",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "medicationName",
                            "type": "string"
                        },
                        {
                            "internalType": "uint256",
                            "name": "dosage",
                            "type": "uint256"
                        },
                        {
                            "internalType": "string",
                            "name": "dosageUnit",
                            "type": "string"
                        },
                        {
                            "internalType": "uint8",
                            "name": "numPills",
                            "type": "uint8"
                        },
                        {
                            "internalType": "uint8",
                            "name": "repeat",
                            "type": "uint8"
                        },
                        {
                            "internalType": "string",
                            "name": "spicificTime",
                            "type": "string"
                        },
                        {
                            "internalType": "string",
                            "name": "BeforeOrAfter",
                            "type": "string"
                        },
                        {
                            "internalType": "uint256",
                            "name": "date",
                            "type": "uint256"
                        },
                        {
                            "internalType": "uint256",
                            "name": "expirationTime",
                            "type": "uint256"
                        }
                    ],
                    "stateMutability": "view",
                    "type": "function"
                },
                {
                    "inputs": [
                        {
                            "internalType": "address",
                            "name": "_GPToRemove",
                            "type": "address"
                        }
                    ],
                    "name": "remove",
                    "outputs": [],
                    "stateMutability": "nonpayable",
                    "type": "function"
                }
            ]
        ]
        const provider = new ethers.providers.Web3Provider(window.ethereum);
        const signer = provider.getSigner();
        const contract = new ethers.Contract(contractAddress, abi, signer);
        try {
            await contract.approved().send({from: account})
        } 
        catch (error)
        {
            console.log(error);
        }
    } 
    else {
        document.getElementById("executeButton").innerHTML = "Please install MetaMask";
    }
}

module.exports = {
    connect,
    execute,
}

