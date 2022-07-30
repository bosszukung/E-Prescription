var abi = [
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
